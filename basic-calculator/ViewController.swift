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
    var resultNumber = ""
    var negativeNumberEvaluator = false
    var isTyping = false
    var operatorExists = false
    var finishedCalculating = false
    var numberExists = false
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
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        operationsTracker.sizeToFit()
        
    }
    
    @IBAction func performOperation(_ sender: Any) {
        guard let operation = (sender as! UIButton).titleLabel else {
            return
        }
        
        if finishedCalculating {
            operationsTracker.text = resultNumber
            finishedCalculating.toggle()
        }
        
        if isTyping {
            calculator.setOperand(operand: Double(number) ?? 0.0)
            numberExists = true
            operatorExists = false
            
        } else {
            if operationsTracker.text == "" {
                operationsTracker.text! += "0"
            }
        }
        
        calculator.performOperation(symbol: operation.text!)
        
        if operation.text != "=" && operation.text != "+/-" {
            if operatorExists {
                calculator.setOperand(operand: Double(number) ?? 0.0)
                operationsTracker.text! += "\(number) \(operation.text!) "
                
            } else {
                operatorExists = true
                if operation.text == "÷" {
                    operationsTracker.text! += " / "
                    
                } else {
                    operationsTracker.text! += " \(operation.text!) "
                    
                }
            }
            isTyping = false
            
        } else if operation.text == "+/-" {
            negativeNumberEvaluator = true
            if numberExists {
                if Double(calculator.result) ?? 0.0 < 0.0 {
                    operationsTracker.text = String((operationsTracker.text?.dropLast(calculator.result.count - 1 ))!)
                    operationsTracker.text! += ("(\(calculator.result))")
                    
                } else {
                    operationsTracker.text = String((operationsTracker.text?.dropLast(calculator.result.count + 3))!)
                    operationsTracker.text! += calculator.result
                    
                }
            } else {
                print("whatchadoin'huh?")
            }
        } else {
            negativeNumberEvaluator.toggle()
            finishedCalculating.toggle()
            resultNumber = calculator.result
            resultLabel.text = calculator.result
            
            if !isClearAll {
                isClearAll.toggle()
            }
            
            isTyping = false
            
        }
        numberExists.toggle()
        
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
            if isTyping && negativeNumberEvaluator {
                if Double(calculator.result) ?? 0.0 < 0.0 {
                    operationsTracker.text = String((operationsTracker.text?.dropLast(calculator.result.count + 3))!)
                    
                } else {
                    operationsTracker.text = String((operationsTracker.text?.dropLast(calculator.result.count - 1 ))!)
                    
                }
                number = "0.0"
                
            } else if isTyping && !negativeNumberEvaluator {
                operationsTracker.text = String((operationsTracker.text?.dropLast(number.count))!)
                if !operatorExists {
                    number = "0.0"
                }
                
            } else  {
                calculator.undo()
                operatorExists = false
                operationsTracker.text = String((operationsTracker.text?.dropLast(3))!)
                
            }
            isClearAll.toggle()
            
        } else {
            number = ""
            operationsTracker.text = ""
            finishedCalculating = false
            resultLabel.text = ""
            calculator.clearHistory()
            operatorExists = false
            
        }
        
        numberExists = false
        isTyping.toggle()
        
    }
}
