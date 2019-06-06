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
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var clearContent: UIButton!
    var number = ""
    var isTyping = false
    
    var calculator = Calculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func performOperation(_ sender: Any) {
        isTyping = false
        guard let operation = (sender as! UIButton).titleLabel else {
            return
        }
        
        if operation.text != "=" {
            operationsTracker.text! += " \(operation.text!) "
        }
        
        calculator.setOperand(operand: Double(number) ?? 0.0)
        calculator.performOperation(symbol: operation.text!)
        
        resultLabel.text = String(calculator.result)
    }
    
    @IBAction func touchDigit(_ sender: Any) {
        guard let buttonContent = (sender as! UIButton).titleLabel else {
            return
        }
        
        if !isTyping {
            if buttonContent.text == "." {
                operationsTracker.text = "0" + buttonContent.text!
                number = "0" + buttonContent.text!
                
            } else {
                operationsTracker.text! += buttonContent.text!
                number = buttonContent.text ?? "0"
                
            }
            
            isTyping = true
            
        } else {
            operationsTracker.text = operationsTracker.text! + buttonContent.text!
            number += buttonContent.text!
            
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        // TODO: Missing clear and clear history logic implementation
        print("Missing: Clear Implementation")
        /* if button.content == c
         undo last step
         else
         clear the life out of everything.
         */
    }
}

