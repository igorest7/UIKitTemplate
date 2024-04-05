import UIKit

protocol AdditionalDetailsViewAssembling {

    func assembleAdditionalDetailsView(with router: DetailsRouter) -> UIViewController

}

extension ConcreteAssembler: AdditionalDetailsViewAssembling {

    func assembleAdditionalDetailsView(with router: DetailsRouter) -> UIViewController {
        let viewModel = AdditionalDetailsViewModel(router: router)
        let viewController = AdditionalDetailsViewController(viewModel: viewModel)
        return viewController
    }

}
