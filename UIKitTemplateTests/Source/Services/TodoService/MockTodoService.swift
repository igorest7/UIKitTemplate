import Combine
@testable import UIKitTemplate

class MockTodoService: TodoService {

    var fetchDataPublisher: PassthroughSubject<[Todo], TodoServiceError> = .init()

    func fetchTodos() -> AnyPublisher<[Todo], TodoServiceError> {
        return fetchDataPublisher.eraseToAnyPublisher()
    }
}
