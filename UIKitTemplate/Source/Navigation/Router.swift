protocol Router {

    associatedtype Route

    func route(to route: Route)
    
}
