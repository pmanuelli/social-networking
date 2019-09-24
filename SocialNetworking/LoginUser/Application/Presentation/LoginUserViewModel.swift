
import Foundation
import RxSwift
import RxCocoa

class LoginUserViewModel {

    struct Input {
        
        let username = BehaviorRelay<String>(value: "")
        let password = BehaviorRelay<String>(value: "")
    }
    
    struct Output {
        
        let loginUserButtonEnabled: Driver<Bool>
        let loginErrorDescription: Driver<String>
        let registerUserButtonTouch: Observable<Void>
        var didLoginUser: Observable<User>
    }
    
    let input = Input()
    lazy var output = createOutput()
    
    private let loginErrorDescriptionSubject = PublishSubject<String>()
    private let registerUserButtonTouchSubject = PublishSubject<Void>()
    private let didLoginUserSubject = PublishSubject<User>()

    private let disposeBag = DisposeBag()
    
    private let loginUser: LoginUser
    
    init(loginUser: LoginUser) {
        self.loginUser = loginUser
    }
    
    private func createOutput() -> Output {
        
        return Output(loginUserButtonEnabled: createLoginUserButtonEnabledDriver(),
                      loginErrorDescription: loginErrorDescriptionSubject.asDriver(onErrorJustReturn: ""),
                      registerUserButtonTouch: registerUserButtonTouchSubject,
                      didLoginUser: didLoginUserSubject)
    }
    
    private func createLoginUserButtonEnabledDriver() -> Driver<Bool> {
        
        let fields = [input.username, input.password]
        
        return Observable
            .combineLatest(fields) { return $0.allSatisfy { !$0.isEmpty } }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()
    }
    
    func loginUserButtonTouched() {
        
        let credentials = UserCredentials(username: input.username.value,
                                          password: input.password.value)
        
        clearErrorDescription()
        
        loginUser.execute(credentials: credentials)
            .subscribe(onSuccess: { [weak self] in self?.loginUserSucceeded($0) },
                       onError: { [weak self] in self?.loginUserFailed($0) })
            .disposed(by: disposeBag)
    }
    
    private func loginUserSucceeded(_ user: User) {
        didLoginUserSubject.onNext(user)
    }
    
    private func loginUserFailed(_ error: Error) {
        loginErrorDescriptionSubject.onNext(error.localizedDescription)
    }
    
    private func clearErrorDescription() {
        loginErrorDescriptionSubject.onNext("")
    }
    
    func registerUserButtonTouched() {
        registerUserButtonTouchSubject.onNext(Void())
    }
}
