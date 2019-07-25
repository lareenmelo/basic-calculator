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
    }

    
    func testPerformOperationFromScratch() {
        calculator.setOperand(operand: 25.0)
        calculator.performOperation(symbol: "+")
        calculator.setOperand(operand: 5.0)
        calculator.completeBinaryOperation()
        
        
        
        XCTAssert(calculator.result == "30")
        
        
    }
    
    func testPerformOperation() {
        
    }

}
