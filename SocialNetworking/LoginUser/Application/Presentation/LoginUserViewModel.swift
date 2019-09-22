
import Foundation
import RxSwift

class LoginUserViewModel {

    struct Output {
        
        let registerUserButtonTouch: Observable<Void>
    }
    
    lazy var output = createOutput()
    
    private let registerUserButtonTouchSubject = PublishSubject<Void>()
    
    func registerUserButtonTouched() {
        registerUserButtonTouchSubject.onNext(Void())
    }
    
    private func createOutput() -> Output {
        return Output(registerUserButtonTouch: registerUserButtonTouchSubject)
    }
}
