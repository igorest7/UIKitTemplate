import UIKit

class MainMenuCoordinator: ParentCoordinator {

    private let router = MainMenuRouter()
    let rootViewController: UIViewController
    private let assembler: Assembler
    private var child: DetailsCoordinator?

    init(assembler: Assembler) {
        self.assembler = assembler

        rootViewController = assembler.assembleMainMenu(with: router)
        setup()
    }

    private func setup() {
        router.onRouteRequest = { [weak self] in self?.handleRouteRequest(to: $0) }
    }

    private func handleRouteRequest(to route: MainMenuRouter.Route) {
        switch route {
            case .openDetails:
                let coordinator = DetailsCoordinator(parent: self, assembler: assembler)
                child = coordinator
                coordinator.rootViewController.modalPresentationStyle = .fullScreen
                rootViewController.present(coordinator.rootViewController, animated: true, completion: nil)
        }
    }

    func done() {
        rootViewController.dismiss(animated: true, completion: nil)
    }

}
