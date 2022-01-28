import Combine
import CoreUtils
import UIKit

private var isHighlightedBlockKey: UInt8 = 0
private var isHighlightedCancellableKey: UInt8 = 1

extension UIControl {
    public func addAction(
        for controlEvent: UIControl.Event = .primaryActionTriggered,
        block: @escaping Block
    ) {
        let blockWrapper = BlockRetainer(
            attachTo: self,
            block: block
        )

        addTarget(
            blockWrapper,
            action: #selector(BlockRetainer.invoke),
            for: controlEvent
        )
    }

    public var isHighlightedBlock: BoolBlock? {
        get {
            objc_getAssociatedObject(
                self,
                &isHighlightedBlockKey
            ) as? BoolBlock
        } set {
            objc_setAssociatedObject(
                self,
                &isHighlightedBlockKey,
                newValue,
                .OBJC_ASSOCIATION_RETAIN
            )

            if let newValue = newValue {
                subscribeToIsHighlighted(with: newValue)
            }
        }
    }

    private func subscribeToIsHighlighted(with block: @escaping BoolBlock) {
        isHighlightedCancellable = publisher(for: \.isHighlighted)
            .dropFirst()
            .removeDuplicates()
            .sink { isHighlighted in
                block(isHighlighted)
            }
    }

    private var isHighlightedCancellable: AnyCancellable? {
        get {
            objc_getAssociatedObject(
                self,
                &isHighlightedCancellableKey
            ) as? AnyCancellable
        } set {
            objc_setAssociatedObject(
                self,
                &isHighlightedCancellableKey,
                newValue,
                .OBJC_ASSOCIATION_RETAIN
            )
        }
    }
}
