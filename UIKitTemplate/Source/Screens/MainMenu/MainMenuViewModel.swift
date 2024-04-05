import Combine
import Foundation

class MainMenuViewModel {

    var statePublisher: CurrentValueSubject<ViewState<MainMenuViewState>, Never> = .init(.empty)

    private let router: MainMenuRouter
    private let remoteService: RemoteService

    private var dataString = "No data"

    init(router: MainMenuRouter, remoteService: RemoteService) {
        self.router = router
        self.remoteService = remoteService
    }

    func openDetailsTapped() {
        router.route(to: .openDetails)
    }

    func refreshTapped() {
        statePublisher.send(.loading)
        remoteService.fetchData { [weak self] fetchedString in
            self?.dataString = fetchedString
            self?.updateReadyState()
        }
    }

    private func updateReadyState() {
        let state = MainMenuViewState(dataString: dataString)
        statePublisher.send(.ready(state))
    }
}
