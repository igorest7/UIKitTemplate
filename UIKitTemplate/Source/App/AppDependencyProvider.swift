class AppDependencyProvider {
    lazy var remoteService: RemoteService = {
        ConcreteRemoteService()
    }()
}
