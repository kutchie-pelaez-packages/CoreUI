import UIKit

public enum SystemColors {
    public enum Background {
        public static let primary = UIColor.systemBackground
        public static let secondary = UIColor.secondarySystemBackground
        public static let tertiary = UIColor.tertiarySystemBackground
    }

    public enum GroupedBackground {
        public static let primary = UIColor.systemGroupedBackground
        public static let secondary = UIColor.secondarySystemGroupedBackground
        public static let tertiary = UIColor.tertiarySystemGroupedBackground
    }

    public enum Label {
        public static let primary = UIColor.label
        public static let secondary = UIColor.secondaryLabel
        public static let tertiary = UIColor.tertiaryLabel
        public static let quaternary = UIColor.quaternaryLabel
    }

    public enum Fill {
        public static let primary = UIColor.systemFill
        public static let secondary = UIColor.secondarySystemFill
        public static let tertiary = UIColor.tertiarySystemFill
        public static let quaternary = UIColor.tertiarySystemFill
    }

    public enum Placeholder {
        public static let text = UIColor.placeholderText
    }

    public enum Separator {
        public static let regular = UIColor.separator
        public static let opaque = UIColor.opaqueSeparator
    }

    public enum Tint {
        public static let primary = UIColor.systemBlue
        public static let green = UIColor.systemGreen
        public static let red = UIColor.systemRed
    }

    public enum Gray {
        public static let one = UIColor.gray
        public static let two = UIColor.systemGray2
        public static let three = UIColor.systemGray3
        public static let four = UIColor.systemGray4
        public static let five = UIColor.systemGray5
        public static let six = UIColor.systemGray6
    }
}
