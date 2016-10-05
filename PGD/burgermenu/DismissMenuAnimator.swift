//
//  DismissMenuAnimator.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit

class DismissMenuAnimator: NSObject {

}

extension DismissMenuAnimator : UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
            else {
                return
            }
        let containerView = transitionContext.containerView

        let snapshot = containerView.viewWithTag(MenuHelper.snapshotNumber)
        
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                snapshot?.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
            },
            completion: { _ in
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if didTransitionComplete {
                    containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
                    snapshot?.removeFromSuperview()
                }
                transitionContext.completeTransition(didTransitionComplete)
            }
        )
    }
}
