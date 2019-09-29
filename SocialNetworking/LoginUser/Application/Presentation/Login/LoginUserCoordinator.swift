
import UIKit
import RxSwift

class LoginUserCoordinator {
    
    private let navigationController: UINavigationController
    private let userRepository: UserRepository
    
    private lazy var userService = UserServiceDefault(userRepository: userRepository)
    private lazy var loginUser = LoginUserDefault(userService: userService)
    private lazy var registerUser = RegisterUserDefault(userService: userService)
    
    private lazy var userTimelineCoordinator = UserTimelineCoordinator(navigationController: navigationController)
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, userRepository: UserRepository) {
        self.navigationController = navigationController
        self.userRepository = userRepository
    }
    
    func start() {
        
        goToLoginUser()
    }
    
    private func goToLoginUser() {
        
        let viewModel = LoginUserViewModel(loginUser: loginUser)
        let viewController = LoginUserViewController(viewModel: viewModel)
        
        subscribe(to: viewModel)
        
        pushViewController(viewController)
    }
    
    private func subscribe(to viewModel: LoginUserViewModel) {
        
        viewModel.output.registerUserButtonTouch
            .subscribe(onNext: { [weak self] _ in self?.goToRegisterUser() })
            .disposed(by: disposeBag)
        
        viewModel.output.didLoginUser
            .subscribe(onNext: { [weak self] _ in self?.goToUserTimeline() })
            .disposed(by: disposeBag)
    }
    
    private func goToRegisterUser() {
        
        let viewModel = RegisterUserViewModel(registerUser: registerUser)
        let viewController = RegisterUserViewController(viewModel: viewModel)
        
        subscribe(to: viewModel)
        
        pushViewController(viewController)
    }
    
    private func subscribe(to viewModel: RegisterUserViewModel) {
        
        viewModel.output.loginUserButtonTouch
            .subscribe(onNext: { [weak self] _ in self?.popViewController() })
            .disposed(by: disposeBag)
        
        viewModel.output.didRegisterUser
            .subscribe(onNext: { [weak self] _ in self?.goToUserTimeline() })
            .disposed(by: disposeBag)
    }
    
    private func pushViewController(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    private func goToUserTimeline() {
        userTimelineCoordinator.start()
    }
}
