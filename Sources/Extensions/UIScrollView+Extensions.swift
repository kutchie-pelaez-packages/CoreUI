import UIKit

extension UIScrollView {
    public var presentationContentOffset: CGPoint {
        if let presentationLayer = layer.presentation() {
            return presentationLayer.bounds.origin
        } else {
            return contentOffset
        }
    }
}
