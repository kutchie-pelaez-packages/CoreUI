import Combine
import Core
import UIKit

private let statusBarUpdateAnimationDuration: TimeInterval = .milliseconds(250)

open class ViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        crash()
    }

    // MARK: -

    private var isViewSized = false

    private var viewDidLoadBlocks = [Block]()
    private var viewDidLayoutBlocks = [Block]()

    // MARK: - System methods

    open override var prefersStatusBarHidden: Bool {
        isStatusBarHidden
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        preSetup()
        configureViews()
        configureNavigationBar()
        subscribeToEvents()
        constraintViews()
        postSetup()

        viewDidLoadBlocks.forEach { $0() }
        viewDidLoadBlocks.removeAll()
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard let previousTraitCollection = previousTraitCollection else { return }

        if traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle {
            userInterfaceStyleDidChange(from: previousTraitCollection.userInterfaceStyle, to: traitCollection.userInterfaceStyle)
        }
    }

    open override func updateViewConstraints() {
        snapUpdate()
        super.updateViewConstraints()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayout()

        if
            view.frame.isNotEmpty &&
            !isViewSized
        {
            isViewSized = true

            viewDidLayoutBlocks.forEach { $0() }
            viewDidLayoutBlocks.removeAll()

            viewDidSized()
        }
    }

    // MARK: - Public interface

    public var isStatusBarHidden = false

    public var cancellables = [AnyCancellable]()

    public func invokeWhenViewIsLoaded(_ block: @escaping Block) {
        if isViewLoaded {
            block()
        } else {
            viewDidLoadBlocks.append(block)
        }
    }

    public func invokeWhenViewIsLayouted(_ block: @escaping Block) {
        if view.frame.isNotEmpty {
            block()
        } else {
            viewDidLayoutBlocks.append(block)
        }
    }

    open func preSetup() { }

    open func configureViews() { }

    open func configureNavigationBar() { }

    open func subscribeToEvents() { }

    open func constraintViews() { }

    open func postSetup() { }

    open func viewDidLayout() { }

    open func viewDidSized() { }

    open func snapUpdate() { }

    open func userInterfaceStyleDidChange(from previousStyle: UIUserInterfaceStyle, to newStyle: UIUserInterfaceStyle) { }
}
