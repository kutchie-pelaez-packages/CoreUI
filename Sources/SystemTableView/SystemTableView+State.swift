import Core
import UIKit

// MARK: - State

extension SystemTableView {
    public struct State {
        public init(sections: [Section]) {
            self.sections = sections
        }

        public init(sections: Section...) {
            self.init(sections: sections)
        }

        var sections: [Section]
    }
}

// MARK: - Section

extension SystemTableView {
    public struct Section {
        public init(
            rows: [Row],
            header: SystemHeader? = nil,
            footer: SystemFooter? = nil
        ) {
            self.rows = rows
            self.header = header
            self.footer = footer
        }

        let rows: [Row]
        let header: SystemHeader?
        let footer: SystemFooter?
    }
}

// MARK: - Row

extension SystemTableView {
    public enum Row {
        case system(SystemRow)
        case custom(CustomRow)

        public init(
            content: SystemContent,
            leadingContent: SystemLeadingContent? = nil,
            trailingContent: SystemTrailingContent? = nil,
            enabled: Bool = true,
            action: Block? = nil
        ) {
            self = .system(
                SystemRow(
                    content: content,
                    leadingContent: leadingContent,
                    trailingContent: trailingContent,
                    enabled: enabled,
                    action: action
                )
            )
        }

        public init(
            type: AnyClass,
            transformer: @escaping (UITableViewCell) -> Void
        ) {
            self = .custom(
                CustomRow(
                    type: type,
                    transformer: transformer
                )
            )
        }
    }
}

// MARK: - SystemRow

extension SystemTableView {
    public struct SystemRow {
        public init(
            content: SystemContent,
            leadingContent: SystemLeadingContent? = nil,
            trailingContent: SystemTrailingContent? = nil,
            enabled: Bool = true,
            action: Block? = nil
        ) {
            self.leadingContent = leadingContent
            self.trailingContent = trailingContent
            self.content = content
            self.enabled = enabled
            self.action = action
        }

        let content: SystemContent
        let leadingContent: SystemLeadingContent?
        let trailingContent: SystemTrailingContent?
        let enabled: Bool
        let action: Block?
    }

    // MARK: - SystemContent

    public struct SystemContent {
        public init(
            title: SystemTitle,
            subtitle: SystemSubtitle? = nil
        ) {
            self.title = title
            self.subtitle = subtitle
        }

        let title: SystemTitle
        let subtitle: SystemSubtitle?
    }

    public struct SystemTitle {
        public init (
            string: String,
            font: UIFont? = nil,
            color: UIColor? = nil,
            alignment: Alignment? = nil
        ) {
            self.string = string
            self.font = font
            self.color = color
            self.alignment = alignment
        }

        let string: String
        let font: UIFont?
        let color: UIColor?
        let alignment: Alignment?

        public enum Alignment {
            case natural
            case justified
            case center
        }
    }

    public struct SystemSubtitle {
        public init (
            string: String,
            font: UIFont? = nil,
            color: UIColor? = nil
        ) {
            self.string = string
            self.font = font
            self.color = color
        }

        let string: String
        let font: UIFont?
        let color: UIColor?
    }

    // MARK: - SystemLeadingContent

    public enum SystemLeadingContent {
        case image(ImageConfiguration)

        public static func image(_ image: UIImage?) -> SystemLeadingContent {
            .image(
                ImageConfiguration(
                    image: image
                )
            )
        }

        public struct ImageConfiguration {
            public init(
                image: UIImage?,
                corners: Corners? = nil,
                maximumSize: CGSize? = nil
            ) {
                self.image = image
                self.corners = corners
                self.maximumSize = maximumSize
            }

            let image: UIImage?
            let corners: Corners?
            let maximumSize: CGSize?

            public enum Corners {
                case rounded(Double)

                public static var none: Corners {
                    .rounded(0)
                }

                public static var circle: Corners {
                    .rounded(.greatestFiniteMagnitude)
                }
            }
        }
    }

    // MARK: - SystemTrailingContent

    public enum SystemTrailingContent {
        case checkmark
        case detailButton
        case detailDisclosureButton
        case disclosureIndicator
        case view(UIView)

        public static func image(_ image: UIImage) -> SystemTrailingContent {
            let imageView = UIImageView(image: image)

            return .view(imageView)
        }

        public static func `switch`(
            isOn: Bool,
            action: @escaping BoolBlock
        ) -> SystemTrailingContent {
            let switchView = UISwitch()
            switchView.onTintColor = SystemColors.Tint.primary
            switchView.isOn = isOn
            switchView.addAction { [weak switchView] in
                action(switchView?.isOn == true)
            }

            return .view(switchView)
        }

        public static func stepper(
            value: Double,
            stepValue: Double = 1.0,
            action: @escaping DoubleBlock
        ) -> SystemTrailingContent {
            let stepper = UIStepper()
            stepper.tintColor = SystemColors.Tint.primary
            stepper.stepValue = stepValue
            stepper.value = value
            stepper.addAction { [weak stepper] in
                guard let value = stepper?.value else { return }

                action(value)
            }

            return .view(stepper)
        }

        public static func segmentedControl(
            items: [Any],
            selectedIndex: Int,
            action: @escaping IntBlock
        ) -> SystemTrailingContent {
            let segmentedControl = UISegmentedControl(
                items: items
            )
            segmentedControl.selectedSegmentIndex = selectedIndex
            segmentedControl.addAction { [weak segmentedControl] in
                guard let selectedSegmentIndex = segmentedControl?.selectedSegmentIndex else {
                    return
                }
                action(selectedSegmentIndex)
            }

            return .view(segmentedControl)
        }
    }
}

// MARK: - CustomRow

extension SystemTableView {
    public struct CustomRow {
        public init(
            type: AnyClass,
            transformer: @escaping (UITableViewCell) -> Void
        ) {
            self.type = type
            self.transformer = transformer
        }

        let type: AnyClass
        let transformer: (UITableViewCell) -> Void
    }
}

// MARK: - SystemHeader

extension SystemTableView {
    public struct SystemHeader {
        public init(string: String) {
            self.string = string
        }

        public var string: String
    }
}

// MARK: - SystemFooter

extension SystemTableView {
    public struct SystemFooter {
        public init(
            string: String,
            alignment: Alignment? = nil
        ) {
            self.string = string
            self.alignment = alignment
        }

        let string: String
        let alignment: Alignment?

        public enum Alignment {
            case natural
            case justified
            case center
        }
    }
}
