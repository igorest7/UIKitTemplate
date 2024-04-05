import UIKit

class DetailsRouter: Router {

    enum Route {
        case mainMenu
        case additionalDetails
    }

    var onRouteRequest: ((Route) -> Void)?

    func route(to route: Route) {
        onRouteRequest?(route)
    }

}
