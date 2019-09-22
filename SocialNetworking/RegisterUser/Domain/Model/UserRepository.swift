
import Foundation
import RxSwift

//sourcery: AutoMockable
protocol UserRepository {
    
    func add(_ user: User) -> Completable
}

class UserRepositoryDefault: UserRepository {
    
    func add(_ user: User) -> Completable {
        abort()
    }
}
