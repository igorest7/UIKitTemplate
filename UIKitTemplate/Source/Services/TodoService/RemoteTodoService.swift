import Foundation
import Combine

class RemoteTodoService: TodoService {

    let baseURL: URL

    init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func fetchTodos() -> AnyPublisher<[Todo], TodoServiceError> {
        URLSession.shared.dataTaskPublisher(for: baseURL)
                    .map(\.data)
                    .decode(type: [Todo].self, decoder: JSONDecoder())
                    .mapError { _ in
                        TodoServiceError.requestFailed
                    }
                    .eraseToAnyPublisher()
    }
}
