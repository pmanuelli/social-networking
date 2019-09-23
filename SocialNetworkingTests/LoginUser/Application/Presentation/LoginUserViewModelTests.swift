
@testable import SocialNetworking

import XCTest
import RxTest
import RxSwift

class LoginUserViewModelTests: XCTestCase {

    // RxTest elements
    private let scheduler = TestScheduler(initialClock: 0)
    private var loginUserButtonEnabledObserver: TestableObserver<Bool>!
    private var registerUserButtonTouchObserver: TestableObserver<Void>!
    private let disposeBag = DisposeBag()
    
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
    
    // MARK: Given
    
    private func givenAViewModel() {
        
        viewModel = LoginUserViewModel()
        
        subscribeToLoginButtonEnabled()
        subscribeToRegisterUserButtonTouch()
    }
    
    private func subscribeToLoginButtonEnabled() {
        
        loginUserButtonEnabledObserver = scheduler.createObserver(Bool.self)
        
        viewModel.output.loginUserButtonEnabled
            .drive(loginUserButtonEnabledObserver)
            .disposed(by: disposeBag)
    }
    
    private func subscribeToRegisterUserButtonTouch() {
        
        registerUserButtonTouchObserver = scheduler.createObserver(Void.self)
        
        viewModel.output.registerUserButtonTouch
            .subscribe(registerUserButtonTouchObserver)
            .disposed(by: disposeBag)
    }
    
    private func givenFieldsSetTo(username: String, password: String) {
        
        viewModel.input.username.accept(username)
        viewModel.input.password.accept(password)
    }
    
    private func givenAViewModelWithCompletedFields() {
        
        givenAViewModel()
        givenFieldsSetTo(username: "u", password: "p")
    }

    // MARK: When
    
    private func whenViewModelIsCreated() {
        givenAViewModel()
    }
    
    private func whenFieldsAreSetTo(username: String, password: String) {
        givenFieldsSetTo(username: username, password: password)
    }
    
    private func whenUsernameChangesTo(_ text: String) {
        viewModel.input.username.accept(text)
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
    
    private func thenRegisterUserButtonTouchIsEmmited() {
        XCTAssertEqual(registerUserButtonTouchObserver.events.count, 1)
    }
}
