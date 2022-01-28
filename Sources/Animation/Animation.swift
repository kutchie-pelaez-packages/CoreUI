import Core
import UIKit

public struct Animation: Animatable {
    public init(
        after delay: TimeInterval = .zero,
        duration: TimeInterval,
        spring: AnimationSpring? = nil,
        condition: Bool = true,
        animated: Bool = true,
        force: Bool = false,
        options: UIView.AnimationOptions = .curveEaseInOut,
        animations: @escaping Block
    ) {
        self.delay = delay
        self.duration = duration
        self.spring = spring
        self.condition = condition
        self.animated = animated
        self.force = force
        self.options = options
        self.animations = animations
    }

    let delay: TimeInterval
    let duration: TimeInterval
    let spring: AnimationSpring?
    let condition: Bool
    let animated: Bool
    let force: Bool
    let options: UIView.AnimationOptions
    let animations: Block

    // MARK: - Animatable

    public func run(completion: @escaping Block) {
        animation(
            self,
            completion: {
                completion()
            }
        )
    }
}
