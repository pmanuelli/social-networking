
import UIKit
import RxSwift

class LoginUserCoordinator {
    
    var onFinish: ((User) -> Void)?
    
    private let navigationController: UINavigationController
        
    private var userTimelineCoordinator: UserTimelineCoordinator?
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        goToLoginUser()
    }
    
    private func goToLoginUser() {
        
        let viewModel = LoginUserViewModel(loginUser: Dependencies.loginUser)
        let viewController = LoginUserViewController(viewModel: viewModel)
        
        subscribe(to: viewModel)
        
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    private func subscribe(to viewModel: LoginUserViewModel) {
        
        viewModel.output.registerUserButtonTouch
            .subscribe(onNext: { [weak self] _ in self?.goToRegisterUser() })
            .disposed(by: disposeBag)
        
        viewModel.output.didLoginUser
            .subscribe(onNext: { [weak self] in self?.userDidLogin(user: $0) })
            .disposed(by: disposeBag)
    }
    
    private func goToRegisterUser() {
        
        let viewModel = RegisterUserViewModel(registerUser: Dependencies.registerUser)
        let viewController = RegisterUserViewController(viewModel: viewModel)
        
        subscribe(to: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func subscribe(to viewModel: RegisterUserViewModel) {
        
        viewModel.output.loginUserButtonTouch
            .subscribe(onNext: { [weak self] _ in self?.popViewController() })
            .disposed(by: disposeBag)
        
        viewModel.output.didRegisterUser
            .subscribe(onNext: { [weak self] in self?.userDidLogin(user: $0) })
            .disposed(by: disposeBag)
    }
        
    private func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    private func userDidLogin(user: User) {
        onFinish?(user)
    }
}
