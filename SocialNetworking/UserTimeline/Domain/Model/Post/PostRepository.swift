
import RxSwift

//sourcery: AutoMockable
protocol PostRepository {
    
    func add(_ post: Post) -> Completable
}
