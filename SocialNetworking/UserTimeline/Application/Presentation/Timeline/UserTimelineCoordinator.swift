
import UIKit
import RxSwift
import RxCocoa

class UserTimelineCoordinator {
    
    lazy var logoutButtonTouch: Driver<Void> = logoutButtonTouchSubject.asDriver()
    private let logoutButtonTouchSubject = PublishSubject<Void>()
    
    private let navigationController: UINavigationController
    private let userId: UUID
    
    private lazy var postRepository = InMemoryPostRepository()
    private lazy var languageService = LanguageServiceDefault()
    private lazy var postService = PostServiceDefault(postRepository: postRepository, languageService: languageService)
    private lazy var createPost = CreatePostDefault(postService: postService)
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, userId: UUID) {
        self.navigationController = navigationController
        self.userId = userId
    }
    
    func start() {
        
        goToUserTimeline()
    }
    
    private func goToUserTimeline() {
        
        let viewModel = UserTimelineViewModel()
        let viewController = UserTimelineViewController(viewModel: viewModel)
        
        observe(viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func observe(_ viewModel: UserTimelineViewModel) {
        
        viewModel.output.createPostButtonTouch
            .drive(onNext: { [weak self] _ in self?.goToCreatePost() })
            .disposed(by: disposeBag)
        
        viewModel.output.logoutButtonTouch
            .drive(logoutButtonTouchSubject)
            .disposed(by: disposeBag)
    }
    
    private func goToCreatePost() {
        
        let viewModel = CreatePostViewModel(userId: userId, createPost: createPost)
        let viewController = CreatePostViewController(viewModel: viewModel)
        
        observe(viewModel)
        
        navigationController.present(viewController, animated: true)
    }
        
    private func observe(_ viewModel: CreatePostViewModel) {
        
        viewModel.output.didCreatePost
            .subscribe { [weak self] _ in self?.dismissViewController() }
            .disposed(by: disposeBag)
    }
    
    private func dismissViewController() {
        navigationController.dismiss(animated: true)
    }
}
