
import RxSwift
import RxCocoa

class UserTimelineViewModel {
        
    struct Output {
        
        let topBarViewModel: UserTimelineTopBarViewModel
        let postViewModels: Driver<[PostCellViewModel]>
        let createPostButtonTouch: Driver<Void>
        let logoutButtonTouch: Driver<Void>
    }
    
    private(set) lazy var output = createOutput()
    
    private let postViewModelsSubject = BehaviorSubject<[PostCellViewModel]>(value: [])
    private let createPostButtonTouchSubject = PublishSubject<Void>()
    private let logoutButtonTouchSubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()

    private let user: User
    private let getPosts: GetPosts
        
    init(user: User, getPosts: GetPosts) {
        self.user = user
        self.getPosts = getPosts
    }
    
    private func createOutput() -> Output {
        
        return Output(topBarViewModel: UserTimelineTopBarViewModel(user: user),
                      postViewModels: postViewModelsSubject.asDriver(onErrorJustReturn: []),
                      createPostButtonTouch: createPostButtonTouchSubject.asDriver(),
                      logoutButtonTouch: logoutButtonTouchSubject.asDriver())
    }
        
    func viewDidAppear() {
        
        getPosts.execute(userId: user.id)
            .subscribe(onSuccess: { [weak self] in self?.getPostsSuccess($0) },
                       onError: { [weak self] in self?.getPostsError($0) })
            .disposed(by: disposeBag)
    }
    
    private func getPostsSuccess(_ posts: [Post]) {
        
        let viewModels = posts.map { PostCellViewModel(post: $0, author: user) }
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
