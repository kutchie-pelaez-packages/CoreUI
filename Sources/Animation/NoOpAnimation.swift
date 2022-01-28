import CoreUtils

public struct NoOpAnimation: Animatable {
    public init(block: Block? = nil) {
        self.block = block
    }

    private let block: Block?

    // MARK: - Animatable

    public func run(completion: @escaping Block) {
        block?()
        completion()
    }
}
