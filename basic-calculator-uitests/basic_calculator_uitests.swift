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

    func testUndo() {
        
        let app = XCUIApplication()
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["8"].tap()
        
        let cButton = app.buttons["C"]
        cButton.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 0).tap()
        cButton.tap()
        app.buttons["AC"].tap()
        app.buttons["="].tap()
        
        let firstNumberButton = app.buttons["2"]
        let operationButton = app.buttons["+"]
        let secondNumberButton = app.buttons["8"]
        let secondOperationButton = app.buttons["="]
        let thirdNumberButton = app.buttons["3"]
        let undoButton = app.buttons["C"]
        
        XCTAssert(firstNumberButton.exists)
        XCTAssert(operationButton.exists)
        XCTAssert(secondNumberButton.exists)
        XCTAssert(secondOperationButton.exists)
        XCTAssert(thirdNumberButton.exists)
        XCTAssertFalse(undoButton.exists)

        firstNumberButton.tap()
        XCTAssert(undoButton.exists)
        operationButton.tap()
        secondNumberButton.tap()
        
        var label = app.staticTexts["2 + 8"]
        XCTAssert(label.exists)

        undoButton.tap()
        thirdNumberButton.tap()
        
        label = app.staticTexts["2 + 3"]
        XCTAssert(label.exists)

        secondOperationButton.tap()
        
        let resultLabel = app.staticTexts["5"]
        
        XCTAssert(resultLabel.exists)
    }

    func testClearAll() {
        let firstNumberButton = app.buttons["2"]
        let operationButton = app.buttons["+"]
        let secondNumberButton = app.buttons["8"]
        let secondOperationButton = app.buttons["="]
        let thirdNumberButton = app.buttons["3"]
        let thirdOperationButton = app.buttons["-"]
        let clearAllButton = app.buttons["AC"]

        XCTAssert(clearAllButton.exists)
        XCTAssert(firstNumberButton.exists)
        XCTAssert(operationButton.exists)
        XCTAssert(secondNumberButton.exists)
        XCTAssert(thirdNumberButton.exists)
        XCTAssert(thirdOperationButton.exists)
        XCTAssert(secondOperationButton.exists)

        firstNumberButton.tap()
        
        XCTAssertFalse(clearAllButton.exists)

        operationButton.tap()
        secondNumberButton.tap()
        secondOperationButton.tap()
        
        XCTAssert(clearAllButton.exists)

        var label = app.staticTexts["2 + 8"]
        var resultLabel = app.staticTexts["10"]
        
        XCTAssert(label.exists)
        XCTAssert(resultLabel.exists)
        
        clearAllButton.tap()
        
        firstNumberButton.tap()
        thirdOperationButton.tap()
        thirdNumberButton.tap()
        secondOperationButton.tap()
        
        label = app.staticTexts["2 - 3"]
        resultLabel = app.staticTexts["-1"]
        
        XCTAssert(label.exists)
        XCTAssert(resultLabel.exists)

    }

}
