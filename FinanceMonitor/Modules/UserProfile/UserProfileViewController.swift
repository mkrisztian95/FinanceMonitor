import Charts
import CombinePlus
import UIKitPlus

protocol UserProfileViewProtocol: BaseViewProtocol {
    var filterPublisher: AnyPublisher<TransactionEntity.TransactionCategory, Never> { get }
    func apply(_ viewState: UserProfileViewController.ViewState)
}

class UserProfileViewController: BaseViewController {

    let cellIdentifier = "CustomCell"

    // MARK: - ViewState

    struct ViewState {
        let transactionsViewState: [TransactionItemView.ViewState]
        let availableCategories: [TransactionEntity.TransactionCategory]
        let chartData: PieChartData
    }

    @IBOutlet private var categoriesWrapper: UIView!
    @IBOutlet private var chartView: PieChartView!
    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var chartHeight: NSLayoutConstraint!
    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!

    // MARK: - Private properties

    private lazy var categoriesView = CategoriesView()

    // MARK: - Public properties

    var presenter: UserProfilePresenter!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .primary500
        stackView.removeAllArrangedSubviews()
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        categoriesView.preparedForAutoLayout()
        categoriesWrapper.addSubview(categoriesView)
        NSLayoutConstraint.activate {
            categoriesView.topAnchor.constraint(equalTo: categoriesWrapper.topAnchor)
            categoriesView.leadingAnchor.constraint(equalTo: categoriesWrapper.leadingAnchor)
            categoriesView.trailingAnchor.constraint(equalTo: categoriesWrapper.trailingAnchor)
            categoriesView.bottomAnchor.constraint(equalTo: categoriesWrapper.bottomAnchor)
        }
    }
}

// MARK: - InitialViewProtocol

extension UserProfileViewController: UserProfileViewProtocol {

    var filterPublisher: AnyPublisher<TransactionEntity.TransactionCategory, Never> {
        categoriesView.categorySelectedPublisher
    }

    func apply(_ viewState: ViewState) {
        loadingIndicator.isHidden = true
        stackView.removeAllArrangedSubviews()

        let views = viewState.transactionsViewState.map { viewState in
            TransactionItemView().apply(viewState)
        }
        stackView.addArrangedSubviewsWithAnimation(views)

        chartView.setHidden(false, withDuration: .zero)
        chartHeight.constant = view.bounds.height / 4

        categoriesWrapper.applyIfPresent(viewState.availableCategories) { viewState in
            categoriesView.configure(with: viewState)
        }

        chartView.data = viewState.chartData
        chartView.drawEntryLabelsEnabled = false
        chartView.highlightValues(nil)

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
