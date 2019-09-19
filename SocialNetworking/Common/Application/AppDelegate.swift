
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        
        setupWindow(rootViewController: navigationController)
        setupCoordinator(navigationController: navigationController)
        
        return true
    }
    
    private func setupWindow(rootViewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func setupCoordinator(navigationController: UINavigationController) {
        mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator?.start()
    }
}

