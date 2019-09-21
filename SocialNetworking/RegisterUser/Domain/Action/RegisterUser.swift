
import RxSwift

//sourcery: AutoMockable
protocol RegisterUser {
    
    func execute(username: String, password: String, givenName: String, familyName: String) -> Single<User>
}

class RegisterUserDefault: RegisterUser {
    
    func execute(username: String, password: String, givenName: String, familyName: String) -> Single<User> {
        abort()
    }
}
