import UIKit

extension UILabel {
    public convenience init(
        font: UIFont? = nil,
        textColor: UIColor? = nil,
        numberOfLines: Int? = nil,
        textAlignment: NSTextAlignment? = nil
    ) {
        self.init(frame: .zero)

        if let font = font {
            self.font = font
        }

        if let textColor = textColor {
            self.textColor = textColor
        }

        if let numberOfLines = numberOfLines {
            self.numberOfLines = numberOfLines
        }

        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
    }
}
