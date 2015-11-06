//
//  StyleManagerTests.swift
//  HoboApp
//
//  Created by WLD_MBP_20 on 05/11/2015.
//  Copyright © 2015 probert. All rights reserved.
//

import UIKit
import XCTest

class StyleManagerTests: XCTestCase {
    
    var styleManager:StyleManager?
    
    override func setUp() {
        
        super.setUp()
        styleManager = StyleManager.sharedInstance
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testLoadedData() {
        
        XCTAssert(StyleManager.sharedInstance.loadStyles(), "Did load StyleManager data via plist")
    }
    
    func testSetAppearances() {
        
        XCTAssert(StyleManager.sharedInstance.setAppearances(), "Did set appearances on UIKit components")
    }
    
    func test() {
        
        XCTAssert(StyleManager.sharedInstance.setAppearances(), "Did set appearances on UIKit components")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
