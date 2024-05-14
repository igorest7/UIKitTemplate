protocol MainMenuViewState {
    var dataText: String { get }
    var pageTitle: String { get }
    var openDetailsButtonTitle: String { get }
    var refreshDetailsButtonTitle: String { get }
    var openURLButtonTitle: String { get }
    var error: ViewStateError? { get }
}
