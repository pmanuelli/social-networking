
import RxSwift

//sourcery: AutoMockable
protocol UserService {
    
    func registerUser(data: RegistrationData) -> Single<User>
}

class UserServiceDefault: UserService {
    
    private let userRepository: UserRepository
    private let idGenerator: IdGenerator
    
    private let disposeBag = DisposeBag()
    
    init(userRepository: UserRepository, idGenerator: IdGenerator = IdGeneratorDefault()) {
        self.userRepository = userRepository
        self.idGenerator = idGenerator
    }
    
    func registerUser(data: RegistrationData) -> Single<User> {
        
        return validateUsernameTaken(data.username)
            .andThen(createAndSaveUser(data: data))
    }
    
    private func validateUsernameTaken(_ username: String) -> Completable {
        
        return userRepository
            .isUsernameTaken(username)
            .flatMapCompletable { if $0 { throw UsernameAlreadyInUseError() } else { return .empty() } }
    }
        
    private func createAndSaveUser(data: RegistrationData) -> Single<User> {
        
        let user = createUser(from: data)
        
        return userRepository
            .add(user)
            .andThen(.just(user))
    }
        
    private func createUser(from data: RegistrationData) -> User {
        
        return User(id: idGenerator.next(),
                    username: data.username,
                    givenName: data.givenName,
                    familyName: data.familyName)
    }
}
