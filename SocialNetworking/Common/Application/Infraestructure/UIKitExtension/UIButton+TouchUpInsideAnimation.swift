
import UIKit

extension UIButton {
    
    func animateOnTouchUpInside() {
        UIButtonTouchUpInsideAnimator.animate(self)
    }
}

class UIButtonTouchUpInsideAnimator {
    
    static private let shared = UIButtonTouchUpInsideAnimator()
    
    static func animate(_ button: UIButton) {
        button.addTarget(shared, action: #selector(buttonTouched(_:)), for: .touchUpInside)
    }

    @objc
    private func buttonTouched(_ button: UIButton) {
        button.applyAnimation(TouchUpInsideViewAnimation())
    }
}
