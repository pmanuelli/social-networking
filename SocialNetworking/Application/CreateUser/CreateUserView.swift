
import UIKit
import UIKitExtensions
import RxSwift
import RxKeyboard

class CreateUserView: UIView {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var createUserButton: UIButton!
    
    @IBOutlet var keyboardAdjustmentViewHeightConstraint: NSLayoutConstraint!

    private var textFields: [UITextField] = []
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTextFields()
        observeKeyboardHeight()
    }
    
    private func setupTextFields() {
        
        textFields = [userNameTextField, firstNameTextField, lastNameTextField]
        textFields.forEach { setupPlaceholderTextColor($0)  }
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
}

extension CreateUserView: UITextFieldDelegate {
    
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
