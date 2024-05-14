import Combine

protocol AdditionalDetailsViewModel {
    var statePublisher: CurrentValueSubject<AdditionalDetailsViewState, Never> { get }

    func mainMenuTapped()
}
