
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
    
    func execute(data: RegistrationData) -> Single<User> {
        
        if data.username == "error" {
            return .error(NSError(domain: "asd", code: 10, localizedDescription: "Caca pija error!"))

        }
        else {
            return .just(User(username: data.username, givenName: data.givenName, familyName: data.familyName))
        }
    }
}
