import Combine

protocol BasicDetailsViewModel {
    var statePublisher: CurrentValueSubject<BasicDetailsViewState, Never> { get }

    func backTapped()
    func additionalDetailsTapped()
}
