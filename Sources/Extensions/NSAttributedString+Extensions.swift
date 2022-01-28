import UIKit
import CoreUtils

extension NSAttributedString {
    public func size(
        width: Double = .greatestFiniteMagnitude,
        height: Double = .greatestFiniteMagnitude
    ) -> CGSize {
        guard !string.isEmpty else { return .zero }

        let rect = boundingRect(
            with: CGSize(
                width: width,
                height: height
            ),
            options: [
                .usesLineFragmentOrigin,
                .usesFontLeading
            ],
            context: nil
        )

        return safeUndefinedIf(
            !hasFontAttribute,
            CGSize(
                width: ceil(rect.width),
                height: ceil(rect.height)
            ),
            "Failed to get size - string doesn't contain font attribute"
        )
    }

    public func height(for width: Double) -> Double {
        size(width: width).height
    }

    public func width(for height: Double) -> Double {
        size(height: height).width
    }

    private var hasFontAttribute: Bool {
        guard !string.isEmpty else { return false }

        let attribute = attribute(
            .font,
            at: 0,
            effectiveRange: nil
        )
        let font = attribute as? UIFont

        return font != nil
    }
}
