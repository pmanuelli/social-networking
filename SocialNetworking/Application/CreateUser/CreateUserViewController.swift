
import UIKit
import UIKitExtensions

class CreateUserViewController: UIViewController {
    
    lazy var mainView = CreateUserView.initFromNib()
    
    let viewModel: CreateUserViewModel

    init(viewModel: CreateUserViewModel) {
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
