import UIKit

private let size = CGSize(22)

private enum Symbols: SymbolsCollection {
    case checkmark
}

public final class Checkmark: View {
    public struct Colors {
        public var checkmark: UIColor
        public var background: Background
        public var border: Border

        public struct Background {
            var selected: UIColor
            var unselected: UIColor
        }

        public struct Border {
            var selected: UIColor
            var unselected: UIColor
        }
    }

    public var isSelected = false {
        didSet {
            syncUI()
        }
    }

    public var colors = Colors(
        checkmark: System.Colors.Tint.white,
        background: Colors.Background(
            selected: System.Colors.Tint.primary,
            unselected: .clear
        ),
        border: Colors.Border(
            selected: .clear,
            unselected: System.Colors.Label.tertiary
        )
    ) {
        didSet {
            syncUI()
        }
    }

    // MARK: - UI

    private var icon: UIImageView!

    public override func configureViews() {
        layer.borderWidth = 1.5

        icon = UIImageView()
        addSubviews(icon)
    }

    public override func constraintViews() {
        icon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    public override func postSetup() {
        syncUI()
    }

    public override func subviewsDidLayout() {
        layer.cornerRadius = frame.width / 2
    }

    public override func userInterfaceStyleDidChange(from previousStyle: UIUserInterfaceStyle, to newStyle: UIUserInterfaceStyle) {
        syncUI()
    }

    public override var intrinsicContentSize: CGSize {
        size
    }

    private func syncUI() {
        backgroundColor = isSelected ? colors.background.selected : colors.background.unselected
        layer.borderColor = (isSelected ? colors.border.selected : colors.border.unselected).cgColor

        icon.isVisible = isSelected
        icon.image = Symbols.checkmark
            .font(System.Fonts.regular(12))
            .monochrome(colors.checkmark)
            .image
    }
}
