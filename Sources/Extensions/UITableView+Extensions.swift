import Core
import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(cellClass: T.Type) {
        register(
            cellClass,
            forCellReuseIdentifier: T.reusableIdentifier
        )
    }

    public func register<T: UITableViewHeaderFooterView>(headerFooterClass: T.Type) {
        register(
            headerFooterClass,
            forHeaderFooterViewReuseIdentifier: T.reusableIdentifier
        )
    }

    public func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(
            withIdentifier: T.reusableIdentifier,
            for: indexPath
        ) as? T {
            return cell
        } else {
            appFatalError("Cell for (\(T.reusableIdentifier)) identifier is not registered")
        }
    }

    public func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(for section: Int) -> T {
        if let headerFooter = dequeueReusableHeaderFooterView(
            withIdentifier: T.reusableIdentifier
        ) as? T {
            return headerFooter
        } else {
            appFatalError("HeaderFooter for (\(T.reusableIdentifier)) identifier is not registered")
        }
    }
}
