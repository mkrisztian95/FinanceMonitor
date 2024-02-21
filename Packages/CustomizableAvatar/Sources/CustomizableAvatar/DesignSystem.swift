import UIKit

public struct DesignSystem {
    let backgroundColor: UIColor
    let textViewColor: UIColor
    let optionTitleColor: UIColor
    let buttonTitleColor: UIColor
    let buttonColor: UIColor
    let textViewFont: UIFont
    let optionTItleFont: UIFont
    let buttonFont: UIFont

    public init(
        backgroundColor: UIColor,
        textViewColor: UIColor,
        optionTitleColor: UIColor,
        buttonTitleColor: UIColor,
        buttonColor: UIColor,
        textViewFont: UIFont,
        optionTItleFont: UIFont,
        buttonFont: UIFont
    ) {
        self.backgroundColor = backgroundColor
        self.textViewColor = textViewColor
        self.optionTitleColor = optionTitleColor
        self.buttonTitleColor = buttonTitleColor
        self.buttonColor = buttonColor
        self.textViewFont = textViewFont
        self.optionTItleFont = optionTItleFont
        self.buttonFont = buttonFont
    }
}
