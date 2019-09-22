
import UIKit
import RxSwift

class MainCoordinator {
    
    private let navigationController: UINavigationController
    
    private lazy var loginUserCoordinator = LoginUserCoordinator(navigationController: navigationController)

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        
        loginUserCoordinator.start()
    }    
}
