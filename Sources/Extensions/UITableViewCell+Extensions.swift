import UIKit

extension UITableViewCell {
    public static var reusableIdentifier: String {
        String(describing: self)
    }
}
