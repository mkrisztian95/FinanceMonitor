import UIKit

public extension UILabel {
    var requiredNumberOfLines: Int {
        layoutIfNeeded()
        let maxSize = CGSize(
            width: frame.size.width,
            height: CGFloat(Float.infinity)
        )
        let charSize = font.lineHeight
        let text = (text ?? "") as NSString
        let textSize = text.boundingRect(
            with: maxSize,
            options: .usesLineFragmentOrigin,
            attributes: [.font: font as Any],
            context: nil
        )
        let linesRoundedUp = Int(ceil(textSize.height / charSize))
        return linesRoundedUp
    }
}
