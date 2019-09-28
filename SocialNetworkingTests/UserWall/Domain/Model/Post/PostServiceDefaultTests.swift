
@testable import SocialNetworking

import XCTest
import SwiftyMocky
import RxBlocking

class PostServiceDefaultTests: XCTestCase {

    private let postId = UUID()
    private let userId = UUID()
    private let text = "Post text"
    private let date = Date(timeIntervalSince1970: 1569628800)
    
    private lazy var post = Post(id: postId, userId: userId, text: text, date: date)

    // Dependencies
    private let postRepository = PostRepositoryMock()
    private let idGenerator = IdGeneratorMock()
    private let clock = ClockMock()
    
    func testCreateAPost() {
        
        Given(postRepository, .add(.any, willReturn: .empty()))
        Given(idGenerator, .next(willReturn: postId))
        Given(clock, .now(willReturn: date))
        
        let postService = PostServiceDefault(postRepository: postRepository, idGenerator: idGenerator, clock: clock)
        
        let createdPost = try? postService.createPost(userId: userId, text: text).toBlocking().first()
        
        Verify(postRepository, .once, .add(.value(post)))
        XCTAssertEqual(createdPost, post)
    }
}
