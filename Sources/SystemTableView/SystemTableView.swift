import Core
import UIKit

public final class SystemTableView:
    UITableView,
    UITableViewDataSource,
    UITableViewDelegate
{

    public init() {
        super.init(frame: .zero, style: .insetGrouped)
        setup()
    }

    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }

    required init?(coder: NSCoder) {
        appFatalError()
    }

    private func setup() {
        dataSource = self
        delegate = self
        register(cellClass: UITableViewCell.self)
        register(headerFooterClass: UITableViewHeaderFooterView.self)
    }

    public var state = State(sections: []) {
        didSet {
            registerCells()
            reloadData()
        }
    }

    // MARK: -

    private func registerCells() {
        for row in state.sections.flatMap({ $0.rows }) {
            guard case let .custom(customRow) = row else { continue }

            let cellClass = undefinedIfNil(
                customRow.type as? UITableViewCell.Type,
                "Failed to get type info from \(customRow.type)"
            )
            register(cellClass, forCellReuseIdentifier: cellClass.reusableIdentifier)
        }
    }

    private func configureSystemCell(_ cell: UITableViewCell, with row: SystemRow) {
        var contentConfiguration = cell.defaultContentConfiguration()
        defer {
            cell.contentConfiguration = contentConfiguration
        }

        contentConfiguration.text = row.content.title.string
        if let titleFont = row.content.title.font {
            contentConfiguration.textProperties.font = titleFont
        }
        if let titleColor = row.content.title.color {
            contentConfiguration.textProperties.color = titleColor
        }
        if let titleAlignment = row.content.title.alignment {
            switch titleAlignment {
            case .natural:
                contentConfiguration.textProperties.alignment = .natural

            case .justified:
                contentConfiguration.textProperties.alignment = .justified

            case .center:
                contentConfiguration.textProperties.alignment = .center
            }
        }

        if let subtitle = row.content.subtitle {
            contentConfiguration.secondaryText = subtitle.string
            if let subtitleFont = row.content.title.font {
                contentConfiguration.secondaryTextProperties.font = subtitleFont
            }
            if let subtitleColor = row.content.subtitle?.color {
                contentConfiguration.secondaryTextProperties.color = subtitleColor
            }
        }

        if let leadingContent = row.leadingContent {
            switch leadingContent {
            case let .image(imageConfiguration):
                contentConfiguration.image = imageConfiguration.image
                if let corners = imageConfiguration.corners {
                    switch corners {
                    case let .rounded(value):
                        contentConfiguration.imageProperties.cornerRadius = value
                    }
                }
                if let maximumSize = imageConfiguration.maximumSize {
                    contentConfiguration.imageProperties.maximumSize = maximumSize
                }
            }
        }

        cell.accessoryType = .none
        cell.accessoryView = nil
        if let trailingContent = row.trailingContent {
            switch trailingContent {
            case .checkmark:
                cell.accessoryType = .checkmark

            case .detailButton:
                cell.accessoryType = .detailButton

            case .detailDisclosureButton:
                cell.accessoryType = .detailDisclosureButton

            case .disclosureIndicator:
                cell.accessoryType = .disclosureIndicator

            case let .view(view):
                cell.accessoryView = view
            }
        }
    }

    // MARK: - UITableViewDataSource

    public func numberOfSections(in tableView: UITableView) -> Int {
        state.sections.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = state.sections[safe: section] else {
            return safeUndefined(
                0,
                "Failed to get section state for \(section) state"
            )
        }

        return section.rows.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let section = state.sections[safe: indexPath.section],
            let row = section.rows[safe: indexPath.row]
        else {
            appFatalError("Failed to access row at \(indexPath)")
        }

        let cell: UITableViewCell

        switch row {
        case let .system(systemRow):
            let systemCell: UITableViewCell = tableView.dequeueCell(for: indexPath)
            configureSystemCell(systemCell, with: systemRow)
            cell = systemCell

        case let .custom(customRow):
            let cellClass = undefinedIfNil(
                customRow.type as? UITableViewCell.Type,
                "Failed to get type info from \(customRow.type)"
            )
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellClass.reusableIdentifier, for: indexPath)
            customRow.transformer(customCell)
            cell = customCell
        }

        return cell
    }

    // MARK: - UITableViewDelegate

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let stateSection = state.sections[safe: section],
            let header = stateSection.header
        else {
            return nil
        }

        let headerView: UITableViewHeaderFooterView = tableView.dequeueHeaderFooter(for: section)
        var contentConfiguration = headerView.defaultContentConfiguration()
        defer {
            headerView.contentConfiguration = contentConfiguration
        }

        var attributes = [NSAttributedString.Key: Any]()

        if let font = header.font {
            attributes[.font] = font
        }
        if let color = header.color {
            attributes[.foregroundColor] = color
        }

        if attributes.isNotEmpty {
            contentConfiguration.attributedText = NSAttributedString(
                string: header.string,
                attributes: attributes
            )
        } else {
            contentConfiguration.text = header.string
        }

        return headerView
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard
            let stateSection = state.sections[safe: section],
            let footer = stateSection.footer
        else {
            return nil
        }

        let footerView: UITableViewHeaderFooterView = tableView.dequeueHeaderFooter(for: section)
        var contentConfiguration = footerView.defaultContentConfiguration()
        defer {
            footerView.contentConfiguration = contentConfiguration
        }

        contentConfiguration.text = footer.string
        if let footerAlignment = footer.alignment {
            switch footerAlignment {
            case .natural:
                contentConfiguration.textProperties.alignment = .natural

            case .justified:
                contentConfiguration.textProperties.alignment = .justified

            case .center:
                contentConfiguration.textProperties.alignment = .center
            }
        }

        return footerView
    }

    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        guard
            let section = state.sections[safe: indexPath.section],
            let row = section.rows[safe: indexPath.row]
        else {
            appFatalError("Failed to access row at \(indexPath)")
        }

        switch row {
        case let .system(systemRow):
            return systemRow.action != nil && systemRow.enabled

        case .custom:
            return false
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(
            at: indexPath,
            animated: true
        )

        guard
            let section = state.sections[safe: indexPath.section],
            let row = section.rows[safe: indexPath.row]
        else {
            appFatalError("Failed to access row at \(indexPath)")
        }

        switch row {
        case let .system(systemRow):
            systemRow.action?()

        case .custom:
            return
        }
    }
}
