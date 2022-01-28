import UIKit

public struct Impact {
    public enum Style {
        case selection
        case light
        case medium
        case heavy
        case intensity(_ value: Double)
        case error
        case success
        case warning
        case rigid
        case soft
    }

    public static func generate(_ style: Style) {
        switch style {
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()

        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()

        case .medium:
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()

        case .heavy:
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

        case let .intensity(value):
            UIImpactFeedbackGenerator().impactOccurred(intensity: value)

        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)

        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)

        case .warning:
            UINotificationFeedbackGenerator().notificationOccurred(.warning)

        case .rigid:
            UIImpactFeedbackGenerator(style: .rigid).impactOccurred()

        case .soft:
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        }
    }
}
