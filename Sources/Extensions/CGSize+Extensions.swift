import Core
import UIKit

extension CGSize {
    public init(
        _ string: String,
        font: UIFont? = nil,
        width: Double = .greatestFiniteMagnitude,
        height: Double = .greatestFiniteMagnitude
    ) {
        self = CGRect(
            string,
            font: font,
            width: width,
            height: height
        ).size
    }

    public init(_ length: Double) {
        self.init(
            width: length,
            height: length
        )
    }

    public var longestSide: Double {
        max(width, height)
    }

    public var shortestSide: Double {
        max(width, height)
    }

    public mutating func append(
        dw: Double = 0,
        dh: Double = 0
    ) {
        width += dw
        height += dh
    }

    public func appending(
        dw: Double = 0,
        dh: Double = 0
    ) -> CGSize {
        var result = self
        result.append(
            dw: dw,
            dh: dh
        )

        return result
    }

    @inlinable
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        lhs.appending(
            dw: rhs.width,
            dh: rhs.height
        )
    }

    @inlinable
    public static func += (lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs + rhs
    }
}
