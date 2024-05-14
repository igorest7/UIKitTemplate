import Combine
import Foundation

class ConcreteMainMenuViewModel: MainMenuViewState, MainMenuViewModel {

    lazy var statePublisher: CurrentValueSubject<MainMenuViewState, Never> = .init(self)

    private(set) var dataText = Localizable.mainMenuDataTextNotLoaded
    private(set) var pageTitle = Localizable.mainMenuTitle
    private(set) var openDetailsButtonTitle = Localizable.mainMenuDetailsButtonTitle
    private(set) var refreshDetailsButtonTitle = Localizable.mainMenuRefreshButtonTitle
    private(set) var openURLButtonTitle = Localizable.mainMenuOpenURLButtonTitle
    private(set) var error: ViewStateError?

    private let router: MainMenuRouter
    private let todoService: TodoService

    private var todos = [Todo]()

    init(router: MainMenuRouter, todoService: TodoService) {
        self.router = router
        self.todoService = todoService
    }

    func openDetailsTapped() {
        router.routingPublisher.send(.details(detailsTitle: dataText))
    }

    func refreshTapped() {
        dataText = Localizable.mainMenuDataTextLoading

        updateState()

        todoService.fetchTodos()
            .subscribe(
                Subscribers.Sink(
                    receiveCompletion: { [weak self] completion in
                        guard case .failure(let error) = completion else { return }
                        self?.error = error.asViewStateError
                        self?.updateState()
                    },
                    receiveValue: (
                        { [weak self] todos in
                            guard let self = self else { return }
                            self.todos = todos

                            guard let todo = todos.first else {
                                self.dataText = Localizable.mainMenuDataTextEmpty
                                self.updateState()
                                return
                            }
                            self.dataText = Localizable.mainMenuDataTextPrefix + todo.title
                            self.updateState()
                        }
                    )
                )
            )
    }

    private func updateState() {
        statePublisher.send(self)
    }

    func openSheetTapped() {}
}

