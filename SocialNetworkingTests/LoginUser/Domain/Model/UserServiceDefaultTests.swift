
@testable import SocialNetworking

import XCTest
import RxSwift
import RxBlocking
import RxTest
import SwiftyMocky

class UserServiceDefaultTests: XCTestCase {
    
    // RxTest
    private let testScheduler = TestScheduler(initialClock: 0)
    private var addUserObservable: TestableObservable<Never>!
    private var userObserver: TestableObserver<User>!
    private var loginUserObserver: TestableObserver<User>!
    private let disposeBag = DisposeBag()
    
    
    private let id = UUID()
    private let username = "username"
    private let password = "password"
    private let givenName = "givenName"
    private let familyName = "familyName"
    
    private lazy var data = RegistrationData(username: username, password: password, givenName: givenName, familyName: familyName)
    private lazy var user = User(id: id, username: username, password: password, givenName: givenName, familyName: familyName)
    private lazy var userCredentials = UserCredentials(username: username, password: password)
    
    // Dependencies
    private let userRepository = UserRepositoryMock()
    private let idGenerator = IdGeneratorMock()

    // Object under test
    private var service: UserServiceDefault!
        
    override func setUp() {

        givenAnIdGenerator(returning: id)
        givenAUserService()
    }
    
    func testRegistersAUser() {
        
        givenUsernameIsAlreadyInUse(false)
        
        whenUserIsRegisteredWith(data)

        thenUserIsPersisted(user)
        thenUserIsReturned(user)
    }
    
    func testReturnsAnErrorWhenUsernameIsInUse() {
        
        givenUsernameIsAlreadyInUse(true)

        whenUserIsRegisteredWith(data)

        thenUserIsNotPersisted()
        thenUsernameAlreadyInUseErrorIsReturned()
    }
    
    func testLoginAUser() {
        
        givenAUserForCredentials(user)
        
        whenUserIsLoggedInWithCredentials(userCredentials)
        
        thenUserIsRequestedForCredentials(userCredentials)
        thenUserIsReturned(user)
    }
    
    func testReturnsAnErrorWhenCredentialsAreInvalid() {
        
        givenAUserForCredentials(nil)
        
        whenUserIsLoggedInWithCredentials(userCredentials)
        
        thenInvalidLoginCredentialsErrorIsReturned()
    }
    
    // MARK: Given
     
    private func givenAnIdGenerator(returning id: UUID) {
        Given(idGenerator, .next(willReturn: id))
    }
    
    private func givenUsernameIsAlreadyInUse(_ inUse: Bool) {
        Given(userRepository, .isUsernameTaken(.any, willReturn: .just(inUse)))
    }
    
    private func givenAUserService() {
                
        givenAUserRepository()
        service = UserServiceDefault(userRepository: userRepository, idGenerator: idGenerator)
    }
    
    private func givenAUserRepository() {
        
        addUserObservable = testScheduler.createHotObservable([.completed(0)])
        Given(userRepository, .add(.any, willReturn: addUserObservable.asCompletable()))
    }
    
    private func givenAUserForCredentials(_ user: User?) {
        Given(userRepository, .user(for: .any, willReturn: .just(user)))
    }
    
    // MARK: When
    
    private func whenUserIsRegisteredWith(_ data: RegistrationData) {
        
        userObserver = testScheduler.createObserver(User.self)
        
        service.registerUser(data: data)
            .asObservable()
            .subscribe(userObserver)
            .disposed(by: disposeBag)
        
        testScheduler.start()
    }
    
    private func whenUserIsLoggedInWithCredentials(_ credentials: UserCredentials) {
        
        userObserver = testScheduler.createObserver(User.self)
        
        service.loginUser(credentials: credentials)
            .asObservable()
            .subscribe(userObserver)
            .disposed(by: disposeBag)
    }
    
    // MARK: Then
    
    private func thenUserIsPersisted(_ user: User) {
        Verify(userRepository, .once, .add(.value(user)))
        XCTAssertEqual(addUserObservable.subscriptions.count, 1)
    }
    
    private func thenUserIsReturned(_ user: User) {
        assertEventsContainUser(user, events: userObserver.events)
    }
    
    private func thenUserIsNotPersisted() {
        XCTAssertEqual(addUserObservable.subscriptions.count, 0)
    }
    
    private func thenUsernameAlreadyInUseErrorIsReturned() {
        assertEventsContainUsernameAlreadyInUseError(events: userObserver.events)
    }
    
    private func assertEventsContainUser(_ user: User, events: [Recorded<Event<User>>]) {
        XCTAssertEqual(events.count, 2)
        XCTAssertEqual(events[0].value.element, user)
        XCTAssertTrue(events[1].value.isCompleted)
    }
    
    private func assertEventsContainUsernameAlreadyInUseError(events: [Recorded<Event<User>>]) {
        XCTAssertEqual(events.count, 1)
        XCTAssertTrue(events[0].value.error is UsernameAlreadyInUseError)
    }
    
    private func thenUserIsRequestedForCredentials(_ credentials: UserCredentials) {
        Verify(userRepository, .once, .user(for: .value(credentials)))
    }
    
    private func thenInvalidLoginCredentialsErrorIsReturned() {
        assertEventsContainInvalidLoginCredentialsError(events: userObserver.events)
    }
    
    private func assertEventsContainInvalidLoginCredentialsError(events: [Recorded<Event<User>>]) {
        XCTAssertEqual(events.count, 1)
        XCTAssertTrue(events[0].value.error is InvalidLoginCredentialsError)
    }
}