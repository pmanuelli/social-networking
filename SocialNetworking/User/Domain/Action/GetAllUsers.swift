
import RxSwift

//sourcery: AutoMockable
protocol GetAllUsers {
    
    func execute() -> Single<[User]>
}

class GetAllUsersDefault: GetAllUsers {
    
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func execute() -> Single<[User]> {
        return userService.getAllUsers()
    }
}
