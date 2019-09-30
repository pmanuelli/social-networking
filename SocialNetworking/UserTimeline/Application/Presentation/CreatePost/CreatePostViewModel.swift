
import RxSwift
import RxRelay
import RxCocoa

class CreatePostViewModel {
        
    struct Output {
        
        var publishErrorDescription: Driver<String>
        var didCreatePost: Observable<Post>
    }
    
    private(set) lazy var output = createOutput()

    private let publishErrorDescriptionSubject = PublishSubject<String>()
    private let didCreatePostSubject = PublishSubject<Post>()
    private let disposeBag = DisposeBag()

    private let userId: UUID
    private let createPost: CreatePost
    
    init(userId: UUID, createPost: CreatePost) {
        self.userId = userId
        self.createPost = createPost
    }
    
    private func createOutput() -> Output {
        
        return Output(publishErrorDescription: publishErrorDescriptionSubject.asDriver(onErrorJustReturn: ""),
                      didCreatePost: didCreatePostSubject)
    }
    
    func publishButtonTouched(postText: String) {
        
        clearErrorDescription()
        
        createPost.execute(userId: userId, text: postText)
            .subscribe(onSuccess: { [weak self] in self?.createPostSucceeded($0) },
                       onError: { [weak self] in self?.createPostError($0) })
            .disposed(by: disposeBag)
    }
    
    private func createPostSucceeded(_ post: Post) {
        didCreatePostSubject.onNext(post)
    }
    
    private func createPostError(_ error: Error) {
        publishErrorDescriptionSubject.onNext(error.localizedDescription)
    }
    
    private func clearErrorDescription() {
        publishErrorDescriptionSubject.onNext("")
    }
}
