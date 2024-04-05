import UIKit

final class AdditionalDetailsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Localizable.additionalDetailsTitle
            titleLabel.font = UIFont.fontWith(format: .title)
            titleLabel.textColor = Color.text
        }
    }

    //MARK: - Properties
    private let viewModel: AdditionalDetailsViewModel

    // MARK: - Init
    public init(viewModel: AdditionalDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "AdditionalDetailsViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
