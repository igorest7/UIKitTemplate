import Combine
import UIKit

final class MainMenuViewController: UIViewController {

    @IBOutlet private var titleLabel: UILabel! {
        didSet { 
            titleLabel.font = UIFont.fontWith(format: .title)
            titleLabel.textColor = .textCustom
        }
    }

    @IBOutlet private var dataLabel: UILabel! {
        didSet {
            dataLabel.font = UIFont.fontWith(format: .body)
            dataLabel.textColor = .textCustom
        }
    }

    @IBOutlet private var openDetailsButton: UIButton! {
        didSet {
            openDetailsButton.titleLabel?.font = .fontWith(format: .button)
            openDetailsButton.titleLabel?.textColor = .textCustom
        }
    }

    @IBOutlet private var refreshButton: UIButton! {
        didSet {
            refreshButton.titleLabel?.font = .fontWith(format: .button)
            refreshButton.titleLabel?.textColor = .textCustom
        }
    }

    @IBOutlet private var openURLButton: UIButton! {
        didSet {
            openURLButton.titleLabel?.font = .fontWith(format: .button)
            openURLButton.titleLabel?.textColor = .textCustom
        }
    }

    private let viewModel: MainMenuViewModel

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

    private func refreshState(_ state: MainMenuViewState) {
        titleLabel.text = state.pageTitle
        dataLabel.text = state.dataText
        openDetailsButton.setTitle(state.openDetailsButtonTitle, for: .normal)
        refreshButton.setTitle(state.refreshDetailsButtonTitle, for: .normal)
        openURLButton.setTitle(state.openURLButtonTitle, for: .normal)
    }

    @IBAction func openDetailsTapped(_ sender: Any) {
        viewModel.openDetailsTapped()
    }

    @IBAction func refreshTapped(_ sender: Any) {
        viewModel.refreshTapped()
    }

    @IBAction func openURLTapped(_ sender: Any) {
        UIApplication.shared.open(URL(string: "details://openDetails?title=url%20opened") ?? URL(filePath: ""))
    }
}
