import CoreUtils
import UIKit

public func animationGroup(
    _ group: AnimationGroup,
    completion: Block? = nil
) {
    guard group.animations.isNotEmpty else {
        completion?()
        return
    }

    var completedAnimationsCount = 0 {
        didSet {
            if completedAnimationsCount == group.animations.count {
                completion?()
            }
        }
    }

    for animation in group.animations {
        animation.run {
            completedAnimationsCount += 1
        }
    }
}

public func animationGroup(
    _ animations: [Animatable?],
    completion: Block? = nil
) {
    let group = AnimationGroup(animations)
    animationGroup(
        group,
        completion: {
            completion?()
        }
    )
}

public func animationGroup(
    _ animations: Animatable?...,
    completion: Block? = nil
) {
    animationGroup(
        animations,
        completion: {
            completion?()
        }
    )
}

@MainActor
public func animationGroup(_ group: AnimationGroup) async {
    await group.run()
}

@MainActor
public func animationGroup(_ animations: [Animatable?]) async {
    let group = AnimationGroup(animations)
    await group.run()
}

@MainActor
public func animationGroup(_ animations: Animatable?...) async {
    await animationGroup(animations)
}
