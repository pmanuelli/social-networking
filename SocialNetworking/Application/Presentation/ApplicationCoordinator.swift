
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
        
        startLogin()
    }
    
    private func startLogin() {
        
        loginUserCoordinator = LoginUserCoordinator(navigationController: navigationController)
        
        loginUserCoordinator?.onFinish = { [weak self] in self?.startTimeline($0) }
        loginUserCoordinator?.start()
    }
    
    private func startTimeline(_ user: User) {
        
        userTimelineCoordinator = UserTimelineCoordinator(navigationController: navigationController, user: user)
        
        userTimelineCoordinator?.onFinish = { [weak self] in self?.stopTimeline() }
        userTimelineCoordinator?.start()
    }
    
    private func stopTimeline() {
        
        startLogin()
        userTimelineCoordinator?.stop()
    }
}
