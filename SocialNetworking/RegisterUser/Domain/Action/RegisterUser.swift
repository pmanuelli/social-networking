
import RxSwift

protocol RegisterUser {
    
    func execute() -> Single<User>
}

class RegisterUserDefault: RegisterUser {
    
    func execute() -> Single<User> {
        abort()
    }
}
