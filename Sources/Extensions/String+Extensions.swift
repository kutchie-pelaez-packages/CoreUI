import UIKit

extension String {
    public func rect(
        font: UIFont? = nil,
        width: Double = .greatestFiniteMagnitude,
        height: Double = .greatestFiniteMagnitude
    ) -> CGRect {
        CGRect(
            self,
            font: font,
            width: width,
            height: height
        )
    }

    public func size(
        font: UIFont? = nil,
        width: Double = .greatestFiniteMagnitude,
        height: Double = .greatestFiniteMagnitude
    ) -> CGSize {
        rect(
            font: font,
            width: width,
            height: height
        ).size
    }
}
