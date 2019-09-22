
import Foundation
import RxSwift

//sourcery: AutoMockable
protocol UserRepository {
    
    func add(_ user: User) -> Completable
    func isUsernameTaken(_ username: String) -> Single<Bool>
}

class UserRepositoryDefault: UserRepository {
    
    func add(_ user: User) -> Completable {
        abort()
    }
    
    func isUsernameTaken(_ username: String) -> Single<Bool> {
        abort()
    }
}
