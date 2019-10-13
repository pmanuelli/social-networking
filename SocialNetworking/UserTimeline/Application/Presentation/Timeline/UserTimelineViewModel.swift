
import RxSwift
import RxCocoa

class UserTimelineViewModel {
        
    struct Output {
        
        let postViewModels: Driver<[PostCellViewModel]>
        let createPostButtonTouch: Driver<Void>
        let logoutButtonTouch: Driver<Void>
    }
    
    private(set) lazy var output = createOutput()
    
    private let postViewModelsSubject = BehaviorSubject<[PostCellViewModel]>(value: [])
    private let createPostButtonTouchSubject = PublishSubject<Void>()
    private let logoutButtonTouchSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()

    private let userId: UUID
    private let getPosts: GetPosts
        
    init(userId: UUID, getPosts: GetPosts) {
        self.userId = userId
        self.getPosts = getPosts
    }
    
    private func createOutput() -> Output {
        
        return Output(postViewModels: postViewModelsSubject.asDriver(onErrorJustReturn: []),
                      createPostButtonTouch: createPostButtonTouchSubject.asDriver(),
                      logoutButtonTouch: logoutButtonTouchSubject.asDriver())
    }
    
    func viewDidAppear() {
        
        getPosts.execute(userId: userId)
            .subscribe(onSuccess: { [weak self] in self?.getPostsSuccess($0) },
                       onError: { [weak self] in self?.getPostsError($0) })
            .disposed(by: disposeBag)
    }
    
    private func getPostsSuccess(_ posts: [Post]) {
        
        let viewModels = posts.map { PostCellViewModel(post: $0) }
        postViewModelsSubject.onNext(viewModels)
    }
    
    private func getPostsError(_ error: Error) {
        
    }
    
    func createPostButtonTouched() {
        createPostButtonTouchSubject.onNext()
    }
    
    func logoutButtonTouched() {
        logoutButtonTouchSubject.onNext()
    }
}
