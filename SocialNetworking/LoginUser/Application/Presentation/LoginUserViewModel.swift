
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
        let registerUserButtonTouch: Observable<Void>
    }
    
    let input = Input()
    lazy var output = createOutput()
    
    private let registerUserButtonTouchSubject = PublishSubject<Void>()
    
    
    func registerUserButtonTouched() {
        registerUserButtonTouchSubject.onNext(Void())
    }
    
    private func createOutput() -> Output {
        return Output(loginUserButtonEnabled: createLoginUserButtonEnabledDriver(),
                      registerUserButtonTouch: registerUserButtonTouchSubject)
    }
    
    private func createLoginUserButtonEnabledDriver() -> Driver<Bool> {
        
        let fields = [input.username, input.password]
        
        return Observable
            .combineLatest(fields) { return $0.allSatisfy { !$0.isEmpty } }
            .asDriver(onErrorJustReturn: false)
            .distinctUntilChanged()
    }
}
