import UIKit

open class PassthroughView: View {
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(
            point,
            with: event
        ) else {
            return nil
        }

        if hitView.isKind(of: PassthroughView.self) {
            return nil
        }

        return hitView
    }
}
