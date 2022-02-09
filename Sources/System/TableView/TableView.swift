import Core
import UIKit

extension System {
    public final class TableView: UITableView {
        public convenience init() {
            self.init(style: .insetGrouped)
            setup()
        }

        public convenience init(style: UITableView.Style) {
            self.init(frame: .zero, style: style)
            setup()
        }

        public override init(frame: CGRect, style: UITableView.Style) {
            super.init(frame: frame, style: style)
            setup()
        }

        required init?(coder: NSCoder) {
            crash()
        }

        // MARK: - Public interface

        public var state = State(sections: []) {
            didSet {
                registerCellsIfNeeded()
                reloadData()
            }
        }

        // MARK: -

        private func setup() {
            dataSource = self
            delegate = self
            register(cellClass: UITableViewCell.self)
            register(cellClass: ViewCell.self)
            register(headerFooterClass: UITableViewHeaderFooterView.self)
        }

        private func registerCellsIfNeeded() {
            for row in state.sections.flatMap({ $0.rows }) {
                guard case let .custom(customRow) = row else { continue }

                let cellClass = undefinedIfNil(
                    customRow.type as? UITableViewCell.Type,
                    "Failed to get type info from \(customRow.type)"
                )

                register(
                    cellClass,
                    forCellReuseIdentifier: cellClass.reusableIdentifier
                )
            }
        }
    }
}
