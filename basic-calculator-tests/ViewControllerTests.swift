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
    }
    
    
    func testTest() {
        XCTAssertEqual(viewController.operationsTracker.text, "")
    }
}
