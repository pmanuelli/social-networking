
import Foundation
import RxSwift
import RxCocoa
import RxRelay

class RegisterUserViewModel {
    
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let givenName = BehaviorRelay<String>(value: "")
    let familyName = BehaviorRelay<String>(value: "")
    
    var registerUserButtonEnabled: Driver<Bool>
    private var registerUserButtonEnabledRelay = BehaviorRelay<Bool>(value: false)
    
    private let disposeBag = DisposeBag()
    
    init() {
        
        registerUserButtonEnabled = registerUserButtonEnabledRelay.asDriver(onErrorJustReturn: false)
        
        observeNotEmptyFields()
    }
        
    private func observeNotEmptyFields() {
        
        let fields = [username, password, givenName, familyName]
        
        let notEmptyFields = Observable
            .combineLatest(fields) { return $0.allSatisfy { !$0.isEmpty } }
            .distinctUntilChanged()
        
        notEmptyFields.bind(to: registerUserButtonEnabledRelay)
            .disposed(by: disposeBag)
    }
}
