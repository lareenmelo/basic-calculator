//
//  basic_calculator_tests.swift
//  basic-calculator-tests
//
//  Created by Lareen Melo on 7/20/19.
//  Copyright © 2019 Lareen Melo. All rights reserved.
//

import XCTest


class basic_calculator_tests: XCTestCase {
    private var calculator: Calculator!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculator = Calculator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
