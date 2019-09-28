
import RxSwift

//sourcery: AutoMockable
protocol PostService {
    
    func createPost(userId: UUID, text: String) -> Single<Post>
}

class PostServiceDefault: PostService {
    
    private let postRepository: PostRepository
    private let idGenerator: IdGenerator
    private let clock: Clock
    
    init(postRepository: PostRepository,
         idGenerator: IdGenerator = IdGeneratorDefault(),
         clock: Clock = ClockDefault()) {
        
        self.postRepository = postRepository
        self.idGenerator = idGenerator
        self.clock = clock
    }
    
    func createPost(userId: UUID, text: String) -> Single<Post> {
        
        let post = Post(id: idGenerator.next(), userId: userId, text: text, date: clock.now())
        
        return postRepository
            .add(post)
            .andThen(.just(post))
    }
}
