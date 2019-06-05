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
    
    enum Operation {
        case Unary((Double) -> Double)
        case Binary((Double, Double) -> Double)
        case Equals
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
                print("HEAAAY")
            case .Unary(let function):
                accumulator = function(accumulator)
            case .Equals:
                // TODO: perform the rest. 
                print("WHERE MY PPL AT")
            }
        }
    }
    
    
    
    func clear() {
        // TODO: clear C
    }
    
    func clearHistory() {
        // TODO: clear A/C
    }
}
