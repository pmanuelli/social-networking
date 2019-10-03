
import UIKit
import UIKitExtensions

extension UIView {
    
    func applyTouchUpInsideAnimation(completion: (() -> Void)? = nil) {
        applyAnimation(TouchUpInsideViewAnimation(), completion: completion)
    }
    
    func applyAnimation(_ animation: ViewAnimation, completion: (() -> Void)? = nil) {
        animation.apply(to: self, completion: completion)
    }
}

protocol ViewAnimation {
    
    func apply(to view: UIView, completion: (() -> Void)?)
}

struct TouchUpInsideViewAnimation: ViewAnimation {
    
    func apply(to view: UIView, completion: (() -> Void)?) {
        
        applyScaleDown(view) {
            self.applyScaleUp(view, completion: completion)
        }
    }
    
    private func applyScaleDown(_ view: UIView, completion: (() -> Void)?) {
        
        UIView.animate(withDuration: 0.05, delay: 0,
                       options: .allowUserInteraction,
                       animations: { view.transform = .scale(0.85) },
                       completion: { _ in completion?() })
    }
    
    private func applyScaleUp(_ view: UIView, completion: (() -> Void)?) {
        
        UIView.animate(withDuration: 0.75, delay: 0,
                       usingSpringWithDamping: 0.40,
                       initialSpringVelocity: 1.0,
                       options: .allowUserInteraction,
                       animations: { view.transform = .identity },
                       completion: { _ in completion?() })
    }
}
