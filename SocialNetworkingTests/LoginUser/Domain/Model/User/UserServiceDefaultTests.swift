
@testable import SocialNetworking

import XCTest
import RxSwift
import RxBlocking
import SwiftyMocky

class UserServiceDefaultTests: XCTestCase {
        
    private let id = UserId(raw: UUID())
    private let username = "username"
    private let password = "password"
    private let givenName = "givenName"
    private let familyName = "familyName"
    
    private lazy var data = RegistrationData(username: username, password: password, givenName: givenName, familyName: familyName)
    private lazy var user = User(id: id, username: username, password: password, givenName: givenName, familyName: familyName)
    private lazy var userCredentials = UserCredentials(username: username, password: password)
    
    // Dependencies
    private let userRepository = UserRepositoryMock()
    private let idGenerator = UserIdGeneratorMock()

    // Object under test
    private var service: UserServiceDefault!
    
    private var returnedUser: User?
    private var error: Error?
        
    override func setUp() {

        givenAnIdGenerator(returning: id)
        givenAUserService()
    }
    
    func testRegisterAUser() {
        
        givenAnAvailableUsername(data.username)
        
        whenUserIsRegisteredWith(data)

        thenRegisteredUserIs(user)
    }
    
    func testReturnRegisteredUser() {
        
        givenAnAvailableUsername(data.username)
        
        whenUserIsRegisteredWith(data)

        thenReturnedUserIs(user)
    }
    
    func testReturnAnErrorWhenUsernameIsInUse() {
        
        givenAnAlreadyInUseUsername(data.username)

        whenUserIsRegisteredWith(data)

        thenUserIsNotPersisted()
        thenUsernameAlreadyInUseErrorIsReturned()
    }
    
    func testLoginAUser() {
        
        givenAUser(user, forCredentials: userCredentials)
        
        whenUserIsLoggedInWithCredentials(userCredentials)
        
        thenUserIsRequestedForCredentials(userCredentials)
        thenReturnedUserIs(user)
    }
    
    func testReturnAnErrorWhenCredentialsAreInvalid() {
        
        givenAUser(nil, forCredentials: userCredentials)
        
        whenUserIsLoggedInWithCredentials(userCredentials)
        
        thenInvalidLoginCredentialsErrorIsReturned()
    }
    
    // MARK: Given
     
    private func givenAnIdGenerator(returning id: UserId) {
        Given(idGenerator, .next(willReturn: id))
    }
    
    private func givenAnAvailableUsername(_ username: String) {
        Given(userRepository, .isUsernameTaken(.value(username), willReturn: .just(false)))
    }
    
    private func givenAnAlreadyInUseUsername(_ username: String) {
        Given(userRepository, .isUsernameTaken(.value(username), willReturn: .just(true)))
    }

    private func givenAUserService() {
                
        givenAUserRepository()
        service = UserServiceDefault(userRepository: userRepository, idGenerator: idGenerator)
    }
    
    private func givenAUserRepository() {
        Given(userRepository, .add(.any, willReturn: .empty()))
    }
    
    private func givenAUser(_ user: User?, forCredentials credentials: UserCredentials) {
        Given(userRepository, .user(for: .value(credentials), willReturn: .just(user)))
    }
    
    // MARK: When
    
    private func whenUserIsRegisteredWith(_ data: RegistrationData) {
        
        do { returnedUser = try service.registerUser(data: data).toBlocking().first() }
        catch { self.error = error }
    }
    
    private func whenUserIsLoggedInWithCredentials(_ credentials: UserCredentials) {
        
        do { returnedUser = try service.loginUser(credentials: credentials).toBlocking().first() }
        catch { self.error = error }
    }
    
    // MARK: Then
    
    private func thenRegisteredUserIs(_ user: User) {
        Verify(userRepository, .once, .add(.value(user)))
    }
    
    private func thenReturnedUserIs(_ expectedUser: User) {
        XCTAssertEqual(user, expectedUser)
    }
    
    private func thenUserIsNotPersisted() {
        Verify(userRepository, .never, .add(.value(user)))
    }
    
    private func thenUsernameAlreadyInUseErrorIsReturned() {
        XCTAssertTrue(error is UsernameAlreadyInUseError)
    }
    
    private func thenUserIsRequestedForCredentials(_ credentials: UserCredentials) {
        Verify(userRepository, .once, .user(for: .value(credentials)))
    }
    
    private func thenInvalidLoginCredentialsErrorIsReturned() {
        XCTAssertTrue(error is InvalidLoginCredentialsError)
    }
}
