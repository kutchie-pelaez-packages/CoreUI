import UIKit

extension UILayoutGuide {
    public convenience init(owningView: UIView) {
        self.init()
        owningView.addLayoutGuide(self)
    }
}
