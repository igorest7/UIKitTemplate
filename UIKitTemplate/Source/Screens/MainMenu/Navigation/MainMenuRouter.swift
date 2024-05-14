import Combine

struct MainMenuRouter {

    enum Route: Hashable {
        case details(detailsTitle: String)
    }

    var routingPublisher: PassthroughSubject<Route, Never> = .init()

}
