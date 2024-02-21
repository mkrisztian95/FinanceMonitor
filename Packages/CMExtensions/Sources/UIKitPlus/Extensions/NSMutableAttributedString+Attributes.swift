import UIKit

public extension NSMutableAttributedString {
    @discardableResult
    func addAttributes(_ attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let substringRange = (string as NSString).range(of: string)
        guard substringRange.location != NSNotFound else {
            return self
        }

        addAttributes(attributes, range: substringRange)
        return self
    }

    @discardableResult
    func addAttributes(_ attributes: [NSAttributedString.Key: Any], to substring: String) -> NSMutableAttributedString {
        let substringRange = (string as NSString).range(of: substring)
        guard substringRange.location != NSNotFound else {
            return self
        }

        addAttributes(attributes, range: substringRange)
        return self
    }

    @discardableResult
    func coloredSubstring(_ substring: String, with color: UIColor) -> NSMutableAttributedString {
        addAttributes([NSAttributedString.Key.foregroundColor: color], to: substring)
    }

    @discardableResult
    func setLineHeightMultiple(_ value: CGFloat) -> NSMutableAttributedString {
        let paragraphStyle = currentParagraphStyle() ?? .init()
        paragraphStyle.lineHeightMultiple = value
        return addAttributes([.paragraphStyle: paragraphStyle])
    }

    @discardableResult
    func setTextColor(_ color: UIColor) -> NSMutableAttributedString {
        addAttributes([.foregroundColor: color])
    }

    @discardableResult
    func setTextColor(_ color: UIColor, to substring: String) -> NSMutableAttributedString {
        addAttributes([.foregroundColor: color], to: substring)
    }

    @discardableResult
    func setFont(_ font: UIFont) -> NSMutableAttributedString {
        addAttributes([.font: font])
    }

    @discardableResult
    func setFont(_ font: UIFont, to substring: String) -> NSMutableAttributedString {
        addAttributes([.font: font], to: substring)
    }

    @discardableResult
    func setKern(_ kern: Double) -> NSMutableAttributedString {
        addAttributes([.kern: kern])
    }

    @discardableResult
    func setKern(_ kern: Double, to substring: String) -> NSMutableAttributedString {
        addAttributes([.kern: kern], to: substring)
    }

    @discardableResult
    func strikedthrough() -> NSMutableAttributedString {
        addAttributes([.strikethroughStyle: NSUnderlineStyle.single.rawValue])
    }

    @discardableResult
    func strikethrough(_ substring: String) -> NSMutableAttributedString {
        addAttributes([.strikethroughStyle: NSUnderlineStyle.single.rawValue], to: substring)
    }

    var attributedString: NSAttributedString {
        .init(attributedString: self)
    }

    @discardableResult
    func setAlignment(_ alignment: NSTextAlignment) -> NSMutableAttributedString {
        let paragraphStyle = currentParagraphStyle() ?? .init()
        paragraphStyle.alignment = alignment
        return addAttributes([.paragraphStyle: paragraphStyle])
    }
}

private extension NSMutableAttributedString {
    func currentParagraphStyle() -> NSMutableParagraphStyle? {
        guard !string.isEmpty else { return nil }
        let attributes = attributes(at: 0, effectiveRange: nil)
        return attributes[.paragraphStyle] as? NSMutableParagraphStyle
    }
}
