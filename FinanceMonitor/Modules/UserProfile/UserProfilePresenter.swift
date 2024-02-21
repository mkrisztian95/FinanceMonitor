import CombinePlus
import Depin
import UIKit
import XCoordinator

class UserProfilePresenter {

    // MARK: - Injected properties

    @Injected private var factory: UserProfileViewStateFactory
    @Injected private var useCase: GetTransactionsUseCaseProtocol

    private unowned let view: UserProfileViewProtocol
    private let router: StrongRouter<AppRoute>

    private var bag = CancelBag()

    init(
        router: StrongRouter<AppRoute>,
        view: UserProfileViewProtocol
    ) {
        self.router = router
        self.view = view

        bind()
    }

    deinit {
        print(" ☠️☠️☠️ DEINIT: \(String(describing: self))")
    }
}

private extension UserProfilePresenter {
    func bind() {
        view.viewDidLoadPublisher
            .sink { [unowned self] in
                bindOnLoad()
                useCase.fetchTransactions()
            }
            .store(in: &bag)
    }

    func bindOnLoad() {
        useCase.transactionsPublisher
            .assertNoFailure()
            .compactMap { [weak self] in
                self?.factory.make(transactionModel: $0)
            }
            .onMain()
            .sink { [unowned self] in
                view.apply($0)
            }
            .store(in: &bag)

        view.filterPublisher
            .sink { [unowned self] in
                useCase.toggleFilter($0)
            }
            .store(in: &bag)
    }
}
