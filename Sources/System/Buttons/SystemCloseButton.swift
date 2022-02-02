import UIKit

private enum Symbols: Symbol {
    case xmarkCircleFill
}

public final class SystemCloseButton: Button {
    public override func makeConfiguration() -> UIButton.Configuration? {
        var configuration = Configuration.plain()
        configuration.image = Symbols.xmarkCircleFill
            .font(SystemFonts.medium(22))
            .palette(
                primary: UIColor(light: 0x47474DA3, dark: 0xE8E8F2B0),
                secondary: UIColor(light: 0x73737B1F, dark: 0x75757D3D)
            )
            .image
        configuration.contentInsets = NSDirectionalEdgeInsets(
            horizontal: 5.5,
            vertical: 9
        )

        return configuration
    }

    public override var isHighlighted: Bool {
        didSet {
            animation(duration: 0.25) {
                self.alpha = self.isHighlighted ? 0.5 : 1
            }
        }
    }
}
