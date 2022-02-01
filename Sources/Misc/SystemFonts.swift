import UIKit

public enum SystemFonts {
    public enum Mono {
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
