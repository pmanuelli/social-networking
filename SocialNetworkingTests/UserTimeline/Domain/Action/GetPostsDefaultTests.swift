
@testable import SocialNetworking

import XCTest
import SwiftyMocky
import RxBlocking

class GetPostsDefaultTests: XCTestCase {

    private let userId = UUID()
    private let posts = [PostBuilder().build()]
    
    // Dependencies
    private let postService = PostServiceMock()
    
    // Object to test
    private lazy var action = GetPostsDefault(postService: postService)
    
    private var returnedPosts: [Post]?
    
    func testReturnUserPosts() {
        
        givenAUserServiceReturning(posts, for: userId)
        
        whenActionIsExecutedForUserId(userId)
        
        thenReturnedPostsAre(posts)
    }
    
    // MARK: Given

    private func givenAUserServiceReturning(_ posts: [Post], for userId: UUID) {
        Given(postService, .posts(by: .value(userId), willReturn: .just(posts)))
    }
    
    // MARK: When
    
    private func whenActionIsExecutedForUserId(_ userId: UUID) {
        returnedPosts = try? action.execute(userId: userId).toBlocking().first()
    }
    
    // MARK: Then

    private func thenReturnedPostsAre(_ posts: [Post]) {
        XCTAssertEqual(returnedPosts, posts)
    }
}
