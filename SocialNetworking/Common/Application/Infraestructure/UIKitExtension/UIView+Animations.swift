
import UIKit
import UIKitExtensions

extension UIView {
    
    func applyAnimation(_ animation: ViewAnimation) {
        animation.apply(to: self)
    }
}

protocol ViewAnimation {
    
    func apply(to view: UIView)
}

struct TouchUpInsideViewAnimation: ViewAnimation {
    
    func apply(to view: UIView) {
                
        UIView.animate(withDuration: 0.05, delay: 0,
                       options: .allowUserInteraction,
                       animations: { view.transform = .scale(0.85) },
                       completion: { _ in self.applyScaleUp(view) })
    }
    
    private func applyScaleUp(_ view: UIView) {
        
        UIView.animate(withDuration: 0.75, delay: 0,
                       usingSpringWithDamping: 0.40,
                       initialSpringVelocity: 1.0,
                       options: .allowUserInteraction,
                       animations: { view.transform = .identity })
    }
}
