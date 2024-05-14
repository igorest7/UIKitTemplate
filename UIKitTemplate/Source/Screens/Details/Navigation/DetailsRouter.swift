import Combine

struct DetailsRouter {

    enum Route: Equatable {
        case closeJourney
        case back
        case additionalDetails(pageTitle: String)
    }

    var routingPublisher: PassthroughSubject<Route, Never> = .init()

}
