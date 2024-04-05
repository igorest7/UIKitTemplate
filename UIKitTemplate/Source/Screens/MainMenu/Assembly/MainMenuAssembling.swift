import UIKit

protocol MainMenuAssembling {

    func assembleMainMenu(with router: MainMenuRouter) -> UIViewController

}

extension ConcreteAssembler: MainMenuAssembling {

    func assembleMainMenu(with router: MainMenuRouter) -> UIViewController {
        let viewModel = MainMenuViewModel(router: router, remoteService: appDependencyProvider.remoteService)
        let viewController = MainMenuViewController(viewModel: viewModel)
        return viewController
    }

}
