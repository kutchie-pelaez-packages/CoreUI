import UIKit
import CoreUtils

public struct AnimationChain: Animatable {
    public struct Link {
        fileprivate let animations: [Animatable]

        public static func animationGroup(_ animations: [Animatable?]) -> Link {
            Link(animations: animations.compactMap { $0 })
        }

        public static func animationGroup(_ animations: Animatable?...) -> Link {
            .animationGroup(animations)
        }

        public static func animation(_ animation: Animatable) -> Link {
            .animationGroup(animation)
        }

        public static func animation(
            after delay: TimeInterval = .zero,
            duration: TimeInterval,
            spring: AnimationSpring? = nil,
            condition: Bool = true,
            animated: Bool = true,
            force: Bool = false,
            options: UIView.AnimationOptions = .curveEaseInOut,
            animations: @escaping Block
        ) -> Link {
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

            return .animation(animation)
        }

        public static func execute(_ block: @escaping Block) -> Link {
            .animation(
                NoOpAnimation {
                    block()
                }
            )
        }
    }

    public init(_ links: [Link?]) {
        self.links = links.compactMap { $0 }
    }

    public init(_ links: Link?...) {
        self.init(links)
    }

    public init(_ animations: [Animatable?]) {
        self.init(
            animations
                .unwrapped()
                .map(Link.animation)
        )
    }

    public init(_ animations: Animatable?...) {
        self.init(animations)
    }

    private let links: [Link]

    // MARK: - Animatable

    public func run(completion: @escaping Block) {
        guard links.isNotEmpty else {
            completion()
            return
        }

        var links = links
        var completedLinksCount = 0 {
            didSet {
                if completedLinksCount == self.links.count {
                    completion()
                }
            }
        }

        func runNextLink() {
            guard links.isNotEmpty else { return }

            animationGroup(links.removeFirst().animations) {
                completedLinksCount += 1
                runNextLink()
            }
        }

        runNextLink()
    }
}
