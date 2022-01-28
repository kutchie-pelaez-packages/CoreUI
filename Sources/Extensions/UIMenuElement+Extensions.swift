import UIKit
import CoreUtils

extension UIMenuElement {
    public static func action(
        title: String? = nil,
        subtitle: String? = nil,
        image: UIImage? = nil,
        identifier: UIAction.Identifier? = nil,
        discoverabilityTitle: String? = nil,
        attributes: UIMenuElement.Attributes = [],
        state: UIMenuElement.State = .off,
        action: Block? = nil
    ) -> UIMenuElement {
        UIAction(
            title: title.orEmpty,
            subtitle: subtitle,
            image: image,
            identifier: identifier,
            discoverabilityTitle: discoverabilityTitle,
            attributes: attributes,
            state: state,
            handler: { _ in
                action?()
            }
        )
    }
}
