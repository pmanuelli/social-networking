
import RxSwift

//sourcery: AutoMockable
protocol CreatePost {
    
    func execute(userId: UserId, text: String) -> Single<Post>
}

class CreatePostDefault: CreatePost {
    
    private let postService: PostService
    
    init(postService: PostService) {
        self.postService = postService
    }
    
    func execute(userId: UserId, text: String) -> Single<Post> {
        return postService.createPost(userId: userId, text: text)
    }
}
