import UIKit

public protocol ImageProvider {
    var providee: UIImage { get }
}

public protocol ColorProvider {
    var providee: UIColor { get }
}

public protocol FontProvider {
    var providee: UIFont { get }
}
