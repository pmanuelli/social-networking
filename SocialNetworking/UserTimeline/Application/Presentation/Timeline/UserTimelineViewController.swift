
import UIKit
import UIKitExtensions

class UserTimelineViewController: UIViewController {
    
    let viewModel: UserTimelineViewModel
    lazy var mainView = UserTimelineView.initFromNib()

    init(viewModel: UserTimelineViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(viewModel:) instead")
    }
    
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
