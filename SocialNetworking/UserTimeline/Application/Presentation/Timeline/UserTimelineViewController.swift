
import UIKit
import UIKitExtensions
import RxSwift
import RxCocoa

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
    
        bindCreatePostButton()
        bindLogoutButton()
    }
    
    private func bindCreatePostButton() {
        
        mainView.createPostButton.addTarget(self, action: #selector(createPostButtonTouched), for: .touchUpInside)
    }
    
    private func bindLogoutButton() {
        
        mainView.logoutButton.addTarget(self, action: #selector(logoutButtonTouched), for: .touchUpInside)
    }
    
    @objc
    private func createPostButtonTouched() {
        
        mainView.createPostButtonContainer.applyTouchUpInsideAnimation() {
            self.viewModel.createPostButtonTouched()
        }
    }
    
    @objc
    private func logoutButtonTouched() {
        
        mainView.logoutButton.applyTouchUpInsideAnimation() {
            self.viewModel.logoutButtonTouched()
        }
    }
}
