import UIKit

public extension UIImage {
    class func image(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsImageRenderer(size: size).image { rendererContext in
            color.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }

    func fixOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        draw(in: rect)
        let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return normalizedImage
    }

    func blurred(
        withRadius radius: CGFloat = 5.0,
        completion: @escaping (UIImage?) -> Void
    ) {
        DispatchQueue.global(qos: .userInteractive).async {
            let context = CIContext()

            let currentFilter = CIFilter(name: "CIGaussianBlur")
            guard let beginImage = CIImage(image: self) else {
                return completion(nil)
            }
            currentFilter?.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter?.setValue(radius, forKey: kCIInputRadiusKey)

            let cropFilter = CIFilter(name: "CICrop")
            cropFilter?.setValue(currentFilter?.outputImage, forKey: kCIInputImageKey)
            cropFilter?.setValue(CIVector(cgRect: beginImage.extent), forKey: "inputRectangle")

            guard let output = cropFilter?.outputImage,
                  let cgImage = context.createCGImage(output, from: output.extent)
            else {
                return completion(nil)
            }

            let processedImage = UIImage(cgImage: cgImage)

            return completion(processedImage)
        }
    }
}
