//
//  Calculator.swift
//  basic-calculator
//
//  Created by Lareen Melo on 6/3/19.
//  Copyright © 2019 Lareen Melo. All rights reserved.
//


import Foundation

class Calculator {
    private var accumulator = 0.0
    
    
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
        "+/-" : Operation.Unary({-$0}),
        "=" : Operation.Equals
    ]
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            
            switch operation {
            case .Binary(let function):
                completeBinaryOperation()
                pending = BinaryOperation(binaryFunction: function, firstOperand: accumulator)
                
            case .Unary(let function):
                if accumulator == 0.0 && symbol == "+/-" {
                    print("performOperation: operation cannot be calculated")
                } else {
                    accumulator = function(accumulator)
                    
                }
                
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
    
    func evaluateWholesomeness(number: Double) -> Bool {
        let ceilAccumulator = number
        let floorAccumulator = number
        
        return ceilAccumulator.rounded(.up) == floorAccumulator.rounded(.down)
    }
    
    var result: String {
        get {
            if evaluateWholesomeness(number: accumulator) {
                if let number = accumulator.toInt() {
                    return String(number)
                } else {
                    return String(accumulator.round(withPrecision: 8))
                }
            } else {
                return String(accumulator.round(withPrecision: 8))
            }
        }
    }
}


extension Double {
    func round(withPrecision precision: Int) -> Double {
        let divisor = pow(10.0, Double(precision))
        return (self * divisor).rounded() / divisor
    }
    
    func toInt() -> Int? {
        if self >= Double(Int.min) && self <= Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}
