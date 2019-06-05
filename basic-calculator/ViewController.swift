//
//  ViewController.swift
//  basic-calculator
//
//  Created by Lareen Melo on 6/3/19.
//  Copyright © 2019 Lareen Melo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var operationsTracker: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var clearContent: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func performOperation(_ sender: Any) {
        print("Missing: Perform Operation Implementation")
        
    }
    
    @IBAction func touchDigit(_ sender: Any) {
        print("Missing: Touch Digit Implementation")
    }
    
    @IBAction func clear(_ sender: Any) {
        print("Missing: Clear Implementation")
    }
    
    
}

