import Core
import UIKit

public func animationChain(
    _ links: [AnimationChain.Link?],
    completion: Block? = nil
) {
    let chain = AnimationChain(links)
    chain.run {
        completion?()
    }
}

public func animationChain(
    _ links: AnimationChain.Link?...,
    completion: Block? = nil
) {
    animationChain(
        links,
        completion: {
            completion?()
        }
    )
}

@MainActor
public func animationChain(_ links: [AnimationChain.Link?]) async {
    let chain = AnimationChain(links)
    await chain.run()
}

@MainActor
public func animationChain(_ links: AnimationChain.Link?...) async {
    await animationChain(links)
}
