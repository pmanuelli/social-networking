
import RxSwift

class InMemoryPostRepository: PostRepository {
    
    private var posts: [Post] = []
    
    func add(_ post: Post) -> Completable {
        
        Completable.create { subscribeBlock in
            
            self.posts.append(post)
            
            subscribeBlock(.completed)
            
            return Disposables.create()
        }
    }
}
