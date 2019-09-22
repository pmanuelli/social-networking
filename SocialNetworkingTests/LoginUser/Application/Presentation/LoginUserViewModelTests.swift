
@testable import SocialNetworking

import XCTest
import RxTest
import RxSwift

class LoginUserViewModelTests: XCTestCase {

    // RxTest elements
    private let scheduler = TestScheduler(initialClock: 0)
    private var registerUserButtonTouchObserver: TestableObserver<Void>!
    private let disposeBag = DisposeBag()
    
    // Object under test
    private var viewModel: LoginUserViewModel!
    
    func testInformsWhenRegisterUserButtonIsTouched() {
        
        givenAViewModel()
        
        whenRegisterUserButtonIsTouched()
        
        thenRegisterUserButtonTouchIsEmmited()
    }
    
    // MARK: Given
    
    private func givenAViewModel() {
        
        viewModel = LoginUserViewModel()
        
        subscribeToRegisterUserButtonTouch()
    }
    
    private func subscribeToRegisterUserButtonTouch() {
        
        registerUserButtonTouchObserver = scheduler.createObserver(Void.self)
        
        viewModel.output.registerUserButtonTouch
            .subscribe(registerUserButtonTouchObserver)
            .disposed(by: disposeBag)
    }
    
    // MARK: When
    
    private func whenRegisterUserButtonIsTouched() {
        viewModel.registerUserButtonTouched()
    }
    
    // MARK: Then
    
    private func thenRegisterUserButtonTouchIsEmmited() {
        XCTAssertEqual(registerUserButtonTouchObserver.events.count, 1)
    }
}
