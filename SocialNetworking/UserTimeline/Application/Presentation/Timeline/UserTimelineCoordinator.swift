
import UIKit

class UserTimelineCoordinator {
    
    private let navigationController: UINavigationController
    private let userId: UUID
    
    private lazy var postRepository = InMemoryPostRepository()
    private lazy var languageService = LanguageServiceDefault()
    private lazy var postService = PostServiceDefault(postRepository: postRepository, languageService: languageService)
    private lazy var createPost = CreatePostDefault(postService: postService)
    
    init(navigationController: UINavigationController, userId: UUID) {
        self.navigationController = navigationController
        self.userId = userId
    }
    
    func start() {
        
        let viewModel = UserTimelineViewModel(userId: userId, createPost: createPost)
        let viewController = UserTimelineViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
