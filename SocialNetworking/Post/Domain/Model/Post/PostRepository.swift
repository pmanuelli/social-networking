
import RxSwift

//sourcery: AutoMockable
protocol PostRepository {
    
    func add(_ post: Post) -> Completable
    func posts(by userId: UserId) -> Single<[Post]>
}
