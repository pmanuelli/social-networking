
import RxSwift

//sourcery: AutoMockable
protocol UserService {
    
    func registerUser(data: RegistrationData) -> Single<User>
}

class UserServiceDefault: UserService {
    
    func registerUser(data: RegistrationData) -> Single<User> {
        abort()
    }
}
