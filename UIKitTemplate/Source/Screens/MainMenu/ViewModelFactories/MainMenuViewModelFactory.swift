protocol MainMenuViewModelFactory {

    func buildMainMenuViewModel(with router: MainMenuRouter) -> MainMenuViewModel

}

extension ConcreteViewModelFactory: MainMenuViewModelFactory {

    @MainActor func buildMainMenuViewModel(with router: MainMenuRouter) -> MainMenuViewModel {
        ConcreteMainMenuViewModel(router: router, todoService: appDependencyProvider.todoService)
    }

}
