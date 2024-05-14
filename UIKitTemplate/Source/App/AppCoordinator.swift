import UIKit

final class AppCoordinator {

    private let viewModelFactory: ViewModelFactory
    private var coordinator: MainMenuCoordinator?

    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }

    func setup(for window: UIWindow) {
        let coordinator = MainMenuCoordinator(viewModelFactory: viewModelFactory)
        self.coordinator = coordinator
        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
    }
}
