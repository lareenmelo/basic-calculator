//
//  basic_calculator_uitests.swift
//  basic-calculator-uitests
//
//  Created by Lareen Melo on 7/31/19.
//  Copyright © 2019 Lareen Melo. All rights reserved.
//

import XCTest

class basic_calculator_uitests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app.launch()

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCalculation() {
        
        let firstNumberButton = app.buttons["2"]
        let operationButton = app.buttons["+"]
        let secondNumberButton = app.buttons["8"]
        let secondOperationButton = app.buttons["="]

        
        XCTAssert(firstNumberButton.exists)
        XCTAssert(operationButton.exists)
        XCTAssert(secondNumberButton.exists)
        XCTAssert(secondOperationButton.exists)

        firstNumberButton.tap()
        operationButton.tap()
        secondNumberButton.tap()
        secondOperationButton.tap()

        
        let label = app.staticTexts["2 + 8"]
        let resultLabel = app.staticTexts["10"]
        
        XCTAssert(label.exists)
        XCTAssert(resultLabel.exists)
        
    }

    func undo() {
        let clearAllButton = app.buttons["C"]
        XCTAssert(clearAllButton.exists)

    }

    func clearAll() {
        let clearAllButton = app.buttons["AC"]
        XCTAssert(clearAllButton.exists)

    }

}
