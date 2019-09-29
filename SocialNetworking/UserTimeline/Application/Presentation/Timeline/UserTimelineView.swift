
import UIKit

class UserTimelineView: UIView {

    @IBOutlet var postTextView: UITextView!
    @IBOutlet var publishButton: PrimaryButton!
    
    override func awakeFromNib() {
        
        setupPostTextView()
        setupButton()
    }
    
    private func setupPostTextView() {
    
        setPostTextViewInsets()
        setPlaceholderStyle(postTextView)
    }
    
    private func setPostTextViewInsets() {
        postTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        postTextView.scrollIndicatorInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    private func setupButton() {
        publishButton.animateOnTouchUpInside()
        publishButton.isEnabled = false
    }

    private func setNonPlaceholderStyle(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = ColorsCatalog.aboveLevelFontBody
    }
    
    private func setPlaceholderStyle(_ textView: UITextView) {
        textView.text = "What is going on?"
        textView.textColor = ColorsCatalog.atLevelBackground
    }
}

extension UserTimelineView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setNonPlaceholderStyle(textView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        let shouldEnablePublishButton = !textView.text.isEmpty
        
        if publishButton.isEnabled != shouldEnablePublishButton {
            changePublishButtonIsEnabled(to: shouldEnablePublishButton)
        }
    }
    
    private func changePublishButtonIsEnabled(to enabled: Bool) {
        publishButton.isEnabled = enabled
        publishButton.applyAnimation(IsEnabledPropertyChangeAnimation())
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            setPlaceholderStyle(textView)
        }
    }
}
