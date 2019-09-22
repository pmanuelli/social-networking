
import UIKit

class LoginUserViewController: UIViewController {
    
    lazy var mainView = LoginUserView.initFromNib()

    private let viewModel: LoginUserViewModel

    init(viewModel: LoginUserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    private func bindViewModel() {

    }
}
