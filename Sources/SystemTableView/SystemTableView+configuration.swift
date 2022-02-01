import UIKit

private func mutate(
    _ contentConfiguration: inout UIListContentConfiguration,
    using row: SystemTableView.SystemRow
) {
    contentConfiguration.text = row.content.title.text

    if let titleFont = row.content.title.font {
        contentConfiguration.textProperties.font = titleFont
    }

    if let titleColor = row.content.title.color {
        contentConfiguration.textProperties.color = titleColor
    }

    if let titleAlignment = row.content.title.alignment {
        contentConfiguration.textProperties.alignment = titleAlignment
    }

    if let subtitle = row.content.subtitle {
        contentConfiguration.secondaryText = subtitle.text
    }

    if let subtitleFont = row.content.subtitle?.font {
        contentConfiguration.secondaryTextProperties.font = subtitleFont
    }

    if let subtitleColor = row.content.subtitle?.color {
        contentConfiguration.secondaryTextProperties.color = subtitleColor
    }

    if let leadingContent = row.leadingContent {
        switch leadingContent {
        case let .image(image):
            contentConfiguration.image = image.image

            contentConfiguration.imageProperties.cornerRadius = image.corners.value

            if let maximumSize = image.maximumSize {
                contentConfiguration.imageProperties.maximumSize = maximumSize
            }
        }
    }
}

private func setAccessory(
    for cell: UITableViewCell,
    using systemRow: SystemTableView.SystemRow
) {
    cell.accessoryType = .none
    cell.accessoryView = nil

    if let trailingContent = systemRow.trailingContent {
        switch trailingContent {
        case .checkmark:
            cell.accessoryType = .checkmark

        case .detailButton:
            cell.accessoryType = .detailButton

        case .detailDisclosureButton:
            cell.accessoryType = .detailDisclosureButton

        case .disclosureIndicator:
            cell.accessoryType = .disclosureIndicator

        case let .customView(view):
            cell.accessoryView = view
        }
    }
}

extension SystemTableView {
    func configureSystemCell(_ cell: UITableViewCell, using systemRow: SystemRow) {
        var contentConfiguration = cell.defaultContentConfiguration()
        defer { cell.contentConfiguration = contentConfiguration }

        mutate(
            &contentConfiguration,
            using: systemRow
        )

        setAccessory(
            for: cell,
            using: systemRow
        )
    }

    func configureSystemHeader(_ header: UITableViewHeaderFooterView, using systemHeader: SystemHeader) {
        var contentConfiguration = header.defaultContentConfiguration()
        defer { header.contentConfiguration = contentConfiguration }

        var attributes = [NSAttributedString.Key: Any]()

        if let font = systemHeader.font {
            attributes[.font] = font
        }

        if let color = systemHeader.color {
            attributes[.foregroundColor] = color
        }

        if attributes.isNotEmpty {
            contentConfiguration.attributedText = NSAttributedString(
                string: systemHeader.string,
                attributes: attributes
            )
        } else {
            contentConfiguration.text = systemHeader.string
        }
    }

    func configureSystemFooter(_ footer: UITableViewHeaderFooterView, using systemFooter: SystemFooter) {
        var contentConfiguration = footer.defaultContentConfiguration()
        defer { footer.contentConfiguration = contentConfiguration }

        contentConfiguration.text = systemFooter.string

        if let footerAlignment = systemFooter.alignment {
            contentConfiguration.textProperties.alignment = footerAlignment
        }
    }
}
