import Combine
import Foundation

class MainMenuViewModel: CombineCancellableHolder, MainMenuViewState {

    lazy var statePublisher: CurrentValueSubject<MainMenuViewState, Never> = .init(self)

    private(set) var dataString = Localizable.mainMenuDataTextNotLoaded
    private(set) var titleString = Localizable.mainMenuTitle
    private(set) var error: ViewStateError?

    private let router: MainMenuRouter
    private let todoService: TodoService

    private var todos = [Todo]()

    init(router: MainMenuRouter, todoService: TodoService) {
        self.router = router
        self.todoService = todoService
    }

    func openDetailsTapped() {
        router.route(to: .openDetails)
    }

    func refreshTapped() {
        dataString = Localizable.mainMenuDataTextLoading
        updateState()
        todoService.fetchTodos()
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self, case .failure(let error) = completion else { return }
                    self.error = error.asViewStateError
                    self.updateState()
                },
                receiveValue: { [weak self] todos in
                    guard let self = self else { return }
                    self.todos = todos
                    guard let todo = todos.first else {
                        self.dataString = Localizable.mainMenuDataTextEmpty
                        return
                    }
                    self.dataString = Localizable.mainMenuDataTextPrefix + todo.title
                    self.updateState()
                }
            )
            .store(in: &cancellables)
    }

    private func updateState() {
        self.statePublisher.send(self)
    }
}

