import Core
import UIKit
import Wording

open class RootedWordingViewController<Root, Wording>:
    WordingViewController<Wording>
    where
    Root: RootView,
    Wording: Wordingable
{

    open override func loadView() {
        view = Root()
    }

    public var rootView: Root {
        view as! Root
    }
}
