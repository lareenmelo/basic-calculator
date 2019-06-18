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

        if ceilAccumulator.rounded(.up) == floorAccumulator.rounded(.down) {
            print("HEEEY")
            return true
        } else {
            print("WHERE MY PEOPLE AT")
            return false
        }

    }
    
    // TODO: make it a #
    var result: String {
        get {
//            return accumulator
            if evaluateWholesomeness(number: accumulator) {
                return String(Int(accumulator))
            } else {
                return String(accumulator)
            }
        }
    }
}
