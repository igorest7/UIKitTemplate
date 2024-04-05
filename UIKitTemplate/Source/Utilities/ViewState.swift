enum ViewState<StateType> {

    case empty
    case loading
    case ready(StateType)
    case error(ClientError)
    
}

extension ViewState where StateType == Void {

    static var ready: ViewState<Void> {
        return .ready(())
    }

}
