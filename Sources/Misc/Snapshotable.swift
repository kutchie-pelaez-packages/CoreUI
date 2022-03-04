import UIKit

public protocol Snapshotable {
    func makeSnapshot() -> UIImage
}

extension Snapshotable where Self: UIView {
    public func makeSnapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image { context in
            layer.render(in: context.cgContext)
        }
    }
}
