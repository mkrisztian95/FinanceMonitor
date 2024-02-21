import Depin
import UIKit
import XCoordinator

class ModuleBuilder {

    // MARK: - Injected properties

    enum Module {
        case initial(
            router: StrongRouter<AppRoute>
        )
    }

    func build(_ module: Module) -> UIViewController {
        switch module {
        case let .initial(router):
            let view = UserProfileViewController()
            let presenter = UserProfilePresenter(
                router: router,
                view: view
            )

            view.presenter = presenter
            return view
        }
    }
}
