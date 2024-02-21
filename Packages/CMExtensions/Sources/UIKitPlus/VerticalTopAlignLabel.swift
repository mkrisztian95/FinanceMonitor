// Source: https://stackoverflow.com/questions/1054558/vertically-align-text-to-top-within-a-uilabel

import UIKit

public class VerticalTopAlignLabel: UILabel {
    public override func drawText(in rect: CGRect) {
        guard let text, let font else {
            return super.drawText(in: rect)
        }

        let attributedText = NSAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.font: font]
        )

        var newRect = rect

        newRect.size.height = attributedText.boundingRect(
            with: rect.size,
            options: .usesLineFragmentOrigin,
            context: nil
        ).size.height

        if numberOfLines != 0 {
            newRect.size.height = min(
                newRect.size.height,
                CGFloat(numberOfLines) * font.lineHeight
            )
        }

        super.drawText(in: newRect)
    }
}
