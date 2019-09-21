
@testable import SocialNetworking

import XCTest
import RxTest
import RxSwift
import SwiftyMocky

class RegisterUserViewModelTests: XCTestCase {

    private var scheduler: TestScheduler!
    private var observer: TestableObserver<Bool>!
    
    private let registerUser = RegisterUserMock()
    
    private var viewModel: RegisterUserViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        
        scheduler = TestScheduler(initialClock: 0)
        observer = scheduler.createObserver(Bool.self)
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
        
        givenARegisterUserAction()
        givenAViewModel()
        givenFieldsSetTo(username: "tool", password: "FearInocolum$1",
                         givenName: "Fear", familyName: "Inoculum")
        
        whenRegisterUserButtonIsTouched()
        
        thenRegisterUserActionIsExecutedWith(username: "tool", password: "FearInocolum$1",
                                             givenName: "Fear", familyName: "Inoculum")
    }
    
    private func givenARegisterUserAction() {
        
        Given(registerUser, .execute(username: .any, password: .any,
                                     givenName: .any, familyName: .any,
                                     willReturn: .never()))
    }
    private func givenAViewModel() {
        
        viewModel = RegisterUserViewModel(registerUser: registerUser)
        
        viewModel.registerUserButtonEnabled
            .drive(observer)
            .disposed(by: disposeBag)
    }
    
    private func givenFieldsSetTo(username: String, password: String,
                                  givenName: String, familyName: String) {
        
        viewModel.username.accept(username)
        viewModel.password.accept(password)
        viewModel.givenName.accept(givenName)
        viewModel.familyName.accept(familyName)
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
        viewModel.username.accept(text)
    }
    
    private func whenRegisterUserButtonIsTouched() {
        viewModel.registerUserButtonTouched()
    }
    
    private func thenRegisterUserButtonIsDisabled() {
        
        let lastValue = observer.events.last?.value.element
        XCTAssertEqual(lastValue, false)
    }
    
    private func thenRegisterUserButtonIsEnabled() {
        
        let lastValue = observer.events.last?.value.element
        XCTAssertEqual(lastValue, true)
    }
    
    private func thenRegisterUserActionIsExecutedWith(username: String, password: String,
                                                      givenName: String, familyName: String) {
        
        Verify(registerUser, .once, .execute(username: .value(username),
                                             password: .value(password),
                                             givenName: .value(givenName),
                                             familyName: .value(familyName)))
    }
}
