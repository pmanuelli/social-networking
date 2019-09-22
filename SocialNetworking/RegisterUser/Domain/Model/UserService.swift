
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
        
        let user = createUser(from: data)
        
        let addUserAsObservable = userRepository.add(user)
            .asObservable()
            .map { _ in user }
        
        let userAsObservable = Observable.of(user)
        
        return Observable.concat(addUserAsObservable, userAsObservable).asSingle()
    }
    
    private func createUser(from data: RegistrationData) -> User {
        
        return User(id: idGenerator.next(),
                    username: data.username,
                    givenName: data.givenName,
                    familyName: data.familyName)
    }
}
