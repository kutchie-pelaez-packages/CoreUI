import UIKit

extension NSDirectionalEdgeInsets {
    public init(all: Double) {
        self.init(
            top: all,
            leading: all,
            bottom: all,
            trailing: all
        )
    }

    public init(
        top: Double = 0,
        bottom: Double = 0,
        leading: Double = 0,
        trailing: Double = 0
    ) {
        self.init(
            top: top,
            leading: leading,
            bottom: bottom,
            trailing: trailing
        )
    }

    public init(
        horizontal: Double = 0,
        vertical: Double = 0
    ) {
        self.init(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
    }
}
