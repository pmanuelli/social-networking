
@testable import SocialNetworking

import XCTest
import SwiftyMocky
import RxBlocking

class CreatePostDefaultTests: XCTestCase {
    
    private let postId = UUID()
    private let userId = UUID()
    private let text = "Hello, World!"
    private let date = Date(timeIntervalSince1970: 1569542400)
    
    private lazy var post = Post(id: postId, userId: userId, text: text, date: date)
    
    // Dependencies
    private let postService = PostServiceMock()
    
    // Object under test
    private var action: CreatePostDefault!
    
    private var createdPost: Post?
    private var error: Error?
    
    override func setUp() {
        
        givenAPostService(returning: post)
        givenACreatePostAction()
    }
    
    func testCreatesAPost() {
            
        whenActionIsExecutedWith(userId: userId, text: text)
        
        thenPostIsCreatedWith(userId: userId, text: text)
    }
    
    func testReturnsCreatedPost() {
        
        whenActionIsExecutedWith(userId: userId, text: text)
        
        thenCreatedPostIs(post)
    }
    
    func testReturnsAnErrorWhenCreatingAPostWithInappropiateLanguage() {
        
        givenAPostService(returning: InappropriateLanguageError())
        
        whenActionIsExecutedWith(userId: userId, text: text)
        
        thenInappropriateLanguageErrorIsReturned()
    }
    
    // MARK: Given
    
    private func givenACreatePostAction() {
        action = CreatePostDefault(postService: postService)
    }
    
    private func givenAPostService(returning post: Post) {
        Given(postService, .createPost(userId: .any, text: .any, willReturn: .just(post)))
    }
    
    private func givenAPostService(returning error: InappropriateLanguageError) {
        Given(postService, .createPost(userId: .any, text: .any, willReturn: .error(error)))
    }
    
    // MARK: When
    
    private func whenActionIsExecutedWith(userId: UUID, text: String) {
        
        do { createdPost = try action.execute(userId: userId, text: text).toBlocking().first() }
        catch { self.error = error }
    }

    // MARK: Then
    
    private func thenPostIsCreatedWith(userId: UUID, text: String) {
        Verify(postService, .createPost(userId: .value(userId), text: .value(text)))
    }
        
    private func thenCreatedPostIs(_ expectedPost: Post) {
        XCTAssertEqual(createdPost, expectedPost)
    }
    
    private func thenInappropriateLanguageErrorIsReturned() {
        XCTAssertTrue(error is InappropriateLanguageError)
    }
}
