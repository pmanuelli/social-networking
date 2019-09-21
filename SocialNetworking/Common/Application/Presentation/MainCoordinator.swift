
import UIKit
import RxSwift

class MainCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let viewModel = RegisterUserViewModel(registerUser: RegisterUserDummy())
        let viewController = RegisterUserViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
        navigationController.isNavigationBarHidden = true
    }    
}

private class RegisterUserDummy: RegisterUser {
    
    func execute(username: String, password: String, givenName: String, familyName: String) -> Single<User> {
        abort()
    }
}
