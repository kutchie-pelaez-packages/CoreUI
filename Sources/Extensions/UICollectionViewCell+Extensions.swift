import UIKit

extension UICollectionViewCell {
    public static var reusableIdentifier: String {
        String(describing: self)
    }
}
