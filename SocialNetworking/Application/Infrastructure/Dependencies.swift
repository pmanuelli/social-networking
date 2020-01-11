
import Foundation

class Dependencies {
    
    static private let clock = ClockDefault()

    static private let userIdGenerator = UserIdGeneratorDefault()
    static private let postIdGenerator = PostIdGeneratorDefault()

    static private let languageService = LanguageServiceDefault()
    
    static private let userRepository = InMemoryUserRepository()
    static private let postRepository = InMemoryPostRepository()
    
    static let userService = UserServiceDefault(userRepository: userRepository,
                                                idGenerator: userIdGenerator)

    static let postService = PostServiceDefault(postRepository: postRepository,
                                                languageService: languageService,
                                                idGenerator: postIdGenerator,
                                                clock: clock)
    
    static let loginUser = LoginUserDefault(userService: userService)
    static let registerUser = RegisterUserDefault(userService: userService)
    static let createPost = CreatePostDefault(postService: postService)
    static let getPosts = GetPostsDefault(postService: postService)
}
