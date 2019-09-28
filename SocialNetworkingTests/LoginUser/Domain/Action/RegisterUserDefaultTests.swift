
@testable import SocialNetworking

import XCTest
import SwiftyMocky
import RxBlocking

class RegisterUserDefaultTests: XCTestCase {

    private let registrationData = RegistrationDataBuilder().build()
    private let user = UserBuilder().build()
    
    // Dependencies
    private let userService = UserServiceMock()
    
    // Object under test
    private var action: RegisterUserDefault!
    
    private var registeredUser: User?
        
    override func setUp() {
     
        givenAUserService(returning: user)
        givenARegisterUserAction()
    }
    
    func testRegistersNewUser() {
                
        whenActionIsExecutedWith(registrationData)
        
        thenUserIsRegisteredWith(registrationData)
    }
    
    func testReturnsRegisteredUser() {
        
        whenActionIsExecutedWith(registrationData)
        
        thenRegisteredUserIs(user)
    }
    
    // MARK: Given

    private func givenAUserService(returning user: User) {
         Given(userService, .registerUser(data: .any, willReturn: .just(user)))
    }
    
    private func givenARegisterUserAction() {
        action = RegisterUserDefault(userService: userService)
    }
    
    // MARK: When
    
    private func whenActionIsExecutedWith(_ data: RegistrationData) {
        registeredUser = try? action.execute(data: data).toBlocking().first()
    }
    
    // MARK: Then
    
    private func thenUserIsRegisteredWith(_ data: RegistrationData) {
        Verify(userService, .registerUser(data: .value(data)))
    }
    
    private func thenRegisteredUserIs(_ expectedUser: User) {
        XCTAssertEqual(registeredUser, expectedUser)
    }
}
