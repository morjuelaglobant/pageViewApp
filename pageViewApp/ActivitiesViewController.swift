//
//  ActivitiesViewController.swift
//  pageViewApp
//
//  Created by Miguel Orjuela on 15/02/17.
//  Copyright © 2017 Miguel Orjuela. All rights reserved.
//

import UIKit

private let revealSequeId = "revealActivities"

class ActivitiesViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        toViewController.transitioningDelegate = transitionManager
        
        toViewController.modalPresentationStyle = UIModalPresentationStyle.custom
    }
    
    @IBAction func showActivity(_ sender: Any) {
        performSegue(withIdentifier: revealSequeId, sender: nil)
    }
}
