
@testable import SocialNetworking

import XCTest
import RxTest
import RxSwift
import SwiftyMocky

class RegisterUserViewModelTests: XCTestCase {

    // RxTest elements
    private let scheduler = TestScheduler(initialClock: 0)
    private var registerUserButtonEnabledObserver: TestableObserver<Bool>!
    private var registerErrorDescriptionObserver: TestableObserver<String>!
    private var loginUserButtonTouchObserver: TestableObserver<Void>!
    private var didRegisterUserObserver: TestableObserver<User>!
    private let disposeBag = DisposeBag()
    
    // Dependencies
    private let registerUser = RegisterUserMock()
    
    // Object under test
    private var viewModel: RegisterUserViewModel!
            
    func testInitiallyDisablesRegisterUserButton() {
        
        whenViewModelIsCreated()
        
        thenRegisterUserButtonIsDisabled()
    }
    
    func testEnablesRegisterUserButtonWhenFieldsAreNotEmpty() {
        
        givenAViewModel()
        
        whenFieldsAreSetTo(username: "username", password: "password",
                           givenName: "givenName", familyName: "familyName")
        
        thenRegisterUserButtonIsEnabled()
    }
    
    func testDisablesRegisterUserButtonWhenAFieldIsEmpty() {
        
        givenAViewModel()
        givenAViewModelWithCompletedFields()
        
        whenUsernameChangesTo("")
        
        thenRegisterUserButtonIsDisabled()
    }
    
    func testRegistersNewUser() {
        
        let data = RegistrationDataBuilder().build()
        
        givenARegisterUserAction()
        givenAViewModel()
        givenFieldsSetTo(username: data.username, password: data.password,
                         givenName: data.givenName, familyName: data.familyName)
        
        whenRegisterUserButtonIsTouched()
        
        thenRegisterUserActionIsExecutedWith(data)
    }
    
    func testEmitsRegisteredUser() {
        
        let user = UserBuilder().build()
        
        givenARegisterUserAction(returning: user)
        givenAViewModelWithCompletedFields()
        
        whenRegisterUserButtonIsTouched()
        
        thenUserIsEmmited(user)
    }
    
    func testShowsErrorDescriptionWhenRegisteringAUser() {
        
        let error = NSError(domain: "", code: 0,
                            localizedDescription: "Error Description")
        
        givenARegisterUserAction(returning: error)
        givenAViewModelWithCompletedFields()
        
        whenRegisterUserButtonIsTouched()
        
        thenErrorDescriptionShownIs(error.localizedDescription)
    }
    
    func testInformsWhenLoginUserButtonIsTouched() {
        
        givenAViewModel()
        
        whenLoginUserButtonIsTouched()
        
        thenLoginUserButtonTouchIsEmmited()
    }
    
    // MARK: Given
        
    private func givenARegisterUserAction(returning user: User = UserBuilder().build()) {
        Given(registerUser, .execute(data: .any, willReturn: Single.just(user)))
    }
    
    private func givenARegisterUserAction(returning error: Error) {
        Given(registerUser, .execute(data: .any, willReturn: Single.error(error)))
    }
    
    private func givenAViewModel() {
        
        viewModel = RegisterUserViewModel(registerUser: registerUser)
        
        subscribeToRegisterUserButtonEnabled()
        subscribeToRegisterErrorDescription()
        subscribeToLoginButtonTouched()
        subscribeToDidRegisterUser()
    }
    
    private func subscribeToRegisterUserButtonEnabled() {
        
        registerUserButtonEnabledObserver = scheduler.createObserver(Bool.self)
        
        viewModel.output.registerUserButtonEnabled
            .drive(registerUserButtonEnabledObserver)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToRegisterErrorDescription() {
        
        registerErrorDescriptionObserver = scheduler.createObserver(String.self)
        
        viewModel.output.registerErrorDescription
            .drive(registerErrorDescriptionObserver)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToLoginButtonTouched() {
        
        loginUserButtonTouchObserver = scheduler.createObserver(Void.self)
        
        viewModel.output.loginUserButtonTouch
            .subscribe(loginUserButtonTouchObserver)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToDidRegisterUser() {
        
        didRegisterUserObserver = scheduler.createObserver(User.self)
        
        viewModel.output.didRegisterUser
            .subscribe(didRegisterUserObserver)
            .disposed(by: disposeBag)
    }
    
    private func givenAViewModelWithCompletedFields() {
        
        givenAViewModel()
        givenFieldsSetTo(username: "u", password: "p", givenName: "g", familyName: "f")
    }
    
    private func givenFieldsSetTo(username: String, password: String,
                                  givenName: String, familyName: String) {
        
        viewModel.input.username.accept(username)
        viewModel.input.password.accept(password)
        viewModel.input.givenName.accept(givenName)
        viewModel.input.familyName.accept(familyName)
    }
    
    // MARK: When
        
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
    
    private func whenLoginUserButtonIsTouched() {
        viewModel.loginUserButtonTouched()
    }
    
    // MARK: Then
    
    private func thenRegisterUserButtonIsDisabled() {
        
        let lastValue = registerUserButtonEnabledObserver.events.last?.value.element
        XCTAssertEqual(lastValue, false)
    }
    
    private func thenRegisterUserButtonIsEnabled() {
        
        let lastValue = registerUserButtonEnabledObserver.events.last?.value.element
        XCTAssertEqual(lastValue, true)
    }
    
    private func thenRegisterUserActionIsExecutedWith(_ registrationData: RegistrationData) {
        Verify(registerUser, .once, .execute(data: .value(registrationData)))
    }
    
    private func thenUserIsEmmited(_ user: User) {
        
        let observedElements = didRegisterUserObserver.events.map { $0.value.element }
        XCTAssertEqual(observedElements, [user])
    }
    
    private func thenErrorDescriptionShownIs(_ description: String) {
        
        let observedElements = registerErrorDescriptionObserver.events.map { $0.value.element }
        XCTAssertEqual(observedElements, ["", description])
    }
    
    private func thenLoginUserButtonTouchIsEmmited() {
        XCTAssertEqual(loginUserButtonTouchObserver.events.count, 1)
    }
}
