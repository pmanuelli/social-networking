
@testable import SocialNetworking

import XCTest
import RxTest
import RxSwift
import SwiftyMocky

class RegisterUserViewModelTests: XCTestCase {

    // RxTest elements
    private var scheduler: TestScheduler!
    private var registerUserButtonEnabledObserver: TestableObserver<Bool>!
    private var didRegisterUserObserver: TestableObserver<User>!
    private let disposeBag = DisposeBag()
    
    // Dependencies
    private let registerUser = RegisterUserMock()
    
    // Object under test
    private var viewModel: RegisterUserViewModel!
    
    override func setUp() {
        
        scheduler = TestScheduler(initialClock: 0)
        registerUserButtonEnabledObserver = scheduler.createObserver(Bool.self)
        didRegisterUserObserver = scheduler.createObserver(User.self)
    }
    
    func testInitiallyDisablesRegisterUserButton() {
        
        whenViewModelIsCreated()
        
        thenRegisterUserButtonIsDisabled()
    }
    
    func testEnablesRegisterUserButtonWhenFieldsAreNotEmpty() {
        
        givenAViewModel()
        
        whenFieldsAreSetTo(username: "tool", password: "FearInocolum$1",
                           givenName: "Fear", familyName: "Inoculum")
        
        thenRegisterUserButtonIsEnabled()
    }
    
    func testDisablesRegisterUserButtonWhenAFieldIsEmpty() {
        
        givenAViewModel()
        givenFieldsSetTo(username: "tool", password: "FearInocolum$1",
                         givenName: "Fear", familyName: "Inoculum")
        
        whenUsernameChangesTo("")
        
        thenRegisterUserButtonIsDisabled()
    }
    
    func testRegistersNewUser() {
        
        let user = UserBuilder().build()
        
        givenARegisterUserAction(returning: user)
        givenAViewModel()
        givenFieldsSetTo(username: "tool", password: "FearInocolum$1",
                         givenName: "Fear", familyName: "Inoculum")
        
        whenRegisterUserButtonIsTouched()
        
        thenRegisterUserActionIsExecutedWith(username: "tool", password: "FearInocolum$1",
                                             givenName: "Fear", familyName: "Inoculum")
        
        thenEmittedUserIs(user)
    }
        
    private func givenARegisterUserAction(returning user: User) {
                
        Given(registerUser, .execute(username: .any, password: .any,
                                     givenName: .any, familyName: .any,
                                     willReturn: Single.just(user)))
    }
    private func givenAViewModel() {
        
        viewModel = RegisterUserViewModel(registerUser: registerUser)
        
        viewModel.output.registerUserButtonEnabled
            .drive(registerUserButtonEnabledObserver)
            .disposed(by: disposeBag)
        
        viewModel.output.didRegisterUser
            .subscribe(didRegisterUserObserver)
            .disposed(by: disposeBag)
    }
    
    private func givenFieldsSetTo(username: String, password: String,
                                  givenName: String, familyName: String) {
        
        viewModel.input.username.accept(username)
        viewModel.input.password.accept(password)
        viewModel.input.givenName.accept(givenName)
        viewModel.input.familyName.accept(familyName)
    }
        
    private func whenViewModelIsCreated() {
        givenAViewModel()
    }
    
    private func whenFieldsAreSetTo(username: String, password: String,
                                    givenName: String, familyName: String) {
        
        givenFieldsSetTo(username: username, password: password,
                         givenName: givenName, familyName: familyName)
    }
    
    private func whenUsernameChangesTo(_ text: String) {
        viewModel.input.username.accept(text)
    }
    
    private func whenRegisterUserButtonIsTouched() {
        viewModel.registerUserButtonTouched()
    }
    
    private func thenRegisterUserButtonIsDisabled() {
        
        let lastValue = registerUserButtonEnabledObserver.events.last?.value.element
        XCTAssertEqual(lastValue, false)
    }
    
    private func thenRegisterUserButtonIsEnabled() {
        
        let lastValue = registerUserButtonEnabledObserver.events.last?.value.element
        XCTAssertEqual(lastValue, true)
    }
    
    private func thenRegisterUserActionIsExecutedWith(username: String, password: String,
                                                      givenName: String, familyName: String) {
        
        Verify(registerUser, .once, .execute(username: .value(username), password: .value(password),
                                             givenName: .value(givenName), familyName: .value(familyName)))
    }
    
    private func thenEmittedUserIs(_ user: User) {
        
        let observedElements = didRegisterUserObserver.events.map { $0.value.element }
        XCTAssertEqual(observedElements, [user])
    }
}
