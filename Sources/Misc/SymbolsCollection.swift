import Core
import UIKit

// MARK: - Symbol

public protocol SymbolsCollection: SymbolChainable {
    var systemName: String { get }
}

extension SymbolsCollection {
    public var systemName: String {
        String(describing: self)
            .camelCaseChunks
            .map { $0.lowercased() }
            .joined(separator: ".")
    }
}

extension SymbolsCollection {
    public var image: UIImage {
        safeUndefinedIfNil(
            UIImage(systemName: systemName),
            UIImage(),
            "Failed to get image for \(systemName) system name"
        )
    }
}

// MARK: - SymbolLink

private struct SymbolLink: SymbolChainable {
    let image: UIImage
}

// MARK: - SymbolChain

public protocol SymbolChainable {
    var image: UIImage { get }
}

extension SymbolChainable {
    private func applying(_ otherConfiguration: UIImage.SymbolConfiguration) -> SymbolChainable {
        let newImage: UIImage
        if let previuosSymbolConfiguration = image.symbolConfiguration {
            newImage = image.withConfiguration(
                previuosSymbolConfiguration.applying(otherConfiguration)
            )
        } else {
            newImage = image
        }

        return SymbolLink(image: newImage)
    }

    public func monochrome(_ color: UIColor) -> SymbolChainable {
        palette(
            primary: color,
            secondary: color,
            tertiary: color
        )
    }

    public func hierarchical(_ color: UIColor) -> SymbolChainable {
        applying(
            UIImage.SymbolConfiguration(
                hierarchicalColor: color
            )
        )
    }

    public func palette(
        primary: UIColor,
        secondary: UIColor? = nil,
        tertiary: UIColor? = nil
    ) -> SymbolChainable {
        applying(
            UIImage.SymbolConfiguration(
                paletteColors: [
                    primary,
                    secondary,
                    tertiary
                ].compactMap { $0 }
            )
        )
    }

    public func multicolor() -> SymbolChainable {
        SymbolLink(
            image: image.withRenderingMode(.alwaysOriginal)
        )
    }

    public func font(_ font: UIFont) -> SymbolChainable {
        applying(
            UIImage.SymbolConfiguration(
                font: font
            )
        )
    }

    public func textStyle(
        _ textStyle: UIFont.TextStyle,
        scale: UIImage.SymbolScale
    ) -> SymbolChainable {
        applying(
            UIImage.SymbolConfiguration(
                textStyle: textStyle,
                scale: scale
            )
        )
    }
}
