
import Foundation
import RxSwift

//sourcery: AutoMockable
protocol LoginUser {
    
    func execute(credentials: UserCredentials) -> Single<User>
}

class LoginUserDefault: LoginUser {
    
    func execute(credentials: UserCredentials) -> Single<User> {
        abort()
    }
}
