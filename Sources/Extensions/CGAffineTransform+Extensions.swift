import CoreUtils
import CoreGraphics

extension CGAffineTransform {
    public init(scale: Double) {
        self.init(
            scaleX: scale,
            y: scale
        )
    }

    public var scale: Double {
        sqrt(a * a + c * c)
    }

    public var rotation: Double {
        atan2(b, a)
    }

    public var translation: CGPoint {
        CGPoint(
            x: tx,
            y: ty
        )
    }
}
