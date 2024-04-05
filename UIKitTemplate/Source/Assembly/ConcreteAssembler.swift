final class ConcreteAssembler: Assembler {

    let appDependencyProvider: AppDependencyProvider

    init(appDependencyProvider: AppDependencyProvider) {
        self.appDependencyProvider = appDependencyProvider
    }

}
