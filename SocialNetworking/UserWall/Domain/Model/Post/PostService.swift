
import RxSwift

//sourcery: AutoMockable
protocol PostService {
    
    func createPost(userId: UUID, text: String) -> Single<Post>
}

class PostServiceDefault: PostService {
    
    func createPost(userId: UUID, text: String) -> Single<Post> {
        abort()
    }
}
