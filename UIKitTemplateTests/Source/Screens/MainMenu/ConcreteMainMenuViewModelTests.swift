import Combine
@testable import UIKitTemplate
import XCTest

class ConcreteMainMenuViewModelTests: XCTestCase {

    private var viewModel: ConcreteMainMenuViewModel!
    private var todoService: MockTodoService!
    private var lastRouteRequest: MainMenuRouter.Route?
    private var lastState: MainMenuViewState?

    override func setUp() {
        let router = MainMenuRouter()
        router.routingPublisher
            .subscribe(
                Subscribers.Sink(
                    receiveCompletion: { _ in },
                    receiveValue: (
                        { [weak self] route in
                            self?.lastRouteRequest = route
                        }
                    )
                )
            )
        todoService = MockTodoService()
        viewModel = ConcreteMainMenuViewModel(router: router, todoService: todoService)

        viewModel.statePublisher
            .subscribe(
                Subscribers.Sink(
                    receiveCompletion: { _ in },
                    receiveValue: (
                        { [weak self] state in
                            self?.lastState = state
                        }
                    )
                )
            )
    }

    func test_init_SetsNotLoadedDataString() {
        XCTAssertEqual(lastState?.dataText, Localizable.mainMenuDataTextNotLoaded)
    }

    func test_openDetailsTapped_WhenNotLoaded_RoutesToDetailsWithNotLoadedText() {
        viewModel.openDetailsTapped()
        XCTAssertEqual(lastRouteRequest, .details(detailsTitle: Localizable.mainMenuDataTextNotLoaded))
    }

    func test_openDetailsTapped_WhenTodosLoadInProgress_RoutesToDetailsWithTodoText() {
        viewModel.refreshTapped()
        viewModel.openDetailsTapped()

        XCTAssertEqual(lastRouteRequest, .details(detailsTitle: Localizable.mainMenuDataTextLoading))
    }

    func test_openDetailsTapped_WhenNoTodosLoaded_RoutesToDetailsWithTodoTitle() {
        viewModel.refreshTapped()

        todoService.fetchDataPublisher.send([])

        viewModel.openDetailsTapped()

        XCTAssertEqual(lastRouteRequest, .details(detailsTitle: Localizable.mainMenuDataTextEmpty))
    }

    func test_openDetailsTapped_WhenTodosLoaded_RoutesToDetailsWithTodoTitle() {
        viewModel.refreshTapped()

        todoService.fetchDataPublisher.send([.build { $0.title = "title" }])

        viewModel.openDetailsTapped()

        XCTAssertEqual(lastRouteRequest, .details(detailsTitle: Localizable.mainMenuDataTextPrefix + "title"))
    }

    func test_refreshTapped_SetsLoadingDataString() {
        viewModel.refreshTapped()
        XCTAssertEqual(lastState?.dataText, Localizable.mainMenuDataTextLoading)
    }

    func test_refreshTapped_WhenRemoteDataFetchedEmpty_SetsEmptyDataString() {
        viewModel.refreshTapped()
        todoService.fetchDataPublisher.send([])
        XCTAssertEqual(lastState?.dataText, Localizable.mainMenuDataTextEmpty)
    }

    func test_refreshTapped_WhenRemoteDataFetched_UpdatesDataTextStateWithFirstItemTitle() {
        viewModel.refreshTapped()
        todoService.fetchDataPublisher.send(
            [
                .build { $0.title = "first item" },
                .build { $0.title = "second item" }
            ]
        )
        XCTAssertEqual(lastState?.dataText, "Fetched todo: first item")
    }

    func test_refreshTapped_WhenRemoteDataFetchFails_UpdatesErrorStateWithRequetFailedDescription() {
        viewModel.refreshTapped()
        todoService.fetchDataPublisher.send(completion: .failure(.requestFailed))
        XCTAssertEqual(lastState?.error?.description, "Request failed")
    }
}
