import UIKit

extension UIViewController {
    public var topPresentedViewController: UIViewController? {
        presentedViewController?.topPresentedViewController ?? self
    }

    public var flattenTree: [UIViewController] {
        var stack = [presentedViewController].compactMap { $0 } + children.reversed()
        var visited = [Int]()
        var result = [UIViewController]()

        while stack.isNotEmpty {
            let poppedController = stack.removeLast()
            stack += poppedController.children.reversed()
            stack.insert(contentsOf: [poppedController.presentedViewController].compactMap { $0 }, at: 0)
            if visited.contains(poppedController.hashValue) {
                continue
            } else {
                result.append(poppedController)
                visited.append(poppedController.hashValue)
            }
        }

        return result
    }

    public var flattenTreeWithSelf: [UIViewController] {
        [self] + flattenTree
    }

    public func isRootOfChild(_ view: UIView) -> Bool {
        children
            .map { $0.view }
            .filter { $0 === view }
            .isNotEmpty
    }

    public func addChildViewController(_ childViewController: UIViewController) {
        childViewController.willMove(toParent: self)
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }

    public func removeFromParentViewController() {
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
        didMove(toParent: nil)
    }
}
