import Depin
import UIKit
import XCoordinator

enum AppRoute: Route {

    case initial
}

class AppCoordinator: NavigationCoordinator<AppRoute> {

    init() {
        super.init(
            rootViewController: UINavigationController(),
            initialRoute: .initial
        )
    }

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {

        case .initial:
            let viewController = moduleBuilder.build(.initial(router: strongRouter))
            return .set([viewController])
        }
    }
}
