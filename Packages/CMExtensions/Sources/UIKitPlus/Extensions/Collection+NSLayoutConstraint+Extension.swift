import UIKit

public extension Collection where Element == NSLayoutConstraint? {
    func setConstant(_ constant: CGFloat) {
        forEach { $0?.constant = constant }
    }

    func setIsActive(_ isActive: Bool) {
        forEach { $0?.isActive = isActive }
    }
}
