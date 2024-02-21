import UIKit

public extension UICollectionView {
    var centerIndex: IndexPath? {
        let centralPoint: CGPoint = .init(
            x: bounds.midX,
            y: bounds.midY
        )
        return indexPathForItem(at: centralPoint)
    }

    func register(type: UICollectionViewCell.Type) {
        register(type.nib, forCellWithReuseIdentifier: type.reuseIdentifier)
    }

    func register(types: UICollectionViewCell.Type...) {
        types.forEach { type in
            register(type.nib, forCellWithReuseIdentifier: type.reuseIdentifier)
        }
    }

    func dequeue<Cell: UICollectionViewCell>(type: Cell.Type, for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withReuseIdentifier: type.reuseIdentifier, for: indexPath) as? Cell
    }

    func scrollToTop(animated: Bool) {
        guard numberOfItems(inSection: 0) != .zero else { return }
        scrollToItem(at: .init(row: 0, section: 0), at: .top, animated: animated)
    }
}
