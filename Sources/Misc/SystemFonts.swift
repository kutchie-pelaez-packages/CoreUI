import UIKit

public enum SystemFonts {
    public enum Mono {
        public static var largeTitle: UIFont { regular(34) }

        public static var title1: UIFont { regular(28) }

        public static var title2: UIFont { regular(22) }

        public static var title3: UIFont { regular(20) }

        public static var headline: UIFont { semibold(17) }

        public static var body: UIFont { regular(17) }

        public static var callout: UIFont { regular(16) }

        public static var subheadline: UIFont { regular(15) }

        public static var footnote: UIFont { regular(13) }

        public static var caption1: UIFont { regular(12) }

        public static var caption2: UIFont { regular(11) }

        public static func ultraLight(_ size: Double) -> UIFont {
            .monospacedSystemFont(
                ofSize: size,
                weight: .ultraLight
            )
        }

        public static func thin(_ size: Double) -> UIFont {
            .monospacedSystemFont(
                ofSize: size,
                weight: .thin
            )
        }

        public static func light(_ size: Double) -> UIFont {
            .monospacedSystemFont(
                ofSize: size,
                weight: .light
            )
        }

        public static func regular(_ size: Double) -> UIFont {
            .monospacedSystemFont(
                ofSize: size,
                weight: .regular
            )
        }

        public static func medium(_ size: Double) -> UIFont {
            .monospacedSystemFont(
                ofSize: size,
                weight: .medium
            )
        }

        public static func semibold(_ size: Double) -> UIFont {
            .monospacedSystemFont(
                ofSize: size,
                weight: .semibold
            )
        }

        public static func bold(_ size: Double) -> UIFont {
            .monospacedSystemFont(
                ofSize: size,
                weight: .bold
            )
        }

        public static func heavy(_ size: Double) -> UIFont {
            .monospacedSystemFont(
                ofSize: size,
                weight: .heavy
            )
        }

        public static func black(_ size: Double) -> UIFont {
            .monospacedSystemFont(
                ofSize: size,
                weight: .black
            )
        }
    }

    public static var largeTitle: UIFont { regular(34) }

    public static var title1: UIFont { regular(28) }

    public static var title2: UIFont { regular(22) }

    public static var title3: UIFont { regular(20) }

    public static var headline: UIFont { semibold(17) }

    public static var body: UIFont { regular(17) }

    public static var callout: UIFont { regular(16) }

    public static var subheadline: UIFont { regular(15) }

    public static var footnote: UIFont { regular(13) }

    public static var caption1: UIFont { regular(12) }

    public static var caption2: UIFont { regular(11) }

    public static func ultraLight(_ size: Double) -> UIFont {
        .systemFont(
            ofSize: size,
            weight: .ultraLight
        )
    }

    public static func thin(_ size: Double) -> UIFont {
        .systemFont(
            ofSize: size,
            weight: .thin
        )
    }

    public static func light(_ size: Double) -> UIFont {
        .systemFont(
            ofSize: size,
            weight: .light
        )
    }

    public static func regular(_ size: Double) -> UIFont {
        .systemFont(
            ofSize: size,
            weight: .regular
        )
    }

    public static func medium(_ size: Double) -> UIFont {
        .systemFont(
            ofSize: size,
            weight: .medium
        )
    }

    public static func semibold(_ size: Double) -> UIFont {
        .systemFont(
            ofSize: size,
            weight: .semibold
        )
    }

    public static func bold(_ size: Double) -> UIFont {
        .systemFont(
            ofSize: size,
            weight: .bold
        )
    }

    public static func heavy(_ size: Double) -> UIFont {
        .systemFont(
            ofSize: size,
            weight: .heavy
        )
    }

    public static func black(_ size: Double) -> UIFont {
        .systemFont(
            ofSize: size,
            weight: .black
        )
    }
}
