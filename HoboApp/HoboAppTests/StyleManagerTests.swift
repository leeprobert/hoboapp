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
    
    func testColorDataKeys(){
        
        StyleManager.sharedInstance.loadStyles()
        if let data:[String : AnyObject]? = StyleManager.sharedInstance.getStyleData() {
            if let colors:[String : AnyObject]? = data!["colors"] as? [String : AnyObject] {
                
                if (colors != nil) {
                    XCTAssert(colors!["primaryBrandColor"] != nil, "Pass")
                    XCTAssert(colors!["secondaryBrandColor"] != nil, "Pass")
                    XCTAssert(colors!["tertiaryBrandColor"] != nil, "Pass")
                }else{
                    XCTFail()
                }
                
            }else{
                XCTFail()
            }
        }else{
            XCTFail()
        }
    }
    
    func testFontsDataKeys(){
        
        StyleManager.sharedInstance.loadStyles()
        if let data:[String : AnyObject]? = StyleManager.sharedInstance.getStyleData() {
            if let fonts:[String : AnyObject]? = data!["fonts"] as? [String : AnyObject] {
                
                if (fonts != nil) {
                    XCTAssert(fonts!["default"] != nil, "Pass")
                    XCTAssert(fonts!["defaultBold"] != nil, "Pass")
                    XCTAssert(fonts!["mainFont8"] != nil, "Pass")
                    XCTAssert(fonts!["mainFont10"] != nil, "Pass")
                    XCTAssert(fonts!["mainFont12"] != nil, "Pass")
                    XCTAssert(fonts!["mainFont14"] != nil, "Pass")
                    XCTAssert(fonts!["mainFont16"] != nil, "Pass")
                    XCTAssert(fonts!["mainFont18"] != nil, "Pass")
                    XCTAssert(fonts!["mainBoldFont8"] != nil, "Pass")
                    XCTAssert(fonts!["mainBoldFont10"] != nil, "Pass")
                    XCTAssert(fonts!["mainBoldFont12"] != nil, "Pass")
                    XCTAssert(fonts!["mainBoldFont14"] != nil, "Pass")
                    XCTAssert(fonts!["mainBoldFont16"] != nil, "Pass")
                    XCTAssert(fonts!["mainBoldFont18"] != nil, "Pass")
                }else{
                    XCTFail()
                }
                
            }else{
                XCTFail()
            }
        }else{
            XCTFail()
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
        
        // test equality for red, green & blue as testing black is in a different colour space
        var a:UIColor = UIColor(hexString: "#ff0000")
        var b:UIColor = UIColor.redColor()
        
        XCTAssert(a.description == b.description, "Pass")
        
        a = UIColor(hexString: "#00ff00")
        b = UIColor.greenColor()
        
        XCTAssert(a.description == b.description, "Pass")
        
        a = UIColor(hexString: "#0000ff")
        b = UIColor.blueColor()
        
        XCTAssert(a.description == b.description, "Pass")
    }
    
    func testUIColorExtensionReturnsColorFromRGBString() {
        
        // test equality for red, green & blue as testing black is in a different colour space
        var a:UIColor = UIColor(rgbString: "255,0,0,1")
        var b:UIColor = UIColor.redColor()
        
        XCTAssert(a.description == b.description, "Pass")
        
        a = UIColor(rgbString: "0,255,0,1")
        b = UIColor.greenColor()
        
        XCTAssert(a.description == b.description, "Pass")
        
        a = UIColor(rgbString: "0,0,255,1")
        b = UIColor.blueColor()
        
        XCTAssert(a.description == b.description, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
