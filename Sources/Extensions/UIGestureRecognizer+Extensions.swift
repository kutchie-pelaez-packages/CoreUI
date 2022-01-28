import UIKit
import Core

extension UIGestureRecognizer {
    convenience init(action: @escaping (UIGestureRecognizer) -> Void) {
        self.init()
        addAction { [weak self] in
            guard let self = self else { return }

            action(self)
        }
    }

    public func addAction(_ block: @escaping Block) {
        let blockWrapper = BlockRetainer(
            attachTo: self,
            block: block
        )
        addTarget(
            blockWrapper,
            action: #selector(BlockRetainer.invoke)
        )
    }
}

extension UIPanGestureRecognizer {
    public convenience init(_ action: @escaping (UIPanGestureRecognizer) -> Void) {
        self.init { gesture in
            guard let pan = gesture as? UIPanGestureRecognizer else { return }

            action(pan)
        }
    }
}

extension UISwipeGestureRecognizer {
    public convenience init(_ action: @escaping (UISwipeGestureRecognizer) -> Void) {
        self.init { gesture in
            guard let swipe = gesture as? UISwipeGestureRecognizer else { return }

            action(swipe)
        }
    }
}

extension UIRotationGestureRecognizer {
    public convenience init(_ action: @escaping (UIRotationGestureRecognizer) -> Void) {
        self.init { gesture in
            guard let rotation = gesture as? UIRotationGestureRecognizer else { return }

            action(rotation)
        }
    }
}

extension UIPinchGestureRecognizer {
    public convenience init(_ action: @escaping (UIPinchGestureRecognizer) -> Void) {
        self.init { gesture in
            guard let pinch = gesture as? UIPinchGestureRecognizer else { return }

            action(pinch)
        }
    }
}

extension UITapGestureRecognizer {
    public convenience init(_ action: @escaping (UITapGestureRecognizer) -> Void) {
        self.init { gesture in
            guard let tap = gesture as? UITapGestureRecognizer else { return }

            action(tap)
        }
    }
}

extension UILongPressGestureRecognizer {
    public convenience init(_ action: @escaping (UILongPressGestureRecognizer) -> Void) {
        self.init { gesture in
            guard let longPress = gesture as? UILongPressGestureRecognizer else { return }

            action(longPress)
        }
    }
}
