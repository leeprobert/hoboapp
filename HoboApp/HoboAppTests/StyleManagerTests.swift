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
    
    func testGetTitleTextAttributesForComponentReturnsDictionary() {
        
        if let _:[String : AnyObject] = StyleManager.sharedInstance.getTitleTextAttributesForComponent("UINavigationBar", state: UIControlState.Normal) {
            
            XCTAssert(true, "getTitleTextAttributesForComponent returns a Dictionary of the correct type")
            
        }else{
            
            XCTFail("getTitleTextAttributesForComponent failed to return a dictionary")
        }
    }
    
    func testGetFontForStyleKeyReturnsDefaultFont() {
        
        let f:UIFont = StyleManager.sharedInstance.getFontForStyleKey("")
        let fontIsArialMT:Bool = f.familyName == "Arial"
        let fontSizeIs18p:Bool = f.pointSize == 18.0
        
        if  fontIsArialMT && fontSizeIs18p{
            
            XCTAssert(true, "getFontForStyleKey returns a Font (ArialMT 18pt)")
            
        }else{
            
            XCTFail("getFontForStyleKey failed to return the default font")
        }
    }
    
    func testGetColourForStyleKeyReturnsDefaultBlack() {
        
        let c:UIColor = StyleManager.sharedInstance.getColourForStyleKey("")
        
        if  c === UIColor.blackColor(){
            
            XCTAssert(true, "getColourForStyleKey returns a default Black")
            
        }else{
            
            XCTFail("getColourForStyleKey failed to return the default Black")
        }
    }
    
    func testGetImageForStyleKeyReturnsDefaultEmptyImage() {
        
        if  let _:UIImage = StyleManager.sharedInstance.getImageForStyleKey(""){
            
            XCTAssert(true, "getImageForStyleKey returns an empty image instance")
            
        }else{
            
            XCTFail("getImageForStyleKey failed to return an empty image instance")
        }
    }
    
    func testGetMetricForKeyReturnsZeroForIncorrectKey() {
        
        if StyleManager.sharedInstance.getMetricForKey("") == 0.0 {
            
            XCTAssert(true, "getMetricForStyleKey returns zero for incorrect key")
            
        }else{
            
            XCTFail("getMetricForStyleKey failed to return zero for incorrect key")
        }
    }
    
    func testGetConfigForKeyReturnsFalseForIncorrectKey() {
        
        XCTAssert(!StyleManager.sharedInstance.getConfigForKey(""), "getMetricForConfigKey returns false for incorrect key")
    }
    
    func testUIColorExtensionReturnsColorFromHexString() {
        
        // test equality for red as testing black is in a different colour space
        let a:UIColor = UIColor(hexString: "#ff0000")
        let b:UIColor = UIColor.redColor()
        
        XCTAssert(a.description == b.description, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
