
import UIKit

class FlipTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return PresentFlippingAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissFlippingAnimationController()
    }
}

class PresentFlippingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromController = transitionContext.viewController(forKey: .from),
            let fromControllerSnapshot = fromController.view.snapshotView(afterScreenUpdates: true),
            let toController = transitionContext.viewController(forKey: .to)
            else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubviewToBounds(toController.view)
        containerView.addSubviewToBounds(fromControllerSnapshot)
        
        UIView.transition(from: fromControllerSnapshot,
                          to: toController.view,
                          duration: transitionDuration(using: transitionContext),
                          options: .transitionFlipFromLeft) { _ in transitionContext.completeTransition(true) }
    }
}

class DismissFlippingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let fromController = transitionContext.viewController(forKey: .from),
            let fromControllerSnapshot = fromController.view.snapshotView(afterScreenUpdates: true),
            let toController = transitionContext.viewController(forKey: .to)
            else { return }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubviewToBounds(toController.view)
        containerView.addSubviewToBounds(fromControllerSnapshot)
        
        UIView.transition(from: fromControllerSnapshot,
                          to: toController.view,
                          duration: transitionDuration(using: transitionContext),
                          options: .transitionFlipFromRight) { _ in transitionContext.completeTransition(true) }
    }
}
