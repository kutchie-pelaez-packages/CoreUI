import UIKit

private let percentFilledSettingDuration: TimeInterval = .milliseconds(200)

public final class CircleStroke: View {
    public var percentFilled: Double {
        circleLayer.strokeEnd
    }

    public func setPercentFilled(
        _ percentFilled: Double,
        animated: Bool = true
    ) {
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = circleLayer.strokeEnd
            animation.toValue = percentFilled
            animation.duration = percentFilledSettingDuration
            circleLayer.add(animation, forKey: "strokeEnd")
        }

        circleLayer.strokeEnd = percentFilled
    }

    public var color: UIColor? {
        didSet {
            circleLayer.strokeColor = color?.cgColor
        }
    }

    public var lineWidth: Double {
        get {
            circleLayer.lineWidth
        } set {
            circleLayer.lineWidth = newValue
        }
    }

    // MARK: - UI

    public override class var layerClass: AnyClass {
        CAShapeLayer.self
    }

    private var circleLayer: CAShapeLayer {
        layer as! CAShapeLayer
    }

    public override func configureViews() {
        circleLayer.lineCap = .round
        circleLayer.strokeStart = 0
        circleLayer.strokeEnd = 0
        circleLayer.fillColor = UIColor.clear.cgColor
    }

    public override func subviewsDidLayout() {
        circleLayer.path = circlePath
    }

    public override func userInterfaceStyleDidChange(from previousUserInterfaceStyle: UIUserInterfaceStyle, to newUserInterfaceStyle: UIUserInterfaceStyle) {
        color?.reassign()
    }

    // MARK: -

    private var circlePath: CGPath {
        UIBezierPath(
            arcCenter: CGPoint(
                x: frame.width / 2,
                y: frame.height / 2
            ),
            radius: max(
                frame.width / 2,
                frame.height / 2
            ),
            startAngle: -.pi / 2,
            endAngle: .pi * 2 - .pi / 2,
            clockwise: true
        ).cgPath
    }
}
