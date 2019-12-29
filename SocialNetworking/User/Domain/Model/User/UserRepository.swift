
import Foundation
import RxSwift

//sourcery: AutoMockable
protocol UserRepository {
    
    func isUsernameTaken(_ username: String) -> Single<Bool>

    func add(_ user: User) -> Completable    
    func user(for credentials: UserCredentials) -> Single<User?>
}
