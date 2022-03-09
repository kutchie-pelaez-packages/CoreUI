import UIKit

extension UIImage {
    public convenience init?(
        color: UIColor,
        size: CGSize = CGSize(1)
    ) {
        let rect = CGRect(
            origin: .zero,
            size: size
        )

        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }

        self.init(cgImage: cgImage)
    }

    public func scaledPreservingAspectRatio(targetSize: CGSize) -> UIImage {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        let scaleFactor = min(widthRatio, heightRatio)

        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(
                in: CGRect(
                    origin: .zero,
                    size: scaledImageSize
                )
            )
        }

        return scaledImage
    }
}
