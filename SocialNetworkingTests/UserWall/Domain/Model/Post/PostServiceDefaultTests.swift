
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
    
    // Object Under Test
    private var postService: PostServiceDefault!
    
    private var createdPost: Post?
    
    override func setUp() {
        givenAPostRepository()
        givenAPostService()
    }
    
    func testCreateAPost() {
        
        givenAnIdGeneratorReturning(postId)
        givenAClockReturning(date)
        
        whenPostIsCreated(userId: userId, text: text)
        
        thenPostIsPersisted(post)
        thenCreatedPostIs(post)
    }
    
    // MARK: Given
    
    private func givenAPostService() {
        postService = PostServiceDefault(postRepository: postRepository, idGenerator: idGenerator, clock: clock)
    }
    
    private func givenAPostRepository() {
        Given(postRepository, .add(.any, willReturn: .empty()))
    }
    
    private func givenAnIdGeneratorReturning(_ id: UUID){
        Given(idGenerator, .next(willReturn: id))
    }
    
    private func givenAClockReturning(_ date: Date) {
        Given(clock, .now(willReturn: date))
    }
    
    // MARK: When
    
    private func whenPostIsCreated(userId: UUID, text: String) {
        createdPost = try? postService.createPost(userId: userId, text: text).toBlocking().first()
    }
    
    // MARK: Then
    
    private func thenPostIsPersisted(_ post: Post) {
        Verify(postRepository, .once, .add(.value(post)))
    }
    
    private func thenCreatedPostIs(_ post: Post) {
        XCTAssertEqual(createdPost, post)
    }
}
