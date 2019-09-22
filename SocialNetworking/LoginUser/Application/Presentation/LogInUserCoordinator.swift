
import UIKit
import RxSwift

class LoginUserCoordinator {
    
    private let navigationController: UINavigationController
    private let userRepository: UserRepository
    
    private lazy var registerUserCoordinator = RegisterUserCoordinator(navigationController: navigationController,
                                                                       userRepository: userRepository)
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, userRepository: UserRepository) {
        self.navigationController = navigationController
        self.userRepository = userRepository
    }
    
    func start() {
        
        let viewModel = LoginUserViewModel()
        let viewController = LoginUserViewController(viewModel: viewModel)
        
        subscribe(to: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func subscribe(to viewModel: LoginUserViewModel) {
        
        viewModel.output.registerUserButtonTouch
            .subscribe(onNext: { [weak self] _ in self?.startRegisterUserCoordinator() })
            .disposed(by: disposeBag)
    }
    
    private func startRegisterUserCoordinator() {
        registerUserCoordinator.start()
    }
}
