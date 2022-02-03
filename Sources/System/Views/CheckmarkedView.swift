import UIKit

public final class CheckmarkedView: Control {
    public enum CheckmarkPosition {
        case leading
        case trailing
        case top
        case bottom
    }

    public init(_ view: UIView) {
        self.wrapee = view
        super.init()
    }

    public var checkmarkColors: Checkmark.Colors {
        get {
            checkmark.colors
        } set {
            checkmark.colors = newValue
        }
    }

    public override var isSelected: Bool {
        get {
            checkmark.isSelected
        } set {
            wrapee.alpha = newValue ? 1 : 0.5
            checkmark.isSelected = newValue
        }
    }

    public var inset: Double = 10 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    public var checkmarkPosition: CheckmarkPosition = .bottom {
        didSet {
            setNeedsUpdateConstraints()
        }
    }

    // MARK: - UI

    private let wrapee: UIView
    private var checkmark: Checkmark!
    private var button: Button!

    public override func configureViews() {
        addSubviews(wrapee)

        checkmark = Checkmark()
        addSubviews(checkmark)

        button = Button()
        button.isHighlightedBlock = { [weak self] isHighlighted in
            self?.alpha = isHighlighted ? 0.66 : 1
        }
        button.addAction { [weak self] in
            guard let self = self else { return }

            self.isSelected.toggle()
            self.sendActions(for: .primaryActionTriggered)
        }
        addSubviews(button)
    }

    public override func postSetup() {
        isSelected.reassign()
    }

    public override func constraintViews() {
        button.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }

    public override func updateConstraints() {
        switch checkmarkPosition {
        case .leading:
            checkmark.snp.makeConstraints { make in
                make.leading.centerY.equalToSuperview()
                make.trailing.equalTo(wrapee.snp.leading).inset(-inset)
            }

            wrapee.snp.makeConstraints { make in
                make.top.bottom.trailing.equalToSuperview()
            }

        case .trailing:
            checkmark.snp.makeConstraints { make in
                make.trailing.centerY.equalToSuperview()
                make.leading.equalTo(wrapee.snp.trailing).inset(-inset)
            }

            wrapee.snp.makeConstraints { make in
                make.top.bottom.leading.equalToSuperview()
            }

        case .top:
            checkmark.snp.makeConstraints { make in
                make.top.centerX.equalToSuperview()
                make.bottom.equalTo(wrapee.snp.top).inset(-inset)
            }

            wrapee.snp.makeConstraints { make in
                make.leading.trailing.bottom.equalToSuperview()
            }

        case .bottom:
            checkmark.snp.makeConstraints { make in
                make.bottom.centerX.equalToSuperview()
                make.top.equalTo(wrapee.snp.bottom).inset(-inset)
            }

            wrapee.snp.makeConstraints { make in
                make.leading.trailing.top.equalToSuperview()
            }
        }

        super.updateConstraints()
    }
}
