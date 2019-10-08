
@testable import SocialNetworking

import XCTest
import RxSwift
import RxBlocking

class InMemoryPostRepositoryTest: XCTestCase {

    private let user1Id = UUID()
    private let user2Id = UUID()
    private lazy var user1Post1 = PostBuilder().withUserId(user1Id).build()
    private lazy var user2Post1 = PostBuilder().withUserId(user2Id).build()
    private lazy var user1Post2 = PostBuilder().withUserId(user1Id).build()
    
    private let repository = InMemoryPostRepository()
    
    private var returnedPosts: [Post]?
    
    private let disposeBag = DisposeBag()
    
    func testReturnPostsByAUser() {
        
        givenARepositoryWithPosts(user1Post1, user2Post1, user1Post2)
        
        whenPostsAreRequestedForUserId(user1Id)

        thenReturnedPostsAre(user1Post1, user1Post2)
    }
    
    // MARK: Given
    
    private func givenARepositoryWithPosts(_ posts: Post...) {
        
        for post in posts {
            
            repository.add(post)
                .subscribe()
                .disposed(by: disposeBag)
        }
    }
    
    // MARK: When
    
    private func whenPostsAreRequestedForUserId(_ userId: UUID) {
        returnedPosts = try? repository.posts(by: userId).toBlocking().first()
    }
    
    // MARK: Then
    
    private func thenReturnedPostsAre(_ posts: Post...) {
        XCTAssertEqual(returnedPosts, posts)
    }
}
