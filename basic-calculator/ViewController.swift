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
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var operationsScroller: UIScrollView!
    
    
    var number = ""
    var isTyping = false
    var operatorExists = false
    var finishedCalculating = false
    var calculator = Calculator()
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
        
        if finishedCalculating {
            operationsTracker.text = resultLabel.text!
            finishedCalculating.toggle()
        }
        
        
        if isTyping {
            calculator.setOperand(operand: Double(number) ?? 0.0)
        } else {
            if operationsTracker.text == "" {
                operationsTracker.text! += "0"
            }
        }
        
        calculator.performOperation(symbol: operation.text!)
        
        if operation.text != "=" && operation.text != "+/-" {
            if operatorExists {
                operationsTracker.text! += "\(number) \(operation.text!) "
                print("Operator already exists")
                
            } else {
                operatorExists = true
                if operation.text == "÷" {
                    operationsTracker.text! += " / "
                    
                } else {
                    operationsTracker.text! += " \(operation.text!) "
                    
                }
            }
            
        } else if operation.text == "+/-" {
            if Double(calculator.result) ?? 0.0 < 0.0 {
                operationsTracker.text = String((operationsTracker.text?.dropLast(number.count))!)
                operationsTracker.text! += ("(\(calculator.result))")

                
            } else {
                operationsTracker.text = String((operationsTracker.text?.dropLast(number.count + 3))!)
                operationsTracker.text! += calculator.result


            }
        } else {
            finishedCalculating.toggle()
            resultLabel.text = calculator.result
            
        }
        
        isTyping = false
        
    }
    
    @IBAction func touchDigit(_ sender: Any) {
        operatorExists = false

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
            operatorExists = false
            
            
            
        } else {
            operationsTracker.text = ""
            resultLabel.text = "0"
            calculator.clearHistory()
            isTyping.toggle()
            operatorExists = false
            
        }
    }
}

