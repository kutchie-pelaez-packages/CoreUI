import Core

public struct AnimationGroup: Animatable {
    public init(_ animations: [Animatable?]) {
        self.animations = animations.compactMap { $0 }
    }

    public init(_ animations: Animatable?...) {
        self.init(animations)
    }

    let animations: [Animatable]

    // MARK: - Animatable

    public func run(completion: @escaping Block) {
        animationGroup(
            self,
            completion: {
                completion()
            }
        )
    }
}
