
import UIKit
import RxSwift
import RxCocoa

class UserTimelineCoordinator {
    
    var onFinish: (() -> Void)?
    
    private let navigationController: UINavigationController
    private let user: User
    
    private var viewModel: UserTimelineViewModel?
    private var createPostCoordinator: CreatePostCoordinator?
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        
        goToUserTimeline()
    }
    
    private func goToUserTimeline() {
        
        let viewModel = UserTimelineViewModel(user: user, getPosts: Infrastructure.getPosts)
        let viewController = UserTimelineViewController(viewModel: viewModel)
        
        observe(viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
        
        self.viewModel = viewModel
    }
    
    private func observe(_ viewModel: UserTimelineViewModel) {
        
        viewModel.output.createPostButtonTouch
            .drive(onNext: { [weak self] _ in self?.goToCreatePost() })
            .disposed(by: disposeBag)
        
        viewModel.output.logoutButtonTouch
            .drive(onNext: { [weak self] _ in self?.onFinish?() })
            .disposed(by: disposeBag)
    }
    
    private func goToCreatePost() {
        
        createPostCoordinator = CreatePostCoordinator(navigationController: navigationController, userId: user.id)
        createPostCoordinator?.onFinish = { [weak self] in self?.createPostCoordinatorFinished() }
        createPostCoordinator?.start()
    }
    
    private func createPostCoordinatorFinished() {
        viewModel?.viewDidAppear()
    }
}
