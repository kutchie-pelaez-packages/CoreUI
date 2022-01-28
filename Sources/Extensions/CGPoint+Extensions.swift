import Core
import CoreGraphics

extension CGPoint {
    public mutating func append(
        dx: Double = 0,
        dy: Double = 0
    ) {
        x += dx
        y += dy
    }

    public func appending(
        dx: Double = 0,
        dy: Double = 0
    ) -> CGPoint {
        var result = self
        result.append(dx: dx, dy: dy)

        return result
    }

    public func distance(to anotherPoint: CGPoint) -> Double {
        sqrt(
            pow(x - anotherPoint.x, 2) +
            pow(y - anotherPoint.y, 2)
        )
    }

    // https://en.wikipedia.org/wiki/Distance_from_a_point_to_a_line
    public func distance(
        toLineSegment l1: CGPoint,
        and l2: CGPoint,
        alwaysPositive: Bool = true
    ) -> Double {
        let x0 = x
        let x1 = l1.x
        let x2 = l2.x
        let y0 = y
        let y1 = l1.y
        let y2 = l2.y

        let distance =  ((y2 - y1) * x0 - (x2 - x1) * y0 + x2 * y1 - y2 * x1) / sqrt((y2 - y1) * (y2 - y1) + (x2 - x1) * (x2 - x1))

        return alwaysPositive ? abs(distance) : distance
    }

    public func angle(to comparisonPoint: CGPoint) -> Double {
        let originX = comparisonPoint.x - x
        let originY = comparisonPoint.y - y
        let radians = atan2f(
            Float(originY),
            Float(originX)
        )

        return Double(radians)
    }

    @inlinable
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        lhs.appending(
            dx: rhs.x,
            dy: rhs.y
        )
    }

    @inlinable
    public static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
}
