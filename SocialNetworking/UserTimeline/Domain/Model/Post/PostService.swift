
import RxSwift

//sourcery: AutoMockable
protocol PostService {
    
    func createPost(userId: UserId, text: String) -> Single<Post>
    func posts(by userId: UserId) -> Single<[Post]>
}

class PostServiceDefault: PostService {
    
    private let postRepository: PostRepository
    private let languageService: LanguageService
    private let idGenerator: IdGenerator
    private let clock: Clock
    
    init(postRepository: PostRepository,
         languageService: LanguageService,
         idGenerator: IdGenerator = IdGeneratorDefault(),
         clock: Clock = ClockDefault()) {
        
        self.postRepository = postRepository
        self.languageService = languageService
        self.idGenerator = idGenerator
        self.clock = clock
    }
    
    func createPost(userId: UserId, text: String) -> Single<Post> {
        guard doesNotContainInappropriateLanguage(text) else {
            return .error(InappropriateLanguageError())
        }
        
        let post = createNewPost(userId: userId, text: text)
        
        return postRepository
            .add(post)
            .andThen(.just(post))
    }
    
    private func doesNotContainInappropriateLanguage(_ text: String) -> Bool {
        return !languageService.isInappropriate(text)
    }
    
    private func createNewPost(userId: UserId, text: String) -> Post {
        return Post(id: idGenerator.next(), userId: userId, text: text, date: clock.now())
    }
    
    func posts(by userId: UserId) -> Single<[Post]> {
        return postRepository.posts(by: userId)
            .map { self.sortPostsInReverseChronologicalOrder($0) }
    }
    
    private func sortPostsInReverseChronologicalOrder(_ posts: [Post]) -> [Post] {
        return posts.sorted { $0.date > $1.date }
    }
}
