import Combine
import UIKit

final class AdditionalDetailsViewController: UIViewController {

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .fontWith(format: .title)
            titleLabel.textColor = .textCustom
        }
    }

    @IBOutlet private var mainMenuButton: UIButton! {
        didSet {
            mainMenuButton.titleLabel?.font = .fontWith(format: .button)
            mainMenuButton.titleLabel?.textColor = .textCustom
        }
    }

    private let viewModel: AdditionalDetailsViewModel

    public init(viewModel: AdditionalDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AdditionalDetailsViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        subscribeToStateUpdates()
    }

    private func subscribeToStateUpdates() {
        viewModel.statePublisher
            .receive(on: DispatchQueue.main)
            .subscribe(
                Subscribers.Sink(
                    receiveCompletion: { _ in},
                    receiveValue: { [weak self] state in
                        guard let self = self else { return }
                        self.refreshState(state)
                    }
                )
            )
    }

    private func refreshState(_ state: AdditionalDetailsViewState) {
        titleLabel.text = state.pageTitle
        mainMenuButton.setTitle(state.mainMenuButtonTitle, for: .normal)
    }

    @IBAction func mainMenuTapped(_ sender: Any) {
        viewModel.mainMenuTapped()
    }
}
