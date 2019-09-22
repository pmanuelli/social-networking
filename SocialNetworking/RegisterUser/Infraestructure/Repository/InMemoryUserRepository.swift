
import Foundation
import RxSwift

class InMemoryUserRepository: UserRepository {
    
    private var users: [User] = []
    
    func add(_ user: User) -> Completable {
        
        return Completable.create { subscribeBlock in
            
            self.users.append(user)
            
            subscribeBlock(.completed)
            
            return Disposables.create()
        }
    }
    
    func isUsernameTaken(_ username: String) -> Single<Bool> {
        
        Single.create { subscribeBlock in
            
            let isUsernameTaken = self.users.contains { $0.username == username }
            
            subscribeBlock(.success(isUsernameTaken))
            
            return Disposables.create()
        }
    }
}
