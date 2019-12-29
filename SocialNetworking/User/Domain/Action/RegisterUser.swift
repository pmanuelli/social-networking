
import RxSwift

//sourcery: AutoMockable
protocol RegisterUser {
    
    func execute(data: RegistrationData) -> Single<User>
}

class RegisterUserDefault: RegisterUser {
    
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func execute(data: RegistrationData) -> Single<User> {
        return userService.registerUser(data: data)
    }
}
