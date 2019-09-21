
import Foundation
import RxSwift
import RxCocoa
import RxRelay

class RegisterUserViewModel {
    
    struct Input {
        
        let username = BehaviorRelay<String>(value: "")
        let password = BehaviorRelay<String>(value: "")
        let givenName = BehaviorRelay<String>(value: "")
        let familyName = BehaviorRelay<String>(value: "")
    }
    
    struct Output {
        
        var registerUserButtonEnabled: Driver<Bool>
        var didRegisterUser: Observable<User>
    }
    
    let input = Input()
    private(set) lazy var output = createOutput()
    
    private let registerUser: RegisterUser
    
    private let didRegisterUserSubject = PublishSubject<User>()
    private let disposeBag = DisposeBag()
    
    init(registerUser: RegisterUser) {
        self.registerUser = registerUser
    }
    
    private func createOutput() -> Output {
        return Output(registerUserButtonEnabled: createRegisterUserButtonEnabledDriver(),
                      didRegisterUser: createDidRegisterUser())
    }
        
    private func createRegisterUserButtonEnabledDriver() -> Driver<Bool> {
        
        let fields = [input.username, input.password,
                      input.givenName, input.familyName]
        
        return Observable
            .combineLatest(fields) { return $0.allSatisfy { !$0.isEmpty } }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()
    }
    
    private func createDidRegisterUser() -> Observable<User> {
        return didRegisterUserSubject.asObserver()
    }
    
    func registerUserButtonTouched() {
        
        let username = input.username.value
        let password = input.password.value
        let givenName = input.givenName.value
        let familyName = input.familyName.value
        
        let execution = registerUser.execute(username: username, password: password,
                                             givenName: givenName, familyName: familyName)
        
        execution
            .subscribe(onSuccess: { [weak self] in self?.registerUserSucceeded($0) },
                       onError: { [weak self] in self?.registerUserFailed($0) })
            .disposed(by: disposeBag)
    }
    
    private func registerUserSucceeded(_ user: User) {
        didRegisterUserSubject.onNext(user)
    }
    
    private func registerUserFailed(_ error: Error) {
        
    }
}
