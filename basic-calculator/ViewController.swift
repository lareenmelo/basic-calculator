//
//  ViewController.swift
//  basic-calculator
//
//  Created by Lareen Melo on 6/3/19.
//  Copyright © 2019 Lareen Melo. All rights reserved.
//


// TODO - Stacks for operations + numbers
/*
 
 IDEA: have two stacks, push it and pop it wise and don't forget to constantly replace the label when pushing or popping
       changes to the stack.
 */
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var operationsTracker: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var operationsScroller: UIScrollView!
    
    
    var number = ""
    var isTyping = false
    var calculator = Calculator()
    var numbersStack: [Double] = []
    var isClearAll: Bool = true {
        didSet{
            if !isClearAll {
                clear.setTitle("C", for: .normal)
            } else {
                clear.setTitle("AC", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "0"
        operationsTracker.sizeToFit()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func performOperation(_ sender: Any) {
        guard let operation = (sender as! UIButton).titleLabel else {
            return
        }
        
        if isTyping {
            calculator.setOperand(operand: Double(number) ?? 0.0)
        } else {
            if operationsTracker.text == "" {
                operationsTracker.text! += "0"
            }
        }
        
        calculator.performOperation(symbol: operation.text!)
        
        if operation.text != "=" && isTyping {
            operationsTracker.text! += " \(operation.text!) "
            
        } else {
            resultLabel.text = calculator.result
        }
        
        isTyping = false

    }
    
    @IBAction func touchDigit(_ sender: Any) {
        if isClearAll {
            isClearAll.toggle()
        }

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

            isTyping.toggle()

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
            if isTyping {
                operationsTracker.text = String((operationsTracker.text?.dropLast(number.count))!)
                number = "0.0"

            } else {
                calculator.undo()
            }
            isClearAll.toggle()
            isTyping.toggle()

        } else {
            operationsTracker.text = ""
            resultLabel.text = "0"
            calculator.clearHistory()
            isTyping.toggle()
        }
    }
}

