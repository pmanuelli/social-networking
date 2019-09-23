
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
        var registerErrorDescription: Driver<String>
        let loginUserButtonTouch: Observable<Void>
        var didRegisterUser: Observable<User>
    }
    
    let input = Input()
    private(set) lazy var output = createOutput()
        
    private let registerErrorDescriptionSubject = PublishSubject<String>()
    private let loginUserButtonTouchSubject = PublishSubject<Void>()
    private let didRegisterUserSubject = PublishSubject<User>()
    private let disposeBag = DisposeBag()
    
    private let registerUser: RegisterUser
    
    init(registerUser: RegisterUser) {
        self.registerUser = registerUser
    }
    
    private func createOutput() -> Output {
        
        return Output(registerUserButtonEnabled: createRegisterUserButtonEnabledDriver(),
                      registerErrorDescription: registerErrorDescriptionSubject.asDriver(onErrorJustReturn: ""),
                      loginUserButtonTouch: loginUserButtonTouchSubject,
                      didRegisterUser: didRegisterUserSubject)
    }
        
    private func createRegisterUserButtonEnabledDriver() -> Driver<Bool> {
        
        let fields = [input.username, input.password,
                      input.givenName, input.familyName]
        
        return Observable
            .combineLatest(fields) { return $0.allSatisfy { !$0.isEmpty } }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()
    }
    
    func registerUserButtonTouched() {
        
        clearErrorDescription()
                
        registerUser
            .execute(data: createRegistrationData())
            .subscribe(onSuccess: { [weak self] in self?.registerUserSucceeded($0) },
                       onError: { [weak self] in self?.registerUserFailed($0) })
            .disposed(by: disposeBag)
    }
    
    private func createRegistrationData() -> RegistrationData {
        
        return RegistrationData(username: input.username.value, password: input.password.value,
                                givenName: input.givenName.value, familyName: input.familyName.value)
    }
    
    private func registerUserSucceeded(_ user: User) {
        didRegisterUserSubject.onNext(user)
    }
    
    private func registerUserFailed(_ error: Error) {
        registerErrorDescriptionSubject.onNext(error.localizedDescription)
    }
    
    private func clearErrorDescription() {
        registerErrorDescriptionSubject.onNext("")
    }
    
    func loginUserButtonTouched() {
        loginUserButtonTouchSubject.onNext(Void())
    }
}
