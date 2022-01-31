import Core
import UIKit

open class TableViewCell: UITableViewCell {
    public init() {
        super.init(style: .default, reuseIdentifier: Self.reusableIdentifier)
        setup()
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        appFatalError()
    }

    private var isSized = false

    // MARK: -

    open func setup() {
        preSetup()
        configureViews()
        constraintViews()
        postSetup()
    }

    // MARK: - System methods

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        guard let previousTraitCollection = previousTraitCollection else { return }

        if traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle {
            userInterfaceStyleDidChange(from: previousTraitCollection.userInterfaceStyle, to: traitCollection.userInterfaceStyle)
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        subviewsDidLayout()

        if
            frame.isNotEmpty &&
            !isSized
        {
            isSized = true
            didSized()
        }
    }

    // MARK: - Public interface

    open func preSetup() { }

    open func configureViews() { }

    open func constraintViews() { }

    open func postSetup() { }

    open func subviewsDidLayout() { }

    open func didSized() { }

    open func userInterfaceStyleDidChange(from previousStyle: UIUserInterfaceStyle, to newStyle: UIUserInterfaceStyle) { }
}
