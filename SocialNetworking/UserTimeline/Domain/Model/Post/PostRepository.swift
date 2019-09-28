
import RxSwift

//sourcery: AutoMockable
protocol PostRepository {
    
    func add(_ post: Post) -> Completable
}

class PostRepositoryDefault: PostRepository {
    
    func  add(_ post: Post) -> Completable {
        abort()
    }
}

