
import RxSwift

//sourcery: AutoMockable
protocol GetPosts {
    
    func execute(userId: UUID) -> Single<[Post]>
}

class GetPostsDefault: GetPosts {
    
    private let postService: PostService
    
    init(postService: PostService) {
        self.postService = postService
    }
    
    func execute(userId: UUID) -> Single<[Post]> {
        return postService.posts(by: userId)
    }
}
