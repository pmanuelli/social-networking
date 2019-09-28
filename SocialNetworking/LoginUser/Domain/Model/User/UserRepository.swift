
import Foundation
import RxSwift

//sourcery: AutoMockable
protocol UserRepository {
    
    func add(_ user: User) -> Completable
    
    func isUsernameTaken(_ username: String) -> Single<Bool>
    func user(for credentials: UserCredentials) -> Single<User?>
}
