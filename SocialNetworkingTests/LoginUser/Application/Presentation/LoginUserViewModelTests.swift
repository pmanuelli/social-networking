
@testable import SocialNetworking

import XCTest
import RxTest
import RxSwift
import SwiftyMocky

class LoginUserViewModelTests: XCTestCase {

    // RxTest elements
    private let scheduler = TestScheduler(initialClock: 0)
    private var loginUserButtonEnabledObserver: TestableObserver<Bool>!
    private var loginErrorDescriptionObserver: TestableObserver<String>!
    private var registerUserButtonTouchObserver: TestableObserver<Void>!
    private let disposeBag = DisposeBag()
    
    // Dependencies
    private var loginUser = LoginUserMock()
    
    // Object under test
    private var viewModel: LoginUserViewModel!
    
    func testInitiallyDisablesRegisterUserButton() {
         
         whenViewModelIsCreated()
         
         thenLoginUserButtonIsDisabled()
     }
     
     func testEnablesRegisterUserButtonWhenFieldsAreNotEmpty() {
         
         givenAViewModel()
         
         whenFieldsAreSetTo(username: "username", password: "password")
         
         thenLoginUserButtonIsEnabled()
     }
     
     func testDisablesRegisterUserButtonWhenAFieldIsEmpty() {
         
         givenAViewModel()
         givenAViewModelWithCompletedFields()
         
         whenUsernameChangesTo("")
         
         thenLoginUserButtonIsDisabled()
     }
    
    func testInformsWhenRegisterUserButtonIsTouched() {
        
        givenAViewModel()
        
        whenRegisterUserButtonIsTouched()
        
        thenRegisterUserButtonTouchIsEmmited()
    }
    
    func testLoginAUser() {
        
        let credentials = UserCredentialsBuilder().build()
        
        givenALoginUserAction()
        givenAViewModelWithFieldsSetTo(username: credentials.username,
                                       password: credentials.password)
        
        whenLoginUserButtonIsTouched()
        
        thenLoginUserActionIsExecutedWith(credentials)
    }
    
    func testShowsErrorDescriptionWhenLoginAUser() {
        
        let error = NSError(domain: "", code: 0,
                            localizedDescription: "Error Description")
        
        givenALoginUserAction(returning: error)
        givenAViewModelWithCompletedFields()
        
        whenLoginUserButtonIsTouched()
        
        thenErrorDescriptionShownIs(error.localizedDescription)
    }
    
    // MARK: Given
    
    private func givenALoginUserAction(returning user: User = UserBuilder().build()) {
        Given(loginUser, .execute(credentials: .any, willReturn: .just(user)))
    }
    
    private func givenALoginUserAction(returning error: Error) {
        Given(loginUser, .execute(credentials: .any, willReturn: .error(error)))
    }
    
    private func givenAViewModel() {
        
        viewModel = LoginUserViewModel(loginUser: loginUser)
        
        subscribeToLoginButtonEnabled()
        subscribeToLoginErrorDescription()
        subscribeToRegisterUserButtonTouch()
    }
    
    private func subscribeToLoginButtonEnabled() {
        
        loginUserButtonEnabledObserver = scheduler.createObserver(Bool.self)
        
        viewModel.output.loginUserButtonEnabled
            .drive(loginUserButtonEnabledObserver)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToLoginErrorDescription() {
        
        loginErrorDescriptionObserver = scheduler.createObserver(String.self)
        
        viewModel.output.loginErrorDescription
            .drive(loginErrorDescriptionObserver)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToRegisterUserButtonTouch() {
        
        registerUserButtonTouchObserver = scheduler.createObserver(Void.self)
        
        viewModel.output.registerUserButtonTouch
            .subscribe(registerUserButtonTouchObserver)
            .disposed(by: disposeBag)
    }
    
    private func givenAViewModelWithFieldsSetTo(username: String, password: String) {
        
        givenAViewModel()
        viewModel.input.username.accept(username)
        viewModel.input.password.accept(password)
    }
    
    private func givenAViewModelWithCompletedFields() {
        
        givenAViewModelWithFieldsSetTo(username: "u", password: "p")
    }

    // MARK: When
    
    private func whenViewModelIsCreated() {
        givenAViewModel()
    }
    
    private func whenFieldsAreSetTo(username: String, password: String) {
        viewModel.input.username.accept(username)
        viewModel.input.password.accept(password)
    }
    
    private func whenUsernameChangesTo(_ text: String) {
        viewModel.input.username.accept(text)
    }
    
    private func whenLoginUserButtonIsTouched() {
        viewModel.loginUserButtonTouched()
    }
    
    private func whenRegisterUserButtonIsTouched() {
        viewModel.registerUserButtonTouched()
    }
    
    // MARK: Then
    
    private func thenLoginUserButtonIsEnabled() {
        
        let lastValue = loginUserButtonEnabledObserver.events.last?.value.element
        XCTAssertEqual(lastValue, true)
    }
    
    private func thenLoginUserButtonIsDisabled() {
        
        let lastValue = loginUserButtonEnabledObserver.events.last?.value.element
        XCTAssertEqual(lastValue, false)
    }
    
    private func thenLoginUserActionIsExecutedWith(_ credentials: UserCredentials) {
        Verify(loginUser, .once, .execute(credentials: .value(credentials)))
    }
    
    private func thenRegisterUserButtonTouchIsEmmited() {
        XCTAssertEqual(registerUserButtonTouchObserver.events.count, 1)
    }
        
    private func thenErrorDescriptionShownIs(_ description: String) {
        
        let observedElements = loginErrorDescriptionObserver.events.map { $0.value.element }
        XCTAssertEqual(observedElements, ["", description])
    }
}
