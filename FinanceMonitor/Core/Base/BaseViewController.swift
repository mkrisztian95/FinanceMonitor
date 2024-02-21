import CombinePlus
import Depin
import UIKitPlus

class BaseViewController: UIViewController {

    // MARK: - Private properties

    var bag = CancelBag()

    // MARK: - Public properties

    var isLoading = false

    // MARK: - Life cycle publishers

    private let viewDidLoadSubject = PassthroughSubject<Void, Never>()
    private let viewIsAppearingSubject = PassthroughSubject<Void, Never>()
    private let viewWillAppearSubject = PassthroughSubject<Void, Never>()
    private let viewDidAppearSubject = PassthroughSubject<Void, Never>()
    private let viewWillDisappearSubject = PassthroughSubject<Void, Never>()
    private let viewDidDisappearSubject = PassthroughSubject<Void, Never>()
    private let viewDidLayoutSubviewsSubject = PassthroughSubject<Void, Never>()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        viewDidLoadSubject.send()
        viewDidLoadSubject.send(completion: .finished)
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        viewIsAppearingSubject.send()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewWillAppearSubject.send()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSubject.send()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewWillDisappearSubject.send()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewDidDisappearSubject.send()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewDidLayoutSubviewsSubject.send()
    }

}

// MARK: - BaseViewProtocol

extension BaseViewController: BaseViewProtocol {
    var viewWillAppearPublisher: AnyPublisher<Void, Never> {
        viewWillAppearSubject.eraseToAnyPublisher()
    }

    var viewDidAppearPublisher: AnyPublisher<Void, Never> {
        viewDidAppearSubject.eraseToAnyPublisher()
    }

    var viewDidLoadPublisher: AnyPublisher<Void, Never> {
        viewDidLoadSubject.eraseToAnyPublisher()
    }

    var viewIsAppearingPublisher: AnyPublisher<Void, Never> {
        viewIsAppearingSubject.eraseToAnyPublisher()
    }

    var viewWillDisappearPublisher: AnyPublisher<Void, Never> {
        viewWillDisappearSubject.eraseToAnyPublisher()
    }

    var viewDidDisappearPublisher: AnyPublisher<Void, Never> {
        viewDidDisappearSubject.eraseToAnyPublisher()
    }

    var viewDidLayoutSubviewsPublisher: AnyPublisher<Void, Never> {
        viewDidLayoutSubviewsSubject.eraseToAnyPublisher()
    }
}
