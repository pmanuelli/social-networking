
import UIKit
import RxSwift

class RegisterUserCoordinator {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        navigationController.pushViewController(createViewController(), animated: true)
    }
    
    private func createViewController() -> UIViewController {
        
        let userService = UserServiceDefault(userRepository: DummyUserRepository())
        let registerUser = RegisterUserDefault(userService: userService)
        let viewModel = RegisterUserViewModel(registerUser: registerUser)
        return RegisterUserViewController(viewModel: viewModel)
    }
}

class DummyUserRepository: UserRepository {

    func add(_ user: User) -> Completable {
        return .empty()
    }
    
    func isUsernameTaken(_ username: String) -> Single<Bool> {
        return .just(true)
    }
}
