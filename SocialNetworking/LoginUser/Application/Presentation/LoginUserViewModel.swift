
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
    }
    
    let input = Input()
    lazy var output = createOutput()
    
    private let loginErrorDescriptionSubject = PublishSubject<String>()
    private let registerUserButtonTouchSubject = PublishSubject<Void>()
    
    private let loginUser: LoginUser
    
    init(loginUser: LoginUser) {
        self.loginUser = loginUser
    }
    
    func loginUserButtonTouched() {
        
        let credentials = UserCredentials(username: input.username.value,
                                          password: input.password.value)
        
        loginUser.execute(credentials: credentials)
    }
    
    private func createOutput() -> Output {
        return Output(loginUserButtonEnabled: createLoginUserButtonEnabledDriver(),
                      loginErrorDescription: loginErrorDescriptionSubject.asDriver(onErrorJustReturn: ""),
                      registerUserButtonTouch: registerUserButtonTouchSubject)
    }
    
    private func createLoginUserButtonEnabledDriver() -> Driver<Bool> {
        
        let fields = [input.username, input.password]
        
        return Observable
            .combineLatest(fields) { return $0.allSatisfy { !$0.isEmpty } }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()
    }
    
    func registerUserButtonTouched() {
        registerUserButtonTouchSubject.onNext(Void())
    }
}
