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

        let sections: [Section]
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
            transformer: Transformer? = nil,
            action: Block? = nil
        ) {
            self = .custom(
                CustomRow(
                    type: type,
                    transformer: transformer,
                    action: action
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
            title: Title,
            subtitle: Subtitle? = nil
        ) {
            self.title = title
            self.subtitle = subtitle
        }

        let title: Title
        let subtitle: Subtitle?

        public struct Title {
            public init (
                text: String,
                font: UIFont? = nil,
                color: UIColor? = nil,
                alignment: UIListContentConfiguration.TextProperties.TextAlignment? = nil
            ) {
                self.text = text
                self.font = font
                self.color = color
                self.alignment = alignment
            }

            let text: String
            let font: UIFont?
            let color: UIColor?
            let alignment: UIListContentConfiguration.TextProperties.TextAlignment?
        }

        public struct Subtitle {
            public init (
                text: String,
                font: UIFont? = nil,
                color: UIColor? = nil
            ) {
                self.text = text
                self.font = font
                self.color = color
            }

            let text: String
            let font: UIFont?
            let color: UIColor?
        }
    }

    // MARK: - SystemLeadingContent

    public enum SystemLeadingContent {
        case image(Image)

        public static func image(_ image: UIImage?) -> SystemLeadingContent {
            .image(
                Image(image)
            )
        }

        public struct Image {
            public init(
                _ image: UIImage?,
                corners: Corners = .none,
                maximumSize: CGSize? = nil
            ) {
                self.image = image
                self.corners = corners
                self.maximumSize = maximumSize
            }

            let image: UIImage?
            let corners: Corners
            let maximumSize: CGSize?

            public struct Corners {
                let value: Double

                public static func rounded(_ value: Double) -> Corners {
                    Corners(value: value)
                }

                public static var none: Corners {
                    Corners(value: 0)
                }

                public static var circle: Corners {
                    Corners(value: .greatestFiniteMagnitude)
                }
            }
        }
    }
}

// MARK: - SystemTrailingContent

extension SystemTableView {
    public enum SystemTrailingContent {
        case checkmark
        case detailButton
        case detailDisclosureButton
        case disclosureIndicator
        case customView(UIView)

        public static func image(_ image: UIImage) -> SystemTrailingContent {
            let imageView = UIImageView(image: image)

            return .customView(imageView)
        }

        public static func `switch`(
            enabled: Bool,
            action: @escaping BoolBlock
        ) -> SystemTrailingContent {
            let switchView = UISwitch()
            switchView.onTintColor = SystemColors.Tint.primary
            switchView.isOn = enabled
            switchView.addAction { [weak switchView] in
                action(switchView?.isOn == true)
            }

            return .customView(switchView)
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

            return .customView(stepper)
        }

        public static func segmentedControl(
            items: [Any],
            selectedIndex: Int,
            action: @escaping IntBlock
        ) -> SystemTrailingContent {
            let segmentedControl = UISegmentedControl(items: items)
            segmentedControl.selectedSegmentIndex = selectedIndex
            segmentedControl.addAction { [weak segmentedControl] in
                guard let selectedSegmentIndex = segmentedControl?.selectedSegmentIndex else { return }

                action(selectedSegmentIndex)
            }

            return .customView(segmentedControl)
        }
    }
}

// MARK: - CustomRow

extension SystemTableView {
    public typealias Transformer = (UITableViewCell) -> Void

    public struct CustomRow {
        public init(
            type: AnyClass,
            transformer: (Transformer)? = nil,
            action: Block? = nil
        ) {
            self.type = type
            self.transformer = transformer
            self.action = action
        }

        let type: AnyClass
        let transformer: (Transformer)?
        let action: Block?
    }
}

// MARK: - SystemHeader

extension SystemTableView {
    public struct SystemHeader {
        public init(
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
}

// MARK: - SystemFooter

extension SystemTableView {
    public struct SystemFooter {
        public init(
            string: String,
            alignment: UIListContentConfiguration.TextProperties.TextAlignment? = nil
        ) {
            self.string = string
            self.alignment = alignment
        }

        let string: String
        let alignment: UIListContentConfiguration.TextProperties.TextAlignment?
    }
}
