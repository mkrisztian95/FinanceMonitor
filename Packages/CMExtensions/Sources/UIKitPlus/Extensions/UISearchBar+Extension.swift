import UIKit

public extension UISearchBar {
    func updateHeight(height: CGFloat, radius: CGFloat = 8.0) {
        let image: UIImage? = UIImage.image(color: UIColor.clear, size: CGSize(width: 1, height: height))
        setSearchFieldBackgroundImage(image, for: .normal)
        for subview in subviews {
            for subSubViews in subview.subviews {
                for child in subSubViews.subviews {
                    if let textField = child as? UISearchTextField {
                        textField.layer.cornerRadius = radius
                        textField.clipsToBounds = true
                    }
                }
            }
        }
    }
}
