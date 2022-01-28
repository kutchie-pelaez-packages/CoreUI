import CoreUtils
import UIKit

extension CGRect {
    public init(
        _ string: String,
        font: UIFont? = nil,
        width: Double = .greatestFiniteMagnitude,
        height: Double = .greatestFiniteMagnitude
    ) {
        let rect = (string as NSString)
            .boundingRect(
                with: CGSize(
                    width: width,
                    height: height
                ),
                options: [
                    .usesLineFragmentOrigin,
                    .usesFontLeading
                ],
                attributes: font == nil ? [:] : [NSAttributedString.Key.font: font!],
                context: nil
            )

        let size = CGSize(
            width: ceil(rect.width),
            height: ceil(rect.height)
        )

        self.init(
            origin: .zero,
            size: size
        )
    }

    public var isNotEmpty: Bool {
        !isEmpty
    }

    public mutating func append(
        dx: Double = 0,
        dy: Double = 0,
        dw: Double = 0,
        dh: Double = 0
    ) {
        origin.x += dx
        origin.y += dy
        size.width += dw
        size.height += dh
    }

    public func appending(
        dx: Double = 0,
        dy: Double = 0,
        dw: Double = 0,
        dh: Double = 0
    ) -> CGRect {
        var result = self
        result.append(
            dx: dx,
            dy: dy,
            dw: dw,
            dh: dh
        )

        return result
    }
}
