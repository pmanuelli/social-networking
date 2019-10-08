
import RxSwift

class InMemoryPostRepository: PostRepository {
    
    private var posts: [Post] = []
    
    func add(_ post: Post) -> Completable {
        
        Completable.deferred {
            
            self.posts.append(post)
            return .empty()
        }
    }
    
    func posts(by userId: UUID) -> Single<[Post]> {
        
        Single.deferred {
            
            let userPosts = self.posts.filter { $0.userId == userId }
            return .just(userPosts)
        }
    }
}
