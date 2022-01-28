import UIKit
import Core

extension UIMenu {
    public static func inlineSection(
        title: String? = nil,
        subtitle: String? = nil,
        image: UIImage? = nil,
        identifier: Identifier? = nil,
        children: [UIMenuElement]
    ) -> UIMenu {
        UIMenu(
            title: title.orEmpty,
            subtitle: subtitle,
            image: image,
            identifier: identifier,
            options: .displayInline,
            children: children
        )
    }

    public static func inlineSection(
        title: String? = nil,
        subtitle: String? = nil,
        image: UIImage? = nil,
        identifier: Identifier? = nil,
        children: UIMenuElement...
    ) -> UIMenu {
        .inlineSection(
            title: title,
            subtitle: subtitle,
            image: image,
            identifier: identifier,
            children: children
        )
    }

    public static func foldedSection(
        title: String? = nil,
        subtitle: String? = nil,
        image: UIImage? = nil,
        identifier: Identifier? = nil,
        children: UIMenuElement...
    ) -> UIMenu {
        UIMenu(
            title: title.orEmpty,
            subtitle: subtitle,
            image: image,
            identifier: identifier,
            options: .empty,
            children: children
        )
    }
}
