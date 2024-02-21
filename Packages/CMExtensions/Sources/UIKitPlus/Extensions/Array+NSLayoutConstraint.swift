import UIKit

public extension Array where Element == NSLayoutConstraint {

    func setActive(_ isActive: Bool) {
        forEach { $0.isActive = isActive }
    }

    func setConstant(_ constant: CGFloat) {
        forEach { $0.constant = constant }
    }
}
