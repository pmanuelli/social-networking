
@testable import SocialNetworking

import XCTest
import RxTest
import RxSwift

class RegisterUserViewModelTests: XCTestCase {

    private var scheduler: TestScheduler!
    private var observer: TestableObserver<Bool>!
    
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
        
        whenFieldsAreSetTo(username: "username", password: "password",
                           givenName: "Sandro", familyName: "Mancuso")
        
        thenRegisterUserButtonIsEnabled()
    }
    
    func testDisablesRegisterUserButtonWhenAFieldIsEmpty() {
        
        givenAViewModel()
        
        whenFieldsAreSetTo(username: "username", password: "password",
                           givenName: "Sandro", familyName: "Mancuso")
        
        whenUsernameChangesTo("")
        
        thenRegisterUserButtonIsDisabled()
    }
    
    private func givenAViewModel() {
        
        viewModel = RegisterUserViewModel()
        
        viewModel.registerUserButtonEnabled
            .drive(observer)
            .disposed(by: disposeBag)
    }
        
    private func whenViewModelIsCreated() {
        givenAViewModel()
    }
    
    private func whenFieldsAreSetTo(username: String, password: String,
                               givenName: String, familyName: String) {
        
        viewModel.username.accept(username)
        viewModel.password.accept(username)
        viewModel.givenName.accept(givenName)
        viewModel.familyName.accept(givenName)
    }
    
    private func whenUsernameChangesTo(_ text: String) {
        viewModel.username.accept(text)
    }
    
    private func thenRegisterUserButtonIsDisabled() {
        
        let lastValue = observer.events.last?.value.element
        XCTAssertEqual(lastValue, false)
    }
    
    private func thenRegisterUserButtonIsEnabled() {
        
        let lastValue = observer.events.last?.value.element
        XCTAssertEqual(lastValue, true)
    }
}
