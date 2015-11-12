//
//  EntypoIconTests.swift
//  HoboApp
//
//  Created by WLD_MBP_20 on 09/11/2015.
//  Copyright © 2015 probert. All rights reserved.
//

import UIKit
import XCTest

class EntypoIconTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEntypoIconReturnsFonts() {
        
        guard let _:UIFont = try? EntypoIcon.fontForEntypoIcon(true) else {
            
            XCTFail()
            return
        }
        
        XCTAssert(true, "Pass")
    }
    
    func testStringFromIconType() {
        
        var a:String = EntypoIcon.StringFromIconType(EntypoIconType.EntypoIconTypePhone, isSocialIcon: false)
        var b:String = String(UnicodeScalar(0x1f4de))
        
        XCTAssert(a==b, "Pass")
        
        a = EntypoIcon.StringFromIconType(EntypoIconType.EntypoIconTypeMobile, isSocialIcon: false)
        b = String(UnicodeScalar(0x1f4f1))
        
        XCTAssert(a==b, "Pass")
        
        a = EntypoIcon.StringFromIconType(EntypoIconType.EntypoIconTypeMouse, isSocialIcon: false)
        b = String(UnicodeScalar(0xe789))
        
        XCTAssert(a==b, "Pass")
        
        a = EntypoIcon.StringFromIconType(EntypoIconType.EntypoIconTypeAddress, isSocialIcon: false)
        b = String(UnicodeScalar(0xe723))
        
        XCTAssert(a==b, "Pass")
        
        a = EntypoIcon.StringFromIconType(EntypoIconType.EntypoIconTypeMail, isSocialIcon: false)
        b = String(UnicodeScalar(0x2709))
        
        XCTAssert(a==b, "Pass")
        
        a = EntypoIcon.StringFromIconType(EntypoIconType.EntypoIconTypePaperPlane, isSocialIcon: false)
        b = String(UnicodeScalar(0x1f53f))
        
        XCTAssert(a==b, "Pass")
        
        // TODO: loads more!
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
