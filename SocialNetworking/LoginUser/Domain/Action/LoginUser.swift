
import Foundation
import RxSwift

protocol LoginUser {
    
    func execute(data: RegistrationData) -> Single<User>
}

class LoginUserDefault: LoginUser {
    
    func execute(data: RegistrationData) -> Single<User> {
        abort()
    }
}
