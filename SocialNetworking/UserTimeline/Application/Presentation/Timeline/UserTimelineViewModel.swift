
import RxSwift
import RxCocoa

class UserTimelineViewModel {
        
    struct Output {
        
        var createPostButtonTouch: Driver<Void>
    }
    
    private(set) lazy var output = createOutput()
    
    private let createPostButtonTouchSubject = PublishSubject<Void>()
    
    private func createOutput() -> Output {
        
        return Output(createPostButtonTouch: createPostButtonTouchSubject.asDriver())
    }
    
    func createPostButtonTouched() {
        createPostButtonTouchSubject.onNext()
    }
}
