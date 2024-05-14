import Combine

protocol MainMenuViewModel {
    var statePublisher: CurrentValueSubject<MainMenuViewState, Never> { get }

    func openDetailsTapped()
    func refreshTapped()
}
