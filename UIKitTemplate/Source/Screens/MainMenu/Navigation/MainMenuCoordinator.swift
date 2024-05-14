import Combine
import UIKit

class MainMenuCoordinator {

    private let router = MainMenuRouter()
    let rootViewController: UIViewController
    private let viewModelFactory: ViewModelFactory
    private var child: DetailsCoordinator?

    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory

        rootViewController = MainMenuViewController(viewModel: viewModelFactory.buildMainMenuViewModel(with: router))
        setup()
    }

    private func setup() {
        router.routingPublisher
            .subscribe(
                Subscribers.Sink(
                    receiveCompletion: { _ in },
                    receiveValue: (
                        { [weak self] routeRequest in
                            self?.handleRouteRequest(to: routeRequest)
                        }
                    )
                )
            )
    }

    private func handleRouteRequest(to route: MainMenuRouter.Route) {
        switch route {
            case .details(let detailsTitle):
                let coordinator = DetailsCoordinator(viewModelFactory: viewModelFactory, basicDetailsPageTitle: detailsTitle) { [weak self] in
                    self?.done()
                }
                child = coordinator
                coordinator.rootViewController.modalPresentationStyle = .fullScreen
                rootViewController.present(coordinator.rootViewController, animated: true, completion: nil)
        }
    }

    func done() {
        rootViewController.dismiss(animated: true, completion: nil)
    }

}
