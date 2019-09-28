
import UIKit
import UIKitExtensions
import RxSwift
import RxKeyboard

class RegisterUserView: UIView {

    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var givenNameTextField: UITextField!
    @IBOutlet var familyNameTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!

    @IBOutlet var registerUserButton: PrimaryButton!
    @IBOutlet var loginUserButton: IBDesignableUIButton!
    
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
        
        textFields = [usernameTextField, passwordTextField, givenNameTextField, familyNameTextField]
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

extension RegisterUserView: UITextFieldDelegate {
    
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

extension RegisterUserView {
    
    func showErrorLabel(_ text: String) {
        guard errorLabel.isHidden else { return }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.errorLabel.text = text
            self.errorLabel.alpha = 1
            self.errorLabel.isHidden = false })
    }
    
    func hideErrorLabel() {
        guard !errorLabel.isHidden else { return }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.errorLabel.alpha = 0
            self.errorLabel.isHidden = true })
    }
}
