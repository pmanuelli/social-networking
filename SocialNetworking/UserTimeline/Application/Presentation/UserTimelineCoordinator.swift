
import UIKit
import RxSwift
import RxCocoa

class UserTimelineCoordinator {
    
    var onFinish: (() -> Void)?
    
    private let rootNavigationController: UINavigationController
    private let navigationController = UINavigationController()
    private let user: User
    
    private var viewModel: UserTimelineViewModel?
    private var createPostCoordinator: CreatePostCoordinator?
    
    private let transitioningDelegate = FlipTransitioningDelegate()

    private let disposeBag = DisposeBag()
        
    init(navigationController: UINavigationController, user: User) {
        self.rootNavigationController = navigationController
        self.user = user
    }
    
    func start() {
        
        startTimeline()
    }
    
    func stop() {
        
        stopTimeline()
    }
    
    private func startTimeline() {
        
        let viewModel = UserTimelineViewModel(user: user, getPosts: Infrastructure.getPosts)
        let viewController = UserTimelineViewController(viewModel: viewModel)
        
        observe(viewModel)
        
        navigationController.viewControllers = [viewController]
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.transitioningDelegate = transitioningDelegate
        
        rootNavigationController.present(navigationController, animated: true)
        
        self.viewModel = viewModel
    }
    
    private func observe(_ viewModel: UserTimelineViewModel) {
        
        viewModel.output.createPostButtonTouch
            .drive(onNext: { [weak self] _ in self?.startCreatePost() })
            .disposed(by: disposeBag)
        
        viewModel.output.logoutButtonTouch
            .drive(onNext: { [weak self] _ in self?.logoutButtonTouched() })
            .disposed(by: disposeBag)
    }
        
    private func startCreatePost() {
        
        createPostCoordinator = CreatePostCoordinator(navigationController: navigationController, userId: user.id)
        createPostCoordinator?.onFinish = { [weak self] in self?.stopCreatePost() }
        createPostCoordinator?.start()
    }
    
    private func stopCreatePost() {
        
        viewModel?.viewDidAppear()
        createPostCoordinator?.stop()
    }
    
    private func logoutButtonTouched() {
        onFinish?()
    }
    
    private func stopTimeline() {
        rootNavigationController.dismiss(animated: true)
    }
}
