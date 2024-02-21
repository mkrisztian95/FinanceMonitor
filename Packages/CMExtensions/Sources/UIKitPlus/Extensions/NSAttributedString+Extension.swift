import UIKit

public extension NSAttributedString {
    var mutableAttributedString: NSMutableAttributedString {
        .init(attributedString: self)
    }
}
