import UIKit

final class BasicDetailsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Localizable.basicDetailsTitle
            titleLabel.font = UIFont.fontWith(format: .title)
            titleLabel.textColor = Color.text
        }
    }

    @IBOutlet private var backButton: UIButton! {
        didSet {
            backButton.setTitle(Localizable.basicDetailsButtonTitle, for: .normal)
        }
    }

    //MARK: - Properties
    private let viewModel: BasicDetailsViewModel

    // MARK: - Init
    public init(viewModel: BasicDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "BasicDetailsViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func backTapped(_ sender: Any) {
        viewModel.backTapped()
    }
}
