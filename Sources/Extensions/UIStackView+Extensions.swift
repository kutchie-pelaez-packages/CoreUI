import UIKit

extension UIStackView {
    public func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }

    public func addArrangedSubviews(_ views: UIView...) {
        addArrangedSubviews(views)
    }

    public func removeArrangedSubviews(_ views: [UIView]) {
        for view in views {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    public func removeArrangedSubviews(_ views: UIView...) {
        removeArrangedSubviews(views)
    }

    public func removeAllArrangedSubviews() {
        removeArrangedSubviews(arrangedSubviews)
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
