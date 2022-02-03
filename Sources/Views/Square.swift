import UIKit

public final class Square: View {
    public init(
        size: CGSize = CGSize(100),
        color: UIColor = System.Colors.Tint.primary
    ) {
        self.size = size
        self.color = color
        super.init()
    }

    private let size: CGSize
    private let color: UIColor

    public override func configureViews() {
        backgroundColor = color
    }

    public override var intrinsicContentSize: CGSize {
        size
    }
}
