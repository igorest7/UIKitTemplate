import UIKit

final class MainMenuViewController: UIViewController, CombineCancellableHolder {

    //MARK: - IBOutlets
    @IBOutlet private var titleLabel: UILabel! {
        didSet { 
            titleLabel.font = UIFont.fontWith(format: .title)
            titleLabel.textColor = Color.text
        }
    }

    @IBOutlet private var dataLabel: UILabel! {
        didSet {
            dataLabel.font = UIFont.fontWith(format: .body)
            dataLabel.textColor = Color.text
        }
    }

    @IBOutlet private var openDetailsButton: UIButton! {
        didSet {
            openDetailsButton.setTitle(Localizable.mainMenuDetailsButtonTitle, for: .normal)
        }
    }

    @IBOutlet private var refreshButton: UIButton! {
        didSet {
            refreshButton.setTitle(Localizable.mainMenuRefreshButtonTitle, for: .normal)
        }
    }

    //MARK: - Properties
    private let viewModel: MainMenuViewModel

    // MARK: - Init
    public init(viewModel: MainMenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MainMenuViewController", bundle: nil)
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
        let cancellable = viewModel.statePublisher.receive(on: DispatchQueue.main).sink(
            receiveValue: { [weak self] state in
                guard let self = self else { return }
                self.refreshState(state)
            }
        )
        cancellables.append(cancellable)
    }

    private func refreshState(_ state: MainMenuViewState) {
        dataLabel.text = state.dataString
    }

    @IBAction func openDetailsTapped(_ sender: Any) {
        viewModel.openDetailsTapped()
    }

    @IBAction func refreshTapped(_ sender: Any) {
        viewModel.refreshTapped()
    }
}
