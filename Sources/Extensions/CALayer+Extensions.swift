import UIKit

extension CALayer {
    public func removeAllSublayers() {
        guard let sublayers = sublayers else { return }

        for sublayer in sublayers {
            sublayer.removeFromSuperlayer()
        }
    }
}
