import UIKit
import Core

extension UINavigationController {
    public convenience init(
        rootViewController: UIViewController,
        hideNavigationBar: Bool
    ) {
        self.init(rootViewController: rootViewController)

        setNavigationBarHidden(
            hideNavigationBar,
            animated: false
        )
    }

    public func pushViewController(
        _ viewController: UIViewController,
        animated: Bool,
        completion: @escaping Block
    ) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)

        pushViewController(
            viewController,
            animated: animated
        )

        CATransaction.commit()
    }

    @discardableResult
    public func popViewController(
        animated: Bool,
        completion: @escaping Block
    ) -> UIViewController? {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        let poppedViewController = popViewController(animated: animated)
        CATransaction.commit()

        return poppedViewController
    }
}
