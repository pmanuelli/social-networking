
@testable import SocialNetworking

import XCTest
import SwiftyMocky
import RxBlocking

class GetAllUsersDefaultTests: XCTestCase {
    
    private let users = [UserBuilder().build()]
    
    // Dependencies
    private let userService = UserServiceMock()
    
    // Object under test
    private lazy var action = GetAllUsersDefault(userService: userService)
    
    private var returnedUsers: [User]?
    
    func testReturnAllUsers() {
                
        givenAUserServiceReturning(users)
        
        whenActionIsExecuted()
        
        thenReturnedUsersAre(users)
    }
    
    // MARK: Given
    
    private func givenAUserServiceReturning(_ users: [User]) {
        Given(userService, .getAllUsers(willReturn: .just(users)))
    }
    
    // MARK: When
    
    private func whenActionIsExecuted() {
        returnedUsers = try? action.execute().toBlocking().first()
    }
    
    // MARK: Then
    
    private func thenReturnedUsersAre(_ users: [User]) {
        XCTAssertEqual(returnedUsers, users)
    }
}
