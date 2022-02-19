import Core
import UIKit

extension UIBarButtonItem {
    public convenience init(
        systemItem: UIBarButtonItem.SystemItem,
        menu: UIMenu? = nil,
        block: Block? = nil
    ) {
        self.init(
            systemItem: systemItem,
            primaryAction: block.isNotNil ? UIAction { _ in
                block?()
            } : nil,
            menu: menu
        )
    }

    public convenience init(
        title: String? = nil,
        image: UIImage? = nil,
        style: UIBarButtonItem.Style = .plain,
        menu: UIMenu? = nil,
        block: Block? = nil
    ) {
        if let image = image {
            self.init(
                image: image,
                style: style,
                target: nil,
                action: nil
            )
        } else if let title = title {
            self.init(
                title: title,
                style: style,
                target: nil,
                action: nil
            )
        } else {
            self.init()
        }

        if let block = block {
            let blockRetainer = BlockRetainer(
                attachTo: self,
                block: block
            )
            self.target = blockRetainer
            self.action = #selector(blockRetainer.invoke)
        } else if let menu = menu {
            self.menu = menu
        }
    }
}
