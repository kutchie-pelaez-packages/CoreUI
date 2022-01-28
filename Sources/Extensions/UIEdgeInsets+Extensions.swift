import UIKit

extension UIEdgeInsets {
    public init(all: Double) {
        self.init(
            top: all,
            left: all,
            bottom: all,
            right: all
        )
    }

    public init(
        top: Double = 0,
        bottom: Double = 0,
        left: Double = 0,
        right: Double = 0
    ) {
        self.init(
            top: top,
            left: left,
            bottom: bottom,
            right: right
        )
    }

    public init(
        horizontal: Double = 0,
        vertical: Double = 0
    ) {
        self.init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }

    public var horizontal: Double {
        left + right
    }

    public var vertical: Double {
        top + bottom
    }
}
