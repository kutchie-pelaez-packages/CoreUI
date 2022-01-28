import UIKit

extension UIControl.Event {
    public static var onHover: UIControl.Event {
        [
            .touchDown,
            .touchDragEnter,
        ]
    }

    public static var onUnhover: UIControl.Event {
        [
            .touchCancel,
            .touchDragExit,
            .touchUpInside,
        ]
    }
}
