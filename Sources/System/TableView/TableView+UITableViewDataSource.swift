import UIKit
import Core

extension System.TableView: UITableViewDataSource {
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
            configureSystemCell(systemCell, using: systemRow)
            cell = systemCell

        case let .custom(customRow):
            let cellClass = undefinedIfNil(
                customRow.type as? UITableViewCell.Type,
                "Failed to get type info from \(customRow.type)"
            )
            let customCell = tableView.dequeueReusableCell(withIdentifier: cellClass.reusableIdentifier, for: indexPath)
            customRow.transformer?(customCell)
            cell = customCell
        }

        return cell
    }
}
