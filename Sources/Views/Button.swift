import Core
import UIKit

open class Button: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        appFatalError()
    }

    // MARK: -

    func setup() {
        preSetup()
        configureViews()
        postSetup()

        if let configuration = makeConfiguration() {
            self.configuration = configuration
        }
    }

    // MARK: - Overridable methods

    open func preSetup() { }

    open func configureViews() { }

    open func postSetup() { }

    open func makeConfiguration() -> UIButton.Configuration? { nil }
}
