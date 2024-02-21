import AVFoundationPlus
import Depin

class AppAssembly: Assembly {

    func assemble(container: Swinject.Container) {

        container.register(ModuleBuilder.self) {
            ModuleBuilder()
        }

        container.register(UserProfileViewStateFactory.self) {
            UserProfileViewStateFactory()
        }

        container.register(LifecycleHandler.self) {
            LifecycleHandler()
        }

        container.register(TransactionsNetworkService.self) {
            TransactionsNetworkService()
        }

        container.register(GetTransactionsUseCaseProtocol.self) { r in
            GetTransactionsUseCase(
                networkService: r ~> TransactionsNetworkService.self
            )
        }

        container.registerSynchronized(ApplicationLifeCycleCompositor.self) { r in
            ApplicationLifeCycleCompositor(delegates: [
                r ~> LifecycleHandler.self
            ])
        }
        .inObjectScope(.container)

        container.register(CameraSessionService.self) {
            CameraSessionService(with: nil)
        }
    }
}
