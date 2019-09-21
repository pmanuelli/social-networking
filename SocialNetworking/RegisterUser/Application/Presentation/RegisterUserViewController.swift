
import UIKit
import UIKitExtensions
import RxSwift
import RxSwiftExt
import RxCocoa

class RegisterUserViewController: UIViewController {
    
    lazy var mainView = RegisterUserView.initFromNib()
    
    private let viewModel: RegisterUserViewModel
    
    private let disposeBag = DisposeBag()

    init(viewModel: RegisterUserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    private func bindViewModel() {

        bindTextFields()
        bindRegisterButton()
    }
    
    private func bindTextFields() {
        
        bind(mainView.usernameTextField, to: viewModel.username)
        bind(mainView.passwordTextField, to: viewModel.password)
        bind(mainView.givenNameTextField, to: viewModel.givenName)
        bind(mainView.familyNameTextField, to: viewModel.familyName)
    }
    
    private func bind(_ textField: UITextField, to relay: BehaviorRelay<String>) {
        
        textField.rx.text
            .asObservable()
            .unwrap()
            .bind(to: relay)
            .disposed(by: disposeBag)
    }
    
    private func bindRegisterButton() {
                
        viewModel.registerUserButtonEnabled
            .drive(onNext: { [weak self] in self?.registerUserButtonEnabledChanged($0) })
            .disposed(by: disposeBag)
    }
    
    private func registerUserButtonEnabledChanged(_ enabled: Bool) {
        
        mainView.registerUserButton.isEnabled = enabled
        mainView.registerUserButton.applyAnimation(IsEnabledPropertyChangeAnimation())
    }
}
