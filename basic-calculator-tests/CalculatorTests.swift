//
//  CalculatorTests.swift
//  basic-calculator-tests
//
//  Created by Admin on 7/24/19.
//  Copyright © 2019 Lareen Melo. All rights reserved.
//

import XCTest

class CalculatorTests: XCTestCase {
    private var calculator: Calculator!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculator = Calculator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        calculator.clearHistory()
    }
    
    func testClearOrUndo() {
        
        // Undo
        calculator.setOperand(operand: 5.5)
        calculator.performOperation(symbol: "+")
        calculator.undo()
        calculator.performOperation(symbol: "-")
        calculator.setOperand(operand: 0.5)
        calculator.performOperation(symbol: "=")

        XCTAssert(calculator.result == "5")
        
        // Clear All
        calculator.clearHistory()
        XCTAssert(calculator.result == "0")

    }

    
    func testPerformOperationFromScratch() {
        // Simple, single operation
        calculator.setOperand(operand: 25.0)
        calculator.performOperation(symbol: "+")
        calculator.setOperand(operand: 5.0)
        calculator.performOperation(symbol: "=")

        XCTAssert(calculator.result == "30")
        
        // With really big numbers
        calculator.setOperand(operand: 234567898765436789435678905.0)
        calculator.performOperation(symbol: "+")
        calculator.setOperand(operand: 23456785.0)
        calculator.performOperation(symbol: "=")
        
        XCTAssert(calculator.result == "2.345678987654368e+26")
        
        // Undefined, indeterminate numbers
        calculator.setOperand(operand: 0)
        calculator.performOperation(symbol: "÷")
        calculator.setOperand(operand: 0)
        calculator.performOperation(symbol: "=")

        XCTAssert(calculator.result == "nan")



    }
    
    func testPerformOperation() {
        XCTAssertEqual(calculator.result, "0")
        
        // Continuous operations
        calculator.setOperand(operand: 4.5)
        calculator.performOperation(symbol: "-")
        calculator.setOperand(operand: 2)
        calculator.performOperation(symbol: "+")
        calculator.setOperand(operand: 7.5)
        calculator.performOperation(symbol: "=")
        calculator.performOperation(symbol: "+")
        calculator.setOperand(operand: 5)
        calculator.performOperation(symbol: "=")

        XCTAssert(calculator.result == "15")
        
    }
    
    
    func testUnaryOperations() {
        // Changing the sign various times
        calculator.setOperand(operand: 4.0)
        calculator.performOperation(symbol: "+/-")
        XCTAssert(calculator.result == "-4")
        calculator.performOperation(symbol: "+/-")
        XCTAssert(calculator.result == "4")
        calculator.performOperation(symbol: "+/-")
        XCTAssert(calculator.result == "-4")

        calculator.clearHistory()

        // Testing it with 0s
        calculator.setOperand(operand: 0.0)
        calculator.performOperation(symbol: "+/-")
        XCTAssertTrue(calculator.result == "0", "performOperation: operation cannot be calculated")

        // Normal operation with a negative number
        calculator.setOperand(operand: 16.0)
        calculator.performOperation(symbol: "+/-")
        calculator.performOperation(symbol: "+")
        calculator.setOperand(operand: 6)
        calculator.performOperation(symbol: "=")
        
        XCTAssert(calculator.result == "-10")
        
    }

}
