import Core
import UIKit

extension UICollectionView {
    public func register<T: UICollectionViewCell>(cellClass: T.Type) {
        register(
            cellClass,
            forCellWithReuseIdentifier: T.reusableIdentifier
        )
    }

    public func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(
            withReuseIdentifier: T.reusableIdentifier,
            for: indexPath
        ) as? T {
            return cell
        } else {
            crash("Cell for (\(T.reusableIdentifier)) identifier is not registered")
        }
    }
}
