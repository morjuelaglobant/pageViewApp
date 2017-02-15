//
//  DiscoverViewController.swift
//  pageViewApp
//
//  Created by Miguel Orjuela on 14/02/17.
//  Copyright © 2017 Miguel Orjuela. All rights reserved.
//

import UIKit

private let revealSequeId = "revealSegue"

class DiscoverViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    
    @IBOutlet fileprivate weak var cardView: UIView!
    
    let transitionManager = FlipTransitionManager()
    let dismissTransitionManager = FlipDismissAnimationController()

    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.layer.cornerRadius = 25
        cardView.layer.masksToBounds = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        cardView.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destination// as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self
        
        toViewController.modalPresentationStyle = UIModalPresentationStyle.custom        
    }

    func handleTap() {
        performSegue(withIdentifier: revealSequeId, sender: nil)
    }
}

extension DiscoverViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transitionManager.originFrame = cardView.frame
        return transitionManager
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        dismissTransitionManager.destinationFrame = cardView.frame
        return dismissTransitionManager
    }
}
