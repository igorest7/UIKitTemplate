import UIKit

class DetailsCoordinator: NSObject {

    private let router = DetailsRouter()
    let rootViewController: UIViewController
    private let navigationController: UINavigationController
    private let assembler: Assembler
    private let parent: ParentCoordinator

    init(
        parent: ParentCoordinator,
        assembler: Assembler,
        navigationController: UINavigationController = UINavigationController()
    ) {
        self.assembler = assembler
        self.navigationController = navigationController
        self.parent = parent
        rootViewController = navigationController
        super.init()

        let basicDetailsView = assembler.assembleBasicDetailsView(with: router)

        addBackButton(to: basicDetailsView)
        navigationController.viewControllers = [basicDetailsView]
        setup()
    }


    private func setup() {
        router.onRouteRequest = { [weak self] in self?.handleRouteRequest(to: $0) }

        setupNavigationBar()
    }

    func setupNavigationBar() {
        navigationController.navigationBar.backgroundColor = Color.main
        navigationController.navigationBar.isTranslucent = false
    }

    private func handleRouteRequest(to route: DetailsRouter.Route) {
        let viewController: UIViewController
        switch route {
            case .mainMenu:
                parent.done()
                return
            case.additionalDetails:
            viewController = assembler.assembleAdditionalDetailsView(with: router)
        }
        addBackButton(to: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }

    func done() {
        navigationController.dismiss(animated: true, completion: nil)
    }

    private func addBackButton(to viewController: UIViewController) {
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "arrow.left.square.fill"), for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        backButton.frame = CGRect(x: 0, y: 0, width: 60, height: 44)

        let barButton = UIBarButtonItem(customView: backButton)
        viewController.navigationItem.leftBarButtonItem = barButton
    }

    @objc
    private func backTapped() {
        if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
             handleRouteRequest(to: .mainMenu)
        }
    }
}
