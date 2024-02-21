import UIKit

public extension UITableViewCell {
    static var nib: UINib {
        let nibName = String(describing: Self.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib
    }

    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
