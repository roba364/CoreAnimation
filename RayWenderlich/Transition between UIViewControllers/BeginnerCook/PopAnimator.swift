
import Foundation
import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var originFrame = CGRect.zero
    var presenting = false 
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1 - set up transition
        let containerView = transitionContext.containerView

        guard
            let toView = transitionContext.view(forKey: .to),
            let herbView = presenting ? toView : transitionContext.view(forKey: .from) else { return}
        
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let xScaleFactor = presenting
            ? initialFrame.width / finalFrame.width
            : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting
        ? initialFrame.height / finalFrame.height
        : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            
            herbView.transform = scaleTransform
            
            herbView.center = CGPoint(
            x: initialFrame.midX,
            y: initialFrame.midY)
        }
        
        herbView.layer.cornerRadius = presenting ? 20.0 / xScaleFactor : 0.0
        herbView.clipsToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(herbView)
        
        guard let herbController = transitionContext.viewController(forKey: presenting ? .to : .from) as? HerbDetailsViewController else { return }
        if presenting {
            herbController.containerView.alpha = 0.0
            
        }
        // 2 - Animate!!!
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0,
                       animations: {
                        herbView.layer.cornerRadius = presenting ? 0.0 : 20.0 / xScaleFactor
                        herbView.transform = self.presenting ? .identity : scaleTransform
                        herbView.center = CGPoint(
                            x: finalFrame.midX,
                            y: finalFrame.midY)
                        herbController.containerView.alpha = self.presenting ? 1.0 : 0.0
        },
                       completion: { (_) in
                        // 3 - Complete transition
                        if !self.presenting {
                            let viewController = transitionContext.view(forKey: .to) as! ViewController
                            viewController.selectedImage?.isHidden = false
                        }
                        transitionContext.completeTransition(true)
        })
        
    }
    
    
}
