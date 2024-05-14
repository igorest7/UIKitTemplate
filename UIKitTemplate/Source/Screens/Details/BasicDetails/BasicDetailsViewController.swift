import Combine
import UIKit

final class BasicDetailsViewController: UIViewController {

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .fontWith(format: .title)
            titleLabel.textColor = .textCustom
        }
    }

    @IBOutlet private var backButton: UIButton! {
        didSet {
            backButton.titleLabel?.font = .fontWith(format: .button)
            backButton.titleLabel?.textColor = .textCustom
        }
    }

    @IBOutlet private var additionalDetailsButton: UIButton! {
        didSet {
            additionalDetailsButton.titleLabel?.font = .fontWith(format: .button)
            additionalDetailsButton.titleLabel?.textColor = .textCustom
        }
    }

    private let viewModel: BasicDetailsViewModel

    public init(viewModel: BasicDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "BasicDetailsViewController", bundle: nil)
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

    private func refreshState(_ state: BasicDetailsViewState) {
        titleLabel.text = state.pageTitle
        backButton.setTitle(state.backButtonTitle, for: .normal)
        additionalDetailsButton.setTitle(state.openDetailsButtonTitle, for: .normal)
    }

    @IBAction func backTapped(_ sender: Any) {
        viewModel.backTapped()
    }

    @IBAction func additionalDetailsTapped(_ sender: Any) {
        viewModel.additionalDetailsTapped()
    }
}
