
import UIKit

class MainCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let viewModel = CreateUserViewModel()
        let viewController = CreateUserViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }    
}
