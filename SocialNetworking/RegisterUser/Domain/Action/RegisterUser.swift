
import RxSwift

//sourcery: AutoMockable
protocol RegisterUser {
    
    func execute(data: RegistrationData) -> Single<User>
}

class RegisterUserDefault: RegisterUser {
    
    func execute(data: RegistrationData) -> Single<User> {
        abort()
    }
}
