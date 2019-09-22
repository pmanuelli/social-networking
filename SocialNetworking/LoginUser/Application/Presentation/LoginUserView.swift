
import UIKit
import RxSwift
import RxKeyboard

class LoginUserView: UIView {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    
    @IBOutlet var loginUserButton: PrimaryButton!
    @IBOutlet var registerUserButton: UIButton!
    
    @IBOutlet var keyboardAdjustmentViewHeightConstraint: NSLayoutConstraint!
    
    private var textFields: [UITextField] = []
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        observeKeyboardHeight()

        setupTextFields()
        setupButtons()
    }
    
    private func setupTextFields() {
        
        textFields = [usernameTextField, passwordTextField]
        textFields.forEach { setupPlaceholderTextColor($0)  }
    }
    
    private func setupPlaceholderTextColor(_ textField: UITextField) {
        
        let string = textField.placeholder ?? ""
        let attributes = [NSAttributedString.Key.foregroundColor : ColorsCatalog.belowLevelBackground]
                
        textField.attributedPlaceholder = NSAttributedString(string: string, attributes: attributes)
    }
    
    private func setupButtons() {
        
        let buttons: [UIButton] = [loginUserButton, registerUserButton]
        buttons.forEach { $0.addTarget(self, action: #selector(buttonTouched(_:)), for: .touchUpInside) }
    }
        
    private func observeKeyboardHeight() {
        
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] in self?.keyboardVisibleHeightDidChange($0) })
            .disposed(by: disposeBag)
    }
    
    private func keyboardVisibleHeightDidChange(_ height: CGFloat) {
        
        keyboardAdjustmentViewHeightConstraint.constant = height
        layoutIfNeeded()
    }
    
    @objc
    private func buttonTouched(_ button: UIButton) {
        button.applyAnimation(TouchUpInsideViewAnimation())
    }
}

extension LoginUserView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setNextResponder(current: textField)
        return false
    }
    
    private func setNextResponder(current textField: UITextField) {
        
        if let nextTextField = findNextTextField(of: textField) {
            nextTextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
    }
    
    private func findNextTextField(of textField: UITextField) -> UITextField? {
        return textFields.nextElement(after: textField)
    }
}
