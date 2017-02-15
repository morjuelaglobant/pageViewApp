//
//  CardViewController.swift
//  pageViewApp
//
//  Created by Miguel Orjuela on 14/02/17.
//  Copyright © 2017 Miguel Orjuela. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
