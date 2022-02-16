import Core
import UIKit

open class CollectionViewCell: UICollectionViewCell {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        crash()
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
