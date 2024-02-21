import CombinePlus
import UIKitPlus

class CategoriesView: BaseView {

    var categorySelectedPublisher: AnyPublisher<TransactionEntity.TransactionCategory, Never> {
        selectedCategorySubject.eraseToAnyPublisher()
    }

    private enum Constant {
        static let horizontalOffset = 8.0
        static let verticalOffset = 10.0
    }

    private lazy var gridView: UIView = {
        let view = UIView().preparedForAutoLayout()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var gridHeight = gridView.heightAnchor.constraint(equalToConstant: 0.0)
    private var bag = CancelBag()
    private var selectedCategorySubject: PassthroughSubject<TransactionEntity.TransactionCategory, Never> = .init()

    func configure(with categories: [TransactionEntity.TransactionCategory]) {
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var expectedRowWidth: CGFloat = 0.0
        var scrollHeight: CGFloat = 0.0
        var buttonHeight: CGFloat = 0.0

        gridView.subviews.forEach { view in
            view.removeConstraints(view.constraints)
            view.removeFromSuperview()
        }

        categories
            .map { createItemView(with: $0) }
            .enumerated()
            .forEach { index, view in
                gridView.addSubview(view.preparedForAutoLayout())

                expectedRowWidth += view.frame.width + Constant.horizontalOffset

                if expectedRowWidth < bounds.width {
                    x = index == 0 ? 0 : (expectedRowWidth - view.frame.width - Constant.horizontalOffset)
                } else {
                    x = 0
                    expectedRowWidth = view.frame.width + Constant.horizontalOffset
                    y += view.frame.height + Constant.verticalOffset
                }

                scrollHeight = y
                buttonHeight = view.frame.height + Constant.verticalOffset

                NSLayoutConstraint.activate {
                    view.leadingAnchor.constraint(equalTo: gridView.leadingAnchor, constant: x)
                    view.topAnchor.constraint(equalTo: gridView.topAnchor, constant: y)
                }

                view.fixedSize(CGSize(
                    width: view.frame.width,
                    height: view.frame.height
                ))
            }
        gridHeight.constant = scrollHeight + buttonHeight
        gridHeight.isActive = true

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    override func setup() {
        super.setup()
        addSubview(gridView)

        NSLayoutConstraint.activate {
            gridView.topAnchor.constraint(equalTo: topAnchor)
            gridView.leftAnchor.constraint(equalTo: leftAnchor)
            gridView.rightAnchor.constraint(equalTo: rightAnchor)
            gridView.bottomAnchor.constraint(equalTo: bottomAnchor)
        }
    }

    private func createItemView(with category: TransactionEntity.TransactionCategory) -> UIView {
        let button = UIButton(type: .system)
        button.setTitle(category.rawValue.localizedCapitalized, for: .normal)
        button.backgroundColor = UIColor.black300
        button.titleLabel?.font = .bodyBold
        button.setTitleColor(UIColor.black950)
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.clear.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        button.sizeToFit()
        button.tapPublisher
            .sink { [unowned self] in
                selectedCategorySubject.send(category)
            }
            .store(in: &bag)
        return button
    }
}
