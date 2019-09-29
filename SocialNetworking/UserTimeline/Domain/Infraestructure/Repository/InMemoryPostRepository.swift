
import RxSwift

class InMemoryPostRepository: PostRepository {
    
    private var posts: [Post] = []
    
    func add(_ post: Post) -> Completable {
        
        Completable.create { subscribeBlock in
            
            self.posts.append(post)
            
            return Disposables.create()
        }
    }
}
