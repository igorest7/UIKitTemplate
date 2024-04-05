import UIKit

final class AppCoordinator {

    // MARK: - Properties

    private let assembler: Assembler
    private var coordinator: MainMenuCoordinator?

    // MARK: - Life cycle

    init(assembler: Assembler) {
        self.assembler = assembler
    }

    // MARK: - Setup

    func setup(for window: UIWindow) {
        let coordinator = MainMenuCoordinator(assembler: assembler)
        self.coordinator = coordinator
        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
    }

}
