
import RxSwift
import RxCocoa

let viewModels: [PostCellViewModel] = [
    PostCellViewModel(post: Post(id: UUID(), userId: UUID(), text: "Post text 1", date: Date())),
    PostCellViewModel(post: Post(id: UUID(), userId: UUID(), text: "Post text 2 asdsdhbs sadb asd asdasdsdbhsbdhbsd sdbshdbahs ashd asdas ashd ashd bhsdb hsdb sd asjdhb ajs", date: Date())),
    PostCellViewModel(post: Post(id: UUID(), userId: UUID(), text: "Post text 3", date: Date()))
]

class UserTimelineViewModel {
        
    struct Output {
        
        var createPostButtonTouch: Driver<Void>
        var logoutButtonTouch: Driver<Void>
        let postViewModels: Driver<[PostCellViewModel]> = Driver.just(viewModels)
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
