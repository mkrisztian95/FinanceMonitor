import UIKit

public extension UITableView {
    func register(type: UITableViewCell.Type) {
        register(type.nib, forCellReuseIdentifier: type.reuseIdentifier)
    }

    /// Usage:
    /// ```
    /// tableView.register(
    ///     FirstCell.self,
    ///     SecondCell.self
    /// )
    /// ```
    func register(_ types: UITableViewCell.Type...) {
        types.forEach { type in
            register(type.nib, forCellReuseIdentifier: type.reuseIdentifier)
        }
    }

    func dequeue<Cell: UITableViewCell>(type: Cell.Type, for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as? Cell
    }
}
