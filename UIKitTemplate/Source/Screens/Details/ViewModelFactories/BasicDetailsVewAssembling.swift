protocol BasicDetailsViewModelFactory {

    func buildBasicDetailsViewModel(with router: DetailsRouter, pageTitle: String) -> BasicDetailsViewModel

}

extension ConcreteViewModelFactory: BasicDetailsViewModelFactory {

    func buildBasicDetailsViewModel(with router: DetailsRouter, pageTitle: String) -> BasicDetailsViewModel {
        ConcreteBasicDetailsViewModel(router: router, pageTitle: pageTitle)
    }

}
