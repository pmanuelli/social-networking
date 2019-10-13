
import UIKit
import RxSwift

class ApplicationCoordinator {
    
    private let navigationController: UINavigationController
        
    private var loginUserCoordinator: LoginUserCoordinator?
    private var userTimelineCoordinator: UserTimelineCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
    }
    
    func start() {
        
        goToLogin()
    }
    
    private func goToLogin() {
        
        loginUserCoordinator = LoginUserCoordinator(navigationController: navigationController)
        
        loginUserCoordinator?.onFinish = { [weak self] in self?.goToTimeline($0) }
        loginUserCoordinator?.start()
    }
    
    private func goToTimeline(_ user: User) {
        
        userTimelineCoordinator = UserTimelineCoordinator(navigationController: navigationController, userId: user.id)
        
        userTimelineCoordinator?.onFinish = { [weak self] in self?.goToLogin() }
        userTimelineCoordinator?.start()
    }
}
