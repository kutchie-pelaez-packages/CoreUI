import Core
import UIKit

public func animation(
    _ animation: Animation,
    completion: Block? = nil
) {
    guard animation.condition else {
        completion?()
        return
    }

    let actualDuration = animation.animated ? animation.duration : 0

    if animation.force {
        dispatch(after: animation.delay + animation.duration) {
            completion?()
        }
    }

    if let spring = animation.spring {
        UIView.animate(
            withDuration: actualDuration,
            delay: animation.delay,
            usingSpringWithDamping: spring.damping,
            initialSpringVelocity: spring.velocity,
            options: animation.options,
            animations: {
                animation.animations()
            },
            completion: { _ in
                guard !animation.force else { return }

                completion?()
            }
        )
    } else {
        UIView.animate(
            withDuration: actualDuration,
            delay: animation.delay,
            options: animation.options,
            animations: {
                animation.animations()
            },
            completion: { _ in
                guard !animation.force else { return }

                completion?()
            }
        )
    }
}

public func animation(
    after delay: TimeInterval = .zero,
    duration: TimeInterval,
    spring: AnimationSpring? = nil,
    condition: Bool = true,
    animated: Bool = true,
    force: Bool = false,
    options: UIView.AnimationOptions = .curveEaseInOut,
    animations: @escaping Block,
    completion: Block? = nil
) {
    let animation = Animation(
        after: delay,
        duration: duration,
        spring: spring,
        condition: condition,
        animated: animated,
        force: force,
        options: options,
        animations: {
            animations()
        }
    )

    animation.run {
        completion?()
    }
}

@MainActor
public func animation(_ animation: Animation) async {
    let animation =  Animation(
        after: animation.delay,
        duration: animation.duration,
        spring: animation.spring,
        condition: animation.condition,
        animated: animation.animated,
        force: animation.force,
        options: animation.options,
        animations: {
            animation.animations()
        }
    )

    await animation.run()
}

@MainActor
public func animation(
    after delay: TimeInterval = .zero,
    duration: TimeInterval,
    spring: AnimationSpring? = nil,
    condition: Bool = true,
    animated: Bool = true,
    force: Bool = false,
    options: UIView.AnimationOptions = .curveEaseInOut,
    animations: @escaping Block
) async {
    let animation =  Animation(
        after: delay,
        duration: duration,
        spring: spring,
        condition: condition,
        animated: animated,
        force: force,
        options: options,
        animations: {
            animations()
        }
    )

    await animation.run()
}
