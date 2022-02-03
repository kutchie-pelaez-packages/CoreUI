import Core
import UIKit

extension System.TableView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let stateSection = state.sections[safe: section],
            let systemHeader = stateSection.header
        else {
            return nil
        }

        let header: UITableViewHeaderFooterView = tableView.dequeueHeaderFooter(for: section)
        configureSystemHeader(header, using: systemHeader)

        return header
    }

    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard
            let stateSection = state.sections[safe: section],
            let systemFooter = stateSection.footer
        else {
            return nil
        }

        let footer: UITableViewHeaderFooterView = tableView.dequeueHeaderFooter(for: section)
        configureSystemFooter(footer, using: systemFooter)

        return footer
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
            return systemRow.action.isNotNil && systemRow.enabled

        case let .custom(customRow):
            return customRow.action.isNotNil

        case let .view(viewRow):
            return viewRow.action.isNotNil
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let section = state.sections[safe: indexPath.section],
            let row = section.rows[safe: indexPath.row]
        else {
            appFatalError("Failed to access row at \(indexPath)")
        }

        tableView.deselectRow(
            at: indexPath,
            animated: true
        )

        switch row {
        case let .system(systemRow):
            systemRow.action?()

        case let .custom(customRow):
            customRow.action?()

        case let .view(viewRow):
            viewRow.action?()
        }
    }
}
