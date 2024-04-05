class MainMenuRouter {

    enum Route {
        case openDetails
    }

    var onRouteRequest: ((Route) -> Void)?

    func route(to route: Route) {
        onRouteRequest?(route)
    }

}
