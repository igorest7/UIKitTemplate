@testable import UIKitTemplate
import XCTest

class MainMenuViewModelTests: XCTestCase, CombineCancellableHolder {

    private var viewModel: MainMenuViewModel!
    private var todoService: MockTodoService!
    private var lastRouteRequest: MainMenuRouter.Route?
    private var lastState: MainMenuViewState?

    override func setUp() {
        let router = MainMenuRouter()
        router.onRouteRequest = { [weak self] route in
            self?.lastRouteRequest = route
        }
        todoService = MockTodoService()
        viewModel = MainMenuViewModel(router: router, todoService: todoService)

        let cancellable = viewModel.statePublisher.sink(
            receiveValue: { [weak self] state in
                self?.lastState = state
            }
        )
        cancellables.append(cancellable)
    }

    func test_init_SetsNotLoadedDatString() {
        XCTAssertEqual(lastState?.dataString, Localizable.mainMenuDataTextNotLoaded)
    }

    func test_openDetails_RoutesToDetails() {
        viewModel.openDetailsTapped()
        XCTAssertEqual(lastRouteRequest, .openDetails)
    }

    func test_refreshTapped_SetsLoadingDataString() {
        viewModel.refreshTapped()
        XCTAssertEqual(lastState?.dataString, Localizable.mainMenuDataTextLoading)
    }

    func test_refreshTapped_WhenRemoteDataFetchedEmpty_SetsEmptyDataString() {
        viewModel.refreshTapped()
        todoService.fetchDataPublisher.send([])
        XCTAssertEqual(lastState?.dataString, Localizable.mainMenuDataTextEmpty)
    }

    func test_refreshTapped_WhenRemoteDataFetched_UpdatesDataTextStateWithFirstItemTitle() {
        viewModel.refreshTapped()
        todoService.fetchDataPublisher.send(
            [
                .build { $0.title = "first item" },
                .build { $0.title = "second item" }
            ]
        )
        XCTAssertEqual(lastState?.dataString, "Fetched todo: first item")
    }

    func test_refreshTapped_WhenRemoteDataFetchFails_UpdatesErrorStateWithRequetFailedDescription() {
        viewModel.refreshTapped()
        todoService.fetchDataPublisher.send(completion: .failure(.requestFailed))
        XCTAssertEqual(lastState?.error?.description, "Request failed")
    }
}
