import Foundation
import Combine
@testable import UIKitTemplate

class MockDataPublisherProvider: DataPublisherProvider {

    var mockDataPublisher: PassthroughSubject<DataPublisherResponse, URLError> = .init()

    func dataPublisher(for url: URL) -> AnyPublisher<DataPublisherResponse, URLError> {
        mockDataPublisher.eraseToAnyPublisher()
    }

}
