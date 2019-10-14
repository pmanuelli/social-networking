
import UIKit
import UIKitExtensions
import RxSwift
import RxKeyboard

class RegisterUserView: UIView {

    @IBOutlet var usernameAtLabel: UILabel!
    
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
    }
    
    private func setupTextFields() {
        
        textFields = [usernameTextField, passwordTextField, givenNameTextField, familyNameTextField]
        textFields.forEach { setupPlaceholderTextColor($0) }
        
        usernameTextField.addTarget(self, action: #selector(usernameTextDidChange), for: .editingChanged)
    }
    
    private func setupPlaceholderTextColor(_ textField: UITextField) {
        
        let string = textField.placeholder ?? ""
        let attributes = [NSAttributedString.Key.foregroundColor : ColorsCatalog.belowLevelBackground]
                
        textField.attributedPlaceholder = NSAttributedString(string: string, attributes: attributes)
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
    private func usernameTextDidChange() {
        
        let isEmpty = usernameTextField.text?.isEmpty ?? true
        
        UIView.animate(withDuration: 0.25,
                       animations: { self.setUsernameAtLabel(isHidden: isEmpty) })
    }
    
    private func setUsernameAtLabel(isHidden: Bool) {
        usernameAtLabel.alpha = isHidden ? 0 : 1
        usernameAtLabel.isHidden = isHidden
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
        
        UIView.animate(withDuration: 0.25,
                       animations: { self.setErrorLabel(text: text, isHidden: false) })
    }
    
    func hideErrorLabel() {
        guard !errorLabel.isHidden else { return }
        
        UIView.animate(withDuration: 0.25,
                       animations: { self.setErrorLabel(text: " ", isHidden: true) })
    }
    
    private func setErrorLabel(text: String, isHidden: Bool) {
        errorLabel.text = text
        errorLabel.alpha = isHidden ? 0 : 1
        errorLabel.isHidden = isHidden
    }
}
