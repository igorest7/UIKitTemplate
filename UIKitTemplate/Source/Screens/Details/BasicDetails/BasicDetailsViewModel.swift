import Foundation

class BasicDetailsViewModel {

    private let router: DetailsRouter

    init(router: DetailsRouter) {
        self.router = router
    }

    func backTapped() {
        router.route(to: .additionalDetails)
    }

}
