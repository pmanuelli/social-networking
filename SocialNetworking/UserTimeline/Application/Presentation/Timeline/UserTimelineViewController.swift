
import UIKit
import UIKitExtensions

class UserTimelineViewController: UIViewController {
    
    private let viewModel: UserTimelineViewModel
    private lazy var mainView = UserTimelineView.initFromNib()
    
    init(viewModel: UserTimelineViewModel) {
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

        bindPublishButton()
    }
        
    private func bindPublishButton() {
                
        mainView.publishButton.addTarget(self, action: #selector(publishButtonTouched), for: .touchUpInside)
    }
        
    @objc
    private func publishButtonTouched() {
        viewModel.publishButtonTouched(postText: mainView.postTextView.text)
    }
}
