import Core

public protocol Animatable {
    func run(completion: @escaping Block)
}

extension Animatable {
    public func run() {
        run { }
    }

    public func run() async {
        Task { @MainActor in
            await withCheckedContinuation { continuation in
                run {
                    continuation.resume()
                }
            }
        }
    }
}
