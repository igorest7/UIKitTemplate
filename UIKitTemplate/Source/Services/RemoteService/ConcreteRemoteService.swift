class ConcreteRemoteService: RemoteService {
    func fetchData(completion: (String) -> Void) {
        completion("data")
    }
}
