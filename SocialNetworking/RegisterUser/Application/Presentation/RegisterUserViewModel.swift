
import Foundation
import RxSwift
import RxCocoa
import RxRelay

class RegisterUserViewModel {
    
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let givenName = BehaviorRelay<String>(value: "")
    let familyName = BehaviorRelay<String>(value: "")
    
    lazy var registerUserButtonEnabled: Driver<Bool> = createRegisterUserButtonEnabledDiver()
    
    private let registerUser: RegisterUser
    
    private let disposeBag = DisposeBag()
    
    init(registerUser: RegisterUser) {
        self.registerUser = registerUser
    }
        
    private func createRegisterUserButtonEnabledDiver() -> Driver<Bool> {
        
        let fields = [username, password, givenName, familyName]
        
        return Observable
            .combineLatest(fields) { return $0.allSatisfy { !$0.isEmpty } }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()
    }
    
    func registerUserButtonTouched() {
        
        registerUser.execute(username: username.value, password: password.value,
                             givenName: givenName.value, familyName: familyName.value)
    }
}
