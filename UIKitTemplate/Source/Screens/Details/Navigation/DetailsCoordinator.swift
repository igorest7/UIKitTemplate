import Combine
import UIKit

class DetailsCoordinator: NSObject {

    private let router = DetailsRouter()
    let rootViewController: UIViewController
    private let navigationController: UINavigationController
    private let viewModelFactory: ViewModelFactory
    private let onDone: () -> Void

    init(
        viewModelFactory: ViewModelFactory,
        navigationController: UINavigationController = UINavigationController(),
        basicDetailsPageTitle: String,
        onDone: @escaping () -> Void
    ) {
        self.viewModelFactory = viewModelFactory
        self.navigationController = navigationController
        self.onDone = onDone
        rootViewController = navigationController
        super.init()

        let viewModel = viewModelFactory.buildBasicDetailsViewModel(with: router, pageTitle: basicDetailsPageTitle)
        let viewController = BasicDetailsViewController(viewModel: viewModel)

        navigationController.viewControllers = [viewController]
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
        setupNavigationBar()
    }

    func setupNavigationBar() {
        navigationController.navigationBar.backgroundColor = .mainCustom
        navigationController.navigationBar.isTranslucent = false
    }

    private func handleRouteRequest(to route: DetailsRouter.Route) {
        let viewController: UIViewController
        switch route {
            case .closeJourney:
                onDone()
                return
            case .back:
                navigationController.popViewController(animated: true)
                return
            case .additionalDetails(let pageTitle):
                viewController = AdditionalDetailsViewController(viewModel: viewModelFactory.buildAdditionalDetailsViewModel(with: router, pageTitle: pageTitle))
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
