
import RxSwift
import RxCocoa

class UserTimelineViewModel {
        
    struct Output {
        
        var createPostButtonTouch: Driver<Void>
        var logoutButtonTouch: Driver<Void>
    }
    
    private(set) lazy var output = createOutput()
    
    private let createPostButtonTouchSubject = PublishSubject<Void>()
    private let logoutButtonTouchSubject = PublishSubject<Void>()
    
    private func createOutput() -> Output {
        
        return Output(createPostButtonTouch: createPostButtonTouchSubject.asDriver(),
                      logoutButtonTouch: logoutButtonTouchSubject.asDriver())
    }
    
    func createPostButtonTouched() {
        createPostButtonTouchSubject.onNext()
    }
    
    func logoutButtonTouched() {
        logoutButtonTouchSubject.onNext()
    }
}
