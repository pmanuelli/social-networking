
import Foundation
import RxSwift

//sourcery: AutoMockable
protocol LoginUser {
    
    func execute(credentials: UserCredentials) -> Single<User>
}

class LoginUserDefault: LoginUser {
    
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func execute(credentials: UserCredentials) -> Single<User> {
        userService.loginUser(credentials: credentials)
    }
}
