
import Foundation

class UserTimelineCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let viewModel = UserTimelineViewModel()
        let viewController = UserTimelineViewController(viewModel: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
