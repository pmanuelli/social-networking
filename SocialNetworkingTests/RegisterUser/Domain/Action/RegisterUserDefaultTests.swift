
@testable import SocialNetworking

import XCTest
import SwiftyMocky

class RegisterUserDefaultTests: XCTestCase {

    // Dependencies
    private let registrationData = RegistrationDataBuilder().build()
    private let userService = UserServiceMock()
    
    // Object under test
    private var action: RegisterUserDefault!
        
    func testRegistersNewUser() {
            
        givenARegisterUserAction()
                
        whenActionIsExecutedWith(registrationData)
        
        thenUserIsRegisteredWith(registrationData)
    }
    
    // MARK: Given

    private func givenARegisterUserAction() {
        
        givenAUserService()
        action = RegisterUserDefault(userService: userService)
    }
    
    private func givenAUserService() {
        Given(userService, .registerUser(data: .any, willReturn: .just(UserBuilder().build())))
    }
    
    // MARK: When
    
    private func whenActionIsExecutedWith(_ data: RegistrationData) {
        _ = action.execute(data: data)
    }
    
    // MARK: Then
    
    private func thenUserIsRegisteredWith(_ data: RegistrationData) {
        Verify(userService, .registerUser(data: .value(data)))
    }
}
