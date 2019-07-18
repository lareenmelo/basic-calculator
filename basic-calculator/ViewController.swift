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
    
    var calculator = Calculator()
    
    var number = ""
    var isTyping = false
    var numberExists = false
    var operatorExists = false
    var finishedCalculating = false
    var negativeNumberEvaluator = false
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
            operationsTracker.text = calculator.result
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
        
        
        if operatorExists {
            print("performOperation: cannot perform recursive operations.")
            
        } else {
            calculator.performOperation(symbol: operation.text!)
            
            operatorExists = true
            
            if operation.text != "=" && operation.text != "+/-" {
                if operation.text == "÷" {
                    operationsTracker.text! += " / "
                    
                } else {
                    operationsTracker.text! += " \(operation.text!) "
                    
                }
                
                isTyping = false
                resultLabel.text = calculator.result
                
            } else if operation.text == "+/-" {
                negativeNumberEvaluator = true
                if numberExists {
                    if Double(calculator.result) ?? 0.0 < 0.0 {
                        operationsTracker.text = String((operationsTracker.text?.dropLast(calculator.result.count - 1))!)
                        operationsTracker.text! += ("(\(calculator.result))")
                        
                    } else {
                        operationsTracker.text = String((operationsTracker.text?.dropLast(calculator.result.count + 3))!)
                        operationsTracker.text! += calculator.result
                        
                    }
                    
                    number = calculator.result
                    
                } else {
                    print("You have to type a number first to perform this operation.")
                }
            } else {
                
                negativeNumberEvaluator.toggle()
                finishedCalculating.toggle()
                
                if !isClearAll {
                    isClearAll.toggle()
                }
                
                isTyping = false
                resultLabel.text = calculator.result
                operatorExists = false
                
            }
            
        }
        numberExists = false
        
        
    }
    
    @IBAction func touchDigit(_ sender: Any) {
        if isClearAll {
            isClearAll.toggle()
        }
        
        guard let buttonContent = (sender as! UIButton).titleLabel else {
            return
        }
        
        if finishedCalculating {
            operationsTracker.text = ""
            finishedCalculating.toggle()
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
                    operationsTracker.text = String((operationsTracker.text?.dropLast(calculator.result.count + 2))!)
                    
                } else {
                    operationsTracker.text = String((operationsTracker.text?.dropLast(calculator.result.count))!)
                    
                }
                
                number = "0"
                
                
            } else if isTyping && !negativeNumberEvaluator {
                operationsTracker.text = String((operationsTracker.text?.dropLast(number.count))!)
                
                number = "0"
                
            } else  {
                calculator.undo()
                operatorExists = false
                operationsTracker.text = String((operationsTracker.text?.dropLast(3))!)
            }
            
            if operationsTracker.text == "" {
                if !isClearAll {
                    isClearAll.toggle()
                }
            }
            
            isTyping = false
            numberExists.toggle()
            
        } else {
            number = ""
            operationsTracker.text = ""
            finishedCalculating = false
            resultLabel.text = ""
            calculator.clearHistory()
            operatorExists = false
            isTyping = false
            
            numberExists = false
        }
    }
}
