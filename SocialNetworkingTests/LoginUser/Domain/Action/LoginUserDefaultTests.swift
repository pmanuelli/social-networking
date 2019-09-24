@testable import SocialNetworking

import XCTest
import SwiftyMocky

class LoginUserDefaultTests: XCTestCase {

    // Dependencies
    private let userCredentials = UserCredentialsBuilder().build()
    private let userService = UserServiceMock()
    
    // Object under test
    private var action: LoginUserDefault!
    
    func testLogsInAUser() {
             
         givenALoginUserAction()
                 
         whenActionIsExecutedWith(userCredentials)
         
         thenUserIsLoggedInWith(userCredentials)
     }
    
    // MARK: Given

    private func givenALoginUserAction() {
        
        givenAUserService()
        action = LoginUserDefault(userService: userService)
    }
    
    private func givenAUserService() {
        Given(userService, .loginUser(credentials: .any, willReturn: .just(UserBuilder().build())))
    }
    
    // MARK: When
    
    private func whenActionIsExecutedWith(_ credentials: UserCredentials) {
        _ = action.execute(credentials: credentials)
    }
    
    // MARK: Then
    
    private func thenUserIsLoggedInWith(_ UserCredentials: UserCredentials) {
        Verify(userService, .loginUser(credentials: .value(UserCredentials)))
    }
}
