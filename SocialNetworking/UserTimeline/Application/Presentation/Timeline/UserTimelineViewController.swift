
import UIKit
import UIKitExtensions
import RxSwift
import RxCocoa

class UserTimelineViewController: UIViewController {

    private let viewModel: UserTimelineViewModel
    private lazy var mainView = UserTimelineView.initFromNib()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: UserTimelineViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }

    required init?(coder: NSCoder) { return nil }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
    
    private func bindViewModel() {
    
        bindHeaderView()
        bindPostTableView()
        bindLogoutButton()
        bindCreatePostButton()
    }
    
    private func bindHeaderView() {
        
        mainView.topBar.viewModel = viewModel.output.topBarViewModel
    }
    
    private func bindPostTableView() {
        
        let items:
            (Observable<[PostCellViewModel]>) ->
            (@escaping (Int, PostCellViewModel, PostTableViewCell) -> Void)
            -> Disposable =
            
            mainView.postTableView.rx.items(cellIdentifier: PostTableViewCell.identifier,
                                            cellType: PostTableViewCell.self)
        
        viewModel.output.postViewModels
            .asObservable()
            .bind(to: items) { _, viewModel, cell in cell.viewModel = viewModel }
            .disposed(by: disposeBag)
    }

    private func bindLogoutButton() {
        
        mainView.topBar.logoutButton.addTarget(self, action: #selector(logoutButtonTouched), for: .touchUpInside)
    }

    @objc
    private func logoutButtonTouched() {
        
        mainView.topBar.logoutButton.applyTouchUpInsideAnimation() {
            self.viewModel.logoutButtonTouched()
        }
    }
    
    private func bindCreatePostButton() {
        
        mainView.createPostButton.addTarget(self, action: #selector(createPostButtonTouched), for: .touchUpInside)
    }
    
    @objc
    private func createPostButtonTouched() {
        
        mainView.createPostButtonContainer.applyTouchUpInsideAnimation() {
            self.viewModel.createPostButtonTouched()
        }
    }
}
