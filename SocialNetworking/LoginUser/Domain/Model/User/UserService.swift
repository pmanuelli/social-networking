
import RxSwift

//sourcery: AutoMockable
protocol UserService {
    
    func registerUser(data: RegistrationData) -> Single<User>
    func loginUser(credentials: UserCredentials) -> Single<User>
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
            .andThen(registerNewUser(data: data))
    }
    
    private func validateUsernameTaken(_ username: String) -> Completable {
        
        return userRepository
            .isUsernameTaken(username)
            .flatMapCompletable { if $0 { throw UsernameAlreadyInUseError(username: username) } else { return .empty() } }
    }
            
    private func registerNewUser(data: RegistrationData) -> Single<User> {
        
        Single.deferred {
            
            let user = self.createUser(from: data)
            
            return self.userRepository
                .add(user)
                .andThen(.just(user))
        }
    }
        
    private func createUser(from data: RegistrationData) -> User {
        
        return User(id: idGenerator.next(),
                    username: data.username,
                    password: data.password,
                    givenName: data.givenName,
                    familyName: data.familyName)
    }
    
    func loginUser(credentials: UserCredentials) -> Single<User> {
        
        return userRepository.user(for: credentials).map { userOrNil in
            
            guard let user = userOrNil else { throw InvalidLoginCredentialsError(username: credentials.username )}
            
            return user
        }
    }
}
