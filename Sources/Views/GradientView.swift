import UIKit

public final class GradientView: View {
    public struct ColorLocation {
        public init(
            color: UIColor,
            location: Double
        ) {
            self.color = color
            self.location = location
        }

        public var color: UIColor
        public var location: Double
    }

    public enum GradientType {
        case axial
        case radial
        case conic

        fileprivate var gradientLayerType: CAGradientLayerType {
            switch self {
            case .axial:
                return .axial

            case .conic:
                return .conic

            case .radial:
                return .radial
            }
        }
    }

    // MARK: - Public interface

    public var startColor: UIColor = .clear {
        didSet {
            updateParameters()
        }
    }

    public var endColor: UIColor = .clear {
        didSet {
            updateParameters()
        }
    }

    public var colorLocations: [ColorLocation]? {
        didSet {
            updateParameters()
        }
    }

    public var startPoint = CGPoint(x: 0, y: 0.5) {
        didSet {
            updateParameters()
        }
    }

    public var endPoint = CGPoint(x: 1, y: 0.5) {
        didSet {
            updateParameters()
        }
    }

    public var zPosition: Double = 0 {
        didSet {
            updateParameters()
        }
    }

    public var type: GradientType = .axial {
        didSet {
            gradientLayer.type = type.gradientLayerType
        }
    }

    // MARK: - UI

    public override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }

    public override func configureViews() {
        updateParameters()
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateParameters()
    }

    // MARK: -

    private func updateParameters() {
        if let colorLocations = colorLocations {
            gradientLayer.colors = colorLocations.map { $0.color.cgColor }
            gradientLayer.locations = colorLocations.map { NSNumber(value: Float($0.location)) }
        } else {
            gradientLayer.colors = [
                startColor.cgColor,
                endColor.cgColor,
            ]
            gradientLayer.locations = nil
        }

        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.zPosition = zPosition
    }
}
