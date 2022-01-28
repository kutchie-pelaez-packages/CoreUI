public struct AnimationSpring {
    public init(
        damping: Double,
        velocity: Double
    ) {
        self.damping = damping
        self.velocity = velocity
    }

    public static var `default`: AnimationSpring {
        AnimationSpring(
            damping: 0.9,
            velocity: 1.2
        )
    }

    let damping: Double
    let velocity: Double
}
