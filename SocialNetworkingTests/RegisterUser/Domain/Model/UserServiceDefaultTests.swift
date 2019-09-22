
@testable import SocialNetworking

import XCTest
import RxSwift
import RxBlocking
import SwiftyMocky

class UserServiceDefaultTests: XCTestCase {
    
    private let id = UUID()
    private let username = "username"
    private let password = "password"
    private let givenName = "givenName"
    private let familyName = "familyName"
    
    private lazy var data = RegistrationData(username: username, password: password, givenName: givenName, familyName: familyName)
    private lazy var user = User(id: id, username: username, givenName: givenName, familyName: familyName)
    
    // Dependencies
    private let userRepository = UserRepositoryMock()
    private let idGenerator = IdGeneratorMock()

    // Object under test
    private var service: UserServiceDefault!
    
    private var registeredUser: User?
    
    func testRegistersAUser() {
        
        givenAnIdGenerator(returning: id)
        givenAUserService()
        
        whenUserIsRegisteredWith(data)
        
        thenPersistedUserIs(user)
        thenRegisteredUserIs(user)
    }
    
    // MARK: Given
     
    private func givenAnIdGenerator(returning id: UUID) {
        Given(idGenerator, .next(willReturn: id))
    }
    
    private func givenAUserService() {
        Given(userRepository, .add(.any, willReturn: .empty()))
        
        service = UserServiceDefault(userRepository: userRepository, idGenerator: idGenerator)
    }
        
    // MARK: When
    
    private func whenUserIsRegisteredWith(_ data: RegistrationData) {
        registeredUser = try? service.registerUser(data: data).toBlocking().first()
    }
    
    // MARK: Then
    
    private func thenPersistedUserIs(_ user: User) {
        Verify(userRepository, .once, .add(.value(user)))
    }
    
    private func thenRegisteredUserIs(_ user: User) {
         XCTAssertEqual(registeredUser, user)
    }
}
