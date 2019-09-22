
import UIKit
import RxSwift

class LoginUserCoordinator {
    
    private let navigationController: UINavigationController
    
    private lazy var registerUserCoordinator = RegisterUserCoordinator(navigationController: navigationController)
    
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
