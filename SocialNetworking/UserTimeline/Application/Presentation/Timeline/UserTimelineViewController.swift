
import UIKit
import P2Views

class UserTimelineViewController: UIViewController {
    
    let viewModel: UserTimelineViewModel
    let mainView = UserTimelineView.loadNib()

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
