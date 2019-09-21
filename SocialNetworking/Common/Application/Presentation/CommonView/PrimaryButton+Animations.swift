
import UIKit

extension PrimaryButton {

    func applyAnimation(_ animation: PrimaryButtonAnimation) {
        animation.apply(to: self)
    }
}

protocol PrimaryButtonAnimation {
    
    func apply(to button: PrimaryButton)
}

struct IsEnabledPropertyChangeAnimation: PrimaryButtonAnimation {
    
    func apply(to button: PrimaryButton) {
                
        UIView.transition(with: button, duration: 0.5, options: .transitionCrossDissolve,
                          animations: { self.changeButtonDesign(button, showAsEnabled: button.isEnabled) })
    }
    
    private func changeButtonDesign(_ button: PrimaryButton, showAsEnabled: Bool) {
        
        button.alpha = showAsEnabled ? 1 : 0.2
//        button.setTitleColor(showAsEnabled ? .white : ColorsCatalog.atLevelBackground)
    }
}
