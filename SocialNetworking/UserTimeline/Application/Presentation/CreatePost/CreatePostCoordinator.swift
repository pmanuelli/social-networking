
import UIKit
import RxSwift
import RxCocoa

class CreatePostCoordinator {
    
    var onFinish: (() -> Void)?
    
    private let navigationController: UINavigationController
    private let userId: UUID
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, userId: UUID) {
        self.navigationController = navigationController
        self.userId = userId
    }
    
    func start() {
        
        startCreatePost()
    }
    
    func stop() {
        
        stopCreatePost()
    }
    
    private func startCreatePost() {
        
        let viewModel = CreatePostViewModel(userId: userId, createPost: Infrastructure.createPost)
        let viewController = CreatePostViewController(viewModel: viewModel)
        
        observe(viewModel)
        
        navigationController.present(viewController, animated: true)
    }
        
    private func observe(_ viewModel: CreatePostViewModel) {
        
        viewModel.output.didCreatePost
            .subscribe { [weak self] _ in self?.postCreated() }
            .disposed(by: disposeBag)
    }
    
    private func postCreated() {
        onFinish?()
    }
    
    private func stopCreatePost() {
        navigationController.dismiss(animated: true)
    }
}
