//
//  ViewController.swift
//  basic-calculator
//
//  Created by Lareen Melo on 6/3/19.
//  Copyright © 2019 Lareen Melo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // TODO: Operations stack to undo better 😉
    // TODO: Start typing with result label, then push it to the operations tracker and such. 🤔
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
        guard let operation = (sender as! UIButton).titleLabel else {
            return
        }
        
        
        if operation.text != "=" {
            operationsTracker.text! += " \(operation.text!) "
        }
        
        if isTyping {
            calculator.setOperand(operand: Double(number) ?? 0.0)
        }
        
        calculator.performOperation(symbol: operation.text!)
        isTyping = false
        
        resultLabel.text = String(calculator.result)
    }
    
    @IBAction func touchDigit(_ sender: Any) {
        guard let buttonContent = (sender as! UIButton).titleLabel else {
            return
        }
        
        if !isTyping {
            
            if buttonContent.text == "." {
                operationsTracker.text! += "0."
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
        guard let buttonContent = (sender as! UIButton).titleLabel else {
            return
        }
        
        if buttonContent.text == "C" {
            
            // TODO: if stackoperation.pop == #
            // number = "0.0"
            // else
            
        
//            if !calculator.undo() {
//                number = "0.0"
//
//            }
            isTyping = false
            
        } else {
            operationsTracker.text = ""
            resultLabel.text = "0.0"
            calculator.clearHistory()
            isTyping = false
        }
    }
}

