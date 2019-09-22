
import UIKit
import RxSwift

class RegisterUserCoordinator {

    private let navigationController: UINavigationController
    private let userRepository: UserRepository
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, userRepository: UserRepository) {
        self.navigationController = navigationController
        self.userRepository = userRepository
    }
    
    func start() {
        
        let userService = UserServiceDefault(userRepository: userRepository)
        let registerUser = RegisterUserDefault(userService: userService)
        let viewModel = RegisterUserViewModel(registerUser: registerUser)
        let viewController = RegisterUserViewController(viewModel: viewModel)
        
        subscribe(to: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
        
    private func subscribe(to viewModel: RegisterUserViewModel) {
        
        viewModel.output.loginUserButtonTouch
            .subscribe(onNext: { [weak self] _ in self?.popViewController() })
            .disposed(by: disposeBag)
    }
    
    private func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
