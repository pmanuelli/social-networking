
@testable import SocialNetworking

import XCTest
import SwiftyMocky
import RxBlocking

class LoginUserDefaultTests: XCTestCase {

    private let userCredentials = UserCredentialsBuilder().build()
    private var user = UserBuilder().build()
        
    // Dependencies
    private let userService = UserServiceMock()
    
    // Object under test
    private var action: LoginUserDefault!
    
    private var loggedUser: User?
    
    override func setUp() {
        
        givenAUserService(returning: user)
        givenALoginUserAction()
    }
    
    func testLoginAUser() {
                
        whenActionIsExecutedWith(userCredentials)
        
        thenUserIsLoggedInWith(userCredentials)
    }
    
    func testReturnsLoggedInUser() {
        
        whenActionIsExecutedWith(userCredentials)
        
        thenLoggedUserIs(user)
    }
    
    // MARK: Given
    
    private func givenAUserService(returning user: User) {
        Given(userService, .loginUser(credentials: .any, willReturn: .just(user)))
    }
    
    private func givenALoginUserAction() {
        action = LoginUserDefault(userService: userService)
    }
    
    // MARK: When
    
    private func whenActionIsExecutedWith(_ credentials: UserCredentials) {
        loggedUser = try? action.execute(credentials: credentials).toBlocking().first()
    }
    
    // MARK: Then
    
    private func thenUserIsLoggedInWith(_ UserCredentials: UserCredentials) {
        Verify(userService, .loginUser(credentials: .value(UserCredentials)))
    }
    
    private func thenLoggedUserIs(_ expectedUser: User) {
        XCTAssertEqual(loggedUser, expectedUser)
    }
}
