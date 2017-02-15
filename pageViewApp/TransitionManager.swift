//
//  TransitionManager.swift
//  pageViewApp
//
//  Created by Miguel Orjuela on 14/02/17.
//  Copyright © 2017 Miguel Orjuela. All rights reserved.
//

import UIKit

class TransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    var isPresenting = false
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("presenting")
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("dimissing")
        isPresenting = false
        return self
    }
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        print("animating")
        let containerView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let duration = self.transitionDuration(using: transitionContext)
        
        if isPresenting {
            print("setting alpha for toVC", toVC)
            toVC.view.alpha = 0
            toVC.view.transform = CGAffineTransform(scaleX: 0, y: 0)
            containerView.addSubview(toVC.view)
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: [], animations: {
                toVC.view.alpha = 1
                toVC.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { (finished) in
                transitionContext.completeTransition(true)
            }
        } else {
            // dismissing
            UIView.animate(withDuration: duration, animations: {
                fromVC.view.alpha = 0
                fromVC.view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            }, completion: { (succeeded) in
                transitionContext.completeTransition(true)
                fromVC.view.removeFromSuperview()
            })
        }
    }
}
