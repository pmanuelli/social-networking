
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
        bindRegisterUserButton()
        bindLoginUserButton()
        bindRegisterErrorDescription()
    }
    
    private func bindTextFields() {
        
        bind(mainView.usernameTextField, to: viewModel.input.username)
        bind(mainView.passwordTextField, to: viewModel.input.password)
        bind(mainView.givenNameTextField, to: viewModel.input.givenName)
        bind(mainView.familyNameTextField, to: viewModel.input.familyName)
    }
    
    private func bind(_ textField: UITextField, to relay: BehaviorRelay<String>) {
        
        textField.rx.text
            .asObservable()
            .unwrap()
            .bind(to: relay)
            .disposed(by: disposeBag)
    }
    
    private func bindRegisterUserButton() {
                
        viewModel.output.registerUserButtonEnabled
            .drive(onNext: { [weak self] in self?.registerUserButtonEnabledChanged($0) })
            .disposed(by: disposeBag)
        
        mainView.registerUserButton.rx.tap
            .bind(onNext: { [weak self] in self?.registerUserButtonTouched() })
            .disposed(by: disposeBag)
    }
    
    private func registerUserButtonEnabledChanged(_ enabled: Bool) {
        
        mainView.registerUserButton.isEnabled = enabled
        mainView.registerUserButton.applyAnimation(IsEnabledPropertyChangeAnimation())
    }
    
    private func registerUserButtonTouched() {
        
        mainView.registerUserButton.applyTouchUpInsideAnimation() {
            self.viewModel.registerUserButtonTouched()
        }
    }
    
    private func bindLoginUserButton() {
        
        mainView.loginUserButton.rx.tap
            .bind(onNext: { [weak self] in self?.loginUserButtonTouched() })
            .disposed(by: disposeBag)
    }
    
    private func loginUserButtonTouched() {
        
        mainView.loginUserButton.applyTouchUpInsideAnimation() {
            self.viewModel.loginUserButtonTouched()
        }
    }
    
    private func bindRegisterErrorDescription() {
        
        viewModel.output.registerErrorDescription
            .drive(onNext: { [weak self] in self?.registerErrorDescriptionChanged($0) })
            .disposed(by: disposeBag)
    }
    
    private func registerErrorDescriptionChanged(_ description: String) {
        
        if description.isEmpty {
            mainView.hideErrorLabel()
        }
        else {
            mainView.showErrorLabel(description)
        }
    }
}
