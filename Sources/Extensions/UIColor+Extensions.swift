import UIKit
import Core

extension UIColor: Reassignable {
    public static var random: UIColor {
        let r = Double.random(in: 0...255)
        let g = Double.random(in: 0...255)
        let b = Double.random(in: 0...255)

        return UIColor(
            r,
            g,
            b
        )
    }

    public static var randomWithRandomAlpha: UIColor {
        let randomAlpha = Double.random(in: 0...1)

        return random
            .withAlphaComponent(randomAlpha)
    }

    public convenience init(
        hex: UInt,
        forceAlpha: Bool = false
    ) {
        let hasAlpha = forceAlpha || hex > 0xFFFFFF

        let r = Double((hex >> (hasAlpha ? 24 : 16)) & 0xFF)
        let g = Double((hex >> (hasAlpha ? 16 : 8)) & 0xFF)
        let b = Double((hex >> (hasAlpha ? 8 : 0)) & 0xFF)
        let a = hasAlpha ? Double((hex >> 0) & 0xFF) / 255 : 1

        self.init(
            r,
            g,
            b,
            a
        )
    }

    public convenience init(hex: String) {
        var string: String = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()

        if string.hasPrefix("#") {
            string.remove(at: string.startIndex)
        }

        guard
            string.count == 6 ||
            string.count == 8
        else {
            self.init(0xFF0000)
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: string)
            .scanHexInt64(&rgbValue)

        self.init(
            hex: UInt(rgbValue),
            forceAlpha: string.count == 8
        )
    }

    public convenience init(
        _ r: Double,
        _ g: Double? = nil,
        _ b: Double? = nil,
        _ a: Double = 1
    ) {
        if
            let g = g,
            let b = b
        {
            self.init(
                red: r / 255,
                green: g / 255,
                blue: b / 255,
                alpha: a
            )
        } else {
            self.init(
                red: r / 255,
                green: r / 255,
                blue: r / 255,
                alpha: a
            )
        }
    }

    public convenience init(
        light: UIColor,
        dark: UIColor
    ) {
        self.init { traitCollection in
            traitCollection.userInterfaceStyle == .light ? light : dark
        }
    }

    public convenience init(
        light lightHex: UInt,
        dark darkHex: UInt
    ) {
        self.init(
            light: UIColor(hex: lightHex),
            dark: UIColor(hex: darkHex)
        )
    }

    public convenience init(
        light: String,
        dark: String
    ) {
        self.init { traitCollection in
            traitCollection.userInterfaceStyle == .light ? UIColor(hex: light) : UIColor(hex: dark)
        }
    }

    public var isLight: Bool {
        let components = cgColor.components

        guard
            let first = components?[safe: 0],
            let second = components?[safe: 1],
            let third = components?[safe: 2]
        else {
            return false
        }

        let brightness = ((first * 299) + (second * 587) + (third * 114)) / 1000

        return brightness > 0.5
    }

    public var hex: String {
        let components = cgColor.components ?? []
        let firstComponent = components.first ?? 1

        func value(for index: Int) -> Int {
            lroundf(Float((components[safe: components.count - index] ?? firstComponent) * 255))
        }

        return String(
            format: "#%02lX%02lX%02lX%02lX",
            value(for: 4),
            value(for: 3),
            value(for: 2),
            value(for: 1)
        )
    }

    public var hsba: (h: Double, s: Double, b: Double, a: Double) {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getHue(
            &h,
            saturation: &s,
            brightness: &b,
            alpha: &a
        )

        return (
            h: h,
            s: s,
            b: b,
            a: a
        )
    }

    public var light: UIColor {
        forUserInterfaceStyle(.light)
    }

    public var dark: UIColor {
        forUserInterfaceStyle(.dark)
    }

    public var inverted: UIColor {
        UIColor(
            light: dark,
            dark: light
        )
    }

    public var alpha: Double {
        hsba.a
    }

    public func forUserInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle) -> UIColor {
        let traitCollection = UITraitCollection(userInterfaceStyle: userInterfaceStyle)

        return resolvedColor(with: traitCollection)
    }
}
