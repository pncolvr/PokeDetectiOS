//
//  PresentMenuAnimator.swift
//  PGD
//
//  Created by Pedro Oliveira on 30/07/16.
//  Copyright © 2016 Pedro Oliveira. All rights reserved.
//

import UIKit

class PresentMenuAnimator: NSObject {

}

extension PresentMenuAnimator : UIViewControllerAnimatedTransitioning {
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
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false)
        snapshot?.tag = MenuHelper.snapshotNumber
        snapshot?.isUserInteractionEnabled = false
        
        containerView.insertSubview(snapshot!, aboveSubview: toVC.view)
        fromVC.view.isHidden = true
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                snapshot?.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
            },
            completion: { _ in
                fromVC.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
