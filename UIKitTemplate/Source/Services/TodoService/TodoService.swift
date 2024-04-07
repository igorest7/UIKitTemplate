import Combine

protocol TodoService {
    func fetchData() -> AnyPublisher<[Todo], TodoServiceError>
}
