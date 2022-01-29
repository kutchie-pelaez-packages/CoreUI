import Core
import UIKit

open class RootedViewController<Root>:
    ViewController
    where
    Root: RootView
{

    open override func loadView() {
        view = Root()
    }

    public var rootView: Root {
        view as! Root
    }
}

open class RootView:
    View,
    EmptyInitable
{

    public required override init() {
        super.init()
    }
}
