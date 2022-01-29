import UIKit

private let defaultDimension: Double = 0.5

public final class Separator: View {
    public enum Style {
        case vertical(Double)
        case horizontal(Double)

        public static var vertical: Self {
            .vertical(defaultDimension)
        }

        public static var horizontal: Self {
            .horizontal(defaultDimension)
        }
    }

    public enum Color {
        case regular
        case opaque

        fileprivate var uiColor: UIColor {
            switch self {
            case .regular:
                return .separator

            case .opaque:
                return .opaqueSeparator
            }
        }
    }

    public init(
        _ style: Style,
        color: Color = .regular
    ) {
        self.style = style
        self.color = color
        super.init()
    }

    public init(
        width: Double,
        color: Color = .regular
    ) {
        self.style = .vertical(width)
        self.color = color
        super.init()
    }

    public init(
        height: Double,
        color: Color = .regular
    ) {
        self.style = .horizontal(height)
        self.color = color
        super.init()
    }

    private let style: Style
    private let color: Color

    // MARK: - UI

    public override func configureViews() {
        backgroundColor = color.uiColor
    }

    public override var intrinsicContentSize: CGSize {
        let width: Double?
        let height: Double?
        switch style {
        case let .vertical(value):
            width = value
            height = nil

        case let .horizontal(value):
            width = nil
            height = value
        }

        return CGSize(
            width: width ?? UIView.noIntrinsicMetric,
            height: height ?? UIView.noIntrinsicMetric
        )
    }
}
