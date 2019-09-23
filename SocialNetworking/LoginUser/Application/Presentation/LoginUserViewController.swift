
import UIKit
import RxSwift
import RxCocoa

class LoginUserViewController: UIViewController {
    
    lazy var mainView = LoginUserView.initFromNib()

    private let viewModel: LoginUserViewModel

    private let disposeBag = DisposeBag()
    
    init(viewModel: LoginUserViewModel) {
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
        bindLoginUserButton()
        bindRegisterUserButton()
        bindLoginErrorDescription()
    }
    
    private func bindTextFields() {
        
        bind(mainView.usernameTextField, to: viewModel.input.username)
        bind(mainView.passwordTextField, to: viewModel.input.password)
    }
    
    private func bind(_ textField: UITextField, to relay: BehaviorRelay<String>) {
        
        textField.rx.text
            .asObservable()
            .unwrap()
            .bind(to: relay)
            .disposed(by: disposeBag)
    }
    
    private func bindLoginUserButton() {
        
        viewModel.output.loginUserButtonEnabled
            .drive(onNext: { [weak self] in self?.loginUserButtonEnabledChanged($0) })
            .disposed(by: disposeBag)
    }
    
    private func loginUserButtonEnabledChanged(_ enabled: Bool) {
        
        mainView.loginUserButton.isEnabled = enabled
        mainView.loginUserButton.applyAnimation(IsEnabledPropertyChangeAnimation())
    }
    
    private func bindRegisterUserButton() {
        
        mainView.registerUserButton.addTarget(self, action: #selector(registerUserButtonTouched), for: .touchUpInside)
    }
    
    @objc
    private func registerUserButtonTouched() {
        viewModel.registerUserButtonTouched()
    }
    
    private func bindLoginErrorDescription() {
        
        viewModel.output.loginErrorDescription
            .drive(onNext: { [weak self] in self?.loginErrorDescriptionChanged($0) })
            .disposed(by: disposeBag)
    }
    
    private func loginErrorDescriptionChanged(_ description: String) {
        
        if description.isEmpty {
            mainView.hideErrorLabel()
        }
        else {
            mainView.showErrorLabel(description)
        }
    }
}
