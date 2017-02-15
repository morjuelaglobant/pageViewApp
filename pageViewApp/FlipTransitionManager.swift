//
//  FlipTransitionManager.swift
//  pageViewApp
//
//  Created by Miguel Orjuela on 15/02/17.
//  Copyright © 2017 Miguel Orjuela. All rights reserved.
//

import UIKit

class FlipTransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            //            let containerView = transitionContext.containerView,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        print(fromVC)
        print(toVC)
        let containerView = transitionContext.containerView
        
        // 2
        let initialFrame = originFrame
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        // 3
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = initialFrame
        snapshot?.layer.cornerRadius = 25
        snapshot?.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        toVC.view.isHidden = true
        
        AnimationHelper.perspectiveTransformForContainerView(containerView)
        snapshot?.layer.transform = AnimationHelper.yRotation(M_PI_2)
        
        // 1
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                // 2
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3, animations: {
                    fromVC.view.layer.transform = AnimationHelper.yRotation(-M_PI_2)
                })
                
                // 3
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3, animations: {
                    snapshot?.layer.transform = AnimationHelper.yRotation(0.0)
                })
                
                // 4
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3, animations: {
                    snapshot?.frame = finalFrame
                })
        },
            completion: { _ in
                // 5
                toVC.view.isHidden = false
                fromVC.view.layer.transform = AnimationHelper.yRotation(0.0)
                snapshot?.removeFromSuperview()
                transitionContext.completeTransition(true)
        })
    }
}
