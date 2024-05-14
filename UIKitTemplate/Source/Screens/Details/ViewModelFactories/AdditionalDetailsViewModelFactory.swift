protocol AdditionalDetailsViewModelFactory {

    func buildAdditionalDetailsViewModel(with router: DetailsRouter, pageTitle: String) -> AdditionalDetailsViewModel

}

extension ConcreteViewModelFactory: AdditionalDetailsViewModelFactory {

    func buildAdditionalDetailsViewModel(with router: DetailsRouter, pageTitle: String) -> AdditionalDetailsViewModel {
        ConcreteAdditionalDetailsViewModel(router: router, pageTitle: pageTitle)
    }

}
