
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
    private let languageService = LanguageServiceMock()
    private let idGenerator = IdGeneratorMock()
    private let clock = ClockMock()
    
    // Object Under Test
    private var postService: PostServiceDefault!
    
    private var createdPost: Post?
    private var error: Error?
    
    override func setUp() {
        givenAPostRepository()
        givenAnIdGeneratorReturning(postId)
        givenAClockReturning(date)
        
        givenAPostService()
    }
    
    func testCreateAPost() {
        
        givenPostDoesNotContainInappropriateLanguage()
        
        whenPostIsCreated(userId: userId, text: text)
        
        thenPostIsPersisted(post)
        thenCreatedPostIs(post)
    }
    
    func testReturnAnErrorWhenCreatingPostWithInappropriateLanguage() {
        
        givenPostContainsInappropriateLanguage()
        
        whenPostIsCreated(userId: userId, text: text)
        
        thenPostIsNotPersisted()
        thenInappropriateLanguageErrorIsReturned()
    }
    
    // MARK: Given
    
    private func givenAPostService() {
        postService = PostServiceDefault(postRepository: postRepository,
                                         languageService: languageService,
                                         idGenerator: idGenerator,
                                         clock: clock)
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
    
    private func givenPostDoesNotContainInappropriateLanguage() {
        Given(languageService, .isInappropriate(.any, willReturn: false))
    }
    
    private func givenPostContainsInappropriateLanguage() {
        Given(languageService, .isInappropriate(.any, willReturn: true))
    }
    
    // MARK: When
    
    private func whenPostIsCreated(userId: UUID, text: String) {
        
        do {
            createdPost = try postService.createPost(userId: userId, text: text).toBlocking().first()
        } catch {
            self.error = error
        }
    }
    
    // MARK: Then
    
    private func thenPostIsPersisted(_ post: Post) {
        Verify(postRepository, .once, .add(.value(post)))
    }
    
    private func thenPostIsNotPersisted() {
        Verify(postRepository, .never, .add(.any))
    }
    
    private func thenCreatedPostIs(_ post: Post) {
        XCTAssertEqual(createdPost, post)
    }
    
    private func thenInappropriateLanguageErrorIsReturned() {
        XCTAssertTrue(error is InappropriateLanguageError)
    }
}
