
import UIKit
import RxSwift

class ApplicationCoordinator {
    
    private let navigationController: UINavigationController
    
    private let userRepository = InMemoryUserRepository()
    
    private lazy var loginUserCoordinator = LoginUserCoordinator(navigationController: navigationController,
                                                                 userRepository: userRepository)

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        
        loginUserCoordinator.start()
    }    
}
