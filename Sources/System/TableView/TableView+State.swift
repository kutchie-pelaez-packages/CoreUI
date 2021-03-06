import Core
import UIKit

// MARK: - State

extension System.TableView {
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

extension System.TableView {
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

extension System.TableView {
    public enum Row {
        case system(SystemRow)
        case custom(CustomRow)
        case view(ViewRow)

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

        public init(
            constructor: @escaping Constructor,
            constraining: ViewRow.Constraining = .fill,
            action: Block? = nil
        ) {
            self = .view(
                ViewRow(
                    constructor: constructor,
                    constraining: constraining,
                    action: action
                )
            )
        }
    }
}

// MARK: - SystemRow

extension System.TableView {
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

extension System.TableView {
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
            switchView.onTintColor = System.Colors.Tint.primary
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
            stepper.tintColor = System.Colors.Tint.primary
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

extension System.TableView {
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

// MARK: - ViewRow

extension System.TableView {
    public typealias Constructor = () -> UIView

    public struct ViewRow {
        public init(
            constructor: @escaping Constructor,
            constraining: Constraining = .fill,
            action: Block? = nil
        ) {
            self.constructor = constructor
            self.constraining = constraining
            self.action = action
        }

        let constructor: Constructor
        let constraining: Constraining
        let action: Block?

        public enum Constraining {
            case fill(insets: UIEdgeInsets)
            case center(topInset: Double = 0, bottomInset: Double = 0, centerInset: Double = 0)
            case leading(topInset: Double = 0, bottomInset: Double = 0, leadingInset: Double = 0)
            case trailing(topInset: Double = 0, bottomInset: Double = 0, trailingInset: Double = 0)

            public static var fill: Constraining {
                .fill(insets: .zero)
            }

            public static var center: Constraining {
                .center()
            }

            public static var leading: Constraining {
                .leading()
            }

            public static var trailing: Constraining {
                .trailing()
            }
        }
    }
}

// MARK: - SystemHeader

extension System.TableView {
    public struct SystemHeader {
        public init(
            text: String,
            font: UIFont? = nil,
            color: UIColor? = nil,
            transform: UIListContentConfiguration.TextProperties.TextTransform? = nil
        ) {
            self.text = text
            self.font = font
            self.color = color
            self.transform = transform
        }

        let text: String
        let font: UIFont?
        let color: UIColor?
        let transform: UIListContentConfiguration.TextProperties.TextTransform?
    }
}

// MARK: - SystemFooter

extension System.TableView {
    public struct SystemFooter {
        public init(
            text: String,
            alignment: UIListContentConfiguration.TextProperties.TextAlignment? = nil
        ) {
            self.text = text
            self.alignment = alignment
        }

        let text: String
        let alignment: UIListContentConfiguration.TextProperties.TextAlignment?
    }
}
