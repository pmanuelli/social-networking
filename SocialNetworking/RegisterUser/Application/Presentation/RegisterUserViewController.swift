
import UIKit
import UIKitExtensions

class RegisterUserViewController: UIViewController {
    
    lazy var mainView = RegisterUserView.initFromNib()
    
    let viewModel: RegisterUserViewModel

    init(viewModel: RegisterUserViewModel) {
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
