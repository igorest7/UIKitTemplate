import UIKit

protocol BasicDetailsViewAssembling {

    func assembleBasicDetailsView(with router: DetailsRouter) -> UIViewController

}

extension ConcreteAssembler: BasicDetailsViewAssembling {

    func assembleBasicDetailsView(with router: DetailsRouter) -> UIViewController {
        let viewModel = BasicDetailsViewModel(router: router)
        let viewController = BasicDetailsViewController(viewModel: viewModel)
        return viewController
    }

}
