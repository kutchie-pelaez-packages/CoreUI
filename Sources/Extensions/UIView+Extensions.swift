import UIKit

extension UIView {
    public var presentationLayer: CALayer {
        layer.presentation() ?? layer
    }

    public var isVisible: Bool {
        get {
            !isHidden
        } set {
            isHidden = !newValue
        }
    }

    public var flattenTree: [UIView] {
        let subviewsInTreeBelow = subviews
            .compactMap { $0.subviews.isNotEmpty ? $0.flattenTree : nil }
            .flatMap { $0 }

        return subviews + subviewsInTreeBelow
    }

    public var viewController: UIViewController? {
        var nextResponder: UIResponder? = next

        while nextResponder != nil {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            nextResponder = nextResponder?.next
        }

        return nil
    }

    public func addSubviews(_ subviews: [UIView?]) {
        for subview in subviews.compactMap({ $0 }) {
            addSubview(subview)
        }
    }

    public func addSubviews(_ subviews: UIView?...) {
        addSubviews(subviews)
    }

    public func bringSubviewsToFront(_ subviews: [UIView?]) {
        for subview in subviews.compactMap({ $0 }) {
            bringSubviewToFront(subview)
        }
    }

    public func bringSubviewsToFront(_ subviews: UIView?...) {
        bringSubviewsToFront(subviews)
    }

    public func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    @objc open func makeSnapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}
