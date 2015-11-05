//
//  UIColor_rgb.swift
//  HoboApp
//
//  Created by WLD_MBP_20 on 04/11/2015.
//  Copyright (c) 2015 probert. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(rgbString:String) {
        
        let arr:Array = rgbString.componentsSeparatedByString(",")
        let isRGB:Bool = arr.count == 4 // need 4 values for RGB & A
        
        if isRGB {
            
            let r:Float = (arr[0] as NSString).floatValue
            let g:Float = (arr[1] as NSString).floatValue
            let b:Float = (arr[2] as NSString).floatValue
            let a:Float = (arr[3] as NSString).floatValue
            
            self.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
            
        }else{
            
            self.init(red: 0, green: 0, blue: 0, alpha: 1) // black
        }
    }
}

