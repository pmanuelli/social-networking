
@testable import SocialNetworking

import XCTest
import RxSwift
import RxBlocking

class InMemoryUserRepositoryTests: XCTestCase {

    private let waltDisney = UserBuilder().withUsername("walt_disney").build()
    private let vaultDweller = UserBuilder().withUsername("vault_dweller").build()
    
    private let repository = InMemoryUserRepository()
    
    func testInformsWhenUsernameIsAlreadyTaken() {

        givenARepositoryWithUser(waltDisney)
        
        thenUsernameIsTaken(waltDisney.username)
        thenUsernameIsNotTaken(vaultDweller.username)
    }
    
    private func thenUsernameIsTaken(_ username: String) {
        thenUsername(username, isTaken: true)
    }
    
    private func thenUsernameIsNotTaken(_ username: String) {
        thenUsername(username, isTaken: false)
    }
    
    private func thenUsername(_ username: String, isTaken: Bool) {
        
        let isUsernameTaken = try? repository.isUsernameTaken(username).toBlocking().first()
        
        XCTAssertEqual(isUsernameTaken, isTaken)
    }
    
    private func givenARepositoryWithUser(_ user: User) {
        _ = repository.add(user).toBlocking().materialize()
    }
}
