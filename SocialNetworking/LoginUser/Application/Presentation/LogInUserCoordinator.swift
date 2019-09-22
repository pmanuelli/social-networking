
import UIKit

class LoginUserCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let viewModel = LoginUserViewModel()
        let viewController = LoginUserViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
