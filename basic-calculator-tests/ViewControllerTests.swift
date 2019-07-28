//
//  ViewControllerTests.swift
//  basic-calculator-tests
//
//  Created by Admin on 7/24/19.
//  Copyright © 2019 Lareen Melo. All rights reserved.
//

import XCTest

class ViewControllerTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        
        let bundle = Bundle(for: ViewController.self)
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        viewController.loadView()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController.clear("AC")
    }
    
    func testResultLabel() {
        // TODO: testResultLabel()
        viewController.number = "56"
        
        viewController.performOperation("+")
//        sut.loginButton.sendActions(for: .touchUpInside)


        XCTAssert(viewController.resultLabel.text == "56")
    }
    
    func testOperationsTracker() {
        // TODO: testOperationsTracker()
    }
    
    func testUndo() {
        // TODO: testUndo()

    }
    
}
