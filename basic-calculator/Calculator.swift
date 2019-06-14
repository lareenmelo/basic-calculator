//
//  Calculator.swift
//  basic-calculator
//
//  Created by Lareen Melo on 6/3/19.
//  Copyright © 2019 Lareen Melo. All rights reserved.
//


// TODO: Show only the final result
import Foundation

class Calculator {
    private var accumulator = 0.0
    private var process: [Any] = []
    
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    enum Operation {
        case Unary((Double) -> Double)
        case Binary((Double, Double) -> Double)
        case Equals
    }
    
    private struct BinaryOperation {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var pending: BinaryOperation?
    
    func completeBinaryOperation() {
        if pending != nil {
            accumulator = pending?.binaryFunction(pending?.firstOperand ?? accumulator, accumulator) ?? accumulator
            pending = nil
        }
    }
    
    var operations: [String : Operation] = [
        "+" : Operation.Binary({$0 + $1}),
        "-" : Operation.Binary({$0 - $1}),
        "÷" : Operation.Binary({$0 / $1}),
        "x" : Operation.Binary({$0 * $1}),
        "%" : Operation.Binary({$0.truncatingRemainder(dividingBy: $1)}),
        "+/-" : Operation.Unary({$0 * -1}),
        "=" : Operation.Equals
    ]
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            
            switch operation {
            case .Binary(let function):
                completeBinaryOperation()
                pending = BinaryOperation(binaryFunction: function, firstOperand: accumulator)
                process.append(accumulator)
                
            case .Unary(let function):
                accumulator = function(accumulator)
                
            case .Equals:
                completeBinaryOperation()
            }
        }
    }
    
    func undo() {
        if pending != nil {
            pending = nil
        }
    }
    
    func clearHistory() {
        accumulator = 0.0
        pending = nil
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}
