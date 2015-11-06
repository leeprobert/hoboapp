//
//  StyleManager.swift
//  HoboApp
//
//  Created by WLD_MBP_20 on 04/11/2015.
//  Copyright (c) 2015 probert. All rights reserved.
//

import UIKit

class StyleManager: NSObject {
    
    static let sharedInstance = StyleManager()
    
    private let filenameKey:String = "Application styles filename"
    private let defaultFontNameKey:String = "Avenir"
    
    private var filename:String?
    private var styleData = [String : AnyObject]()
    private var colorsData = [String: AnyObject]()
    private var imagesData = [String: AnyObject]()
    private var fontsData = [String: AnyObject]()
    private var metricsData = [String: AnyObject]()
    private var configData = [String: AnyObject]()
    
    // MARK: PUBLIC ------------------------
    
    func loadStyles() -> Bool {
        
        filename = NSBundle.mainBundle().infoDictionary?[filenameKey] as? String
        
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                
                styleData = dict
                colorsData = (styleData["colors"] as? [String: AnyObject])!
                imagesData = (styleData["images"] as? [String: AnyObject])!
                fontsData = (styleData["fonts"] as? [String: AnyObject])!
                metricsData = (styleData["metrics"] as? [String: AnyObject])!
                configData = (styleData["config"] as? [String: AnyObject])!
                
                return true
                
            }else{
                print("Problem loading Styles")
                
                return false
            }
        }
        
        return false
    }
   
    func setAppearances() -> Bool {
        
        if styleData.count == 0 {
            
            return false
        }
        
        /*
            UIBarButtonItem -----------------------------------------
        */
        
        // Normal
        UIBarButtonItem.appearance().setTitleTextAttributes(getTitleTextAttributesForComponent("UIBarButtonItem", state: UIControlState.Normal), forState: UIControlState.Normal)
        UIBarButtonItem.appearance().tintColor = getColourForStyleKey("barButtonItemTintColor")
        
        /*
            UIButton -----------------------------------------------
        */
        
        UIButton.appearance().tintColor = getColourForStyleKey("buttonTintColor")
        
        /*
            UINavigationBar -----------------------------------------
        */
        
        UINavigationBar.appearance().titleTextAttributes = getTitleTextAttributesForComponent("UINavigationBar", state: UIControlState.Normal)
        UINavigationBar.appearance().barStyle = UIBarStyle.BlackTranslucent
        UINavigationBar.appearance().barTintColor = getColourForStyleKey("navigationBarBackgroundColor")
        UINavigationBar.appearance().tintColor = getColourForStyleKey("navigationBarTintColor")
        
        /*
            UITabBar -------------------------------------------------
        */
    
        UITabBar.appearance().backgroundColor = getColourForStyleKey("tabBarBackgroundColor")
        UITabBar.appearance().barTintColor = getColourForStyleKey("tabBarBarTintColor")
        UITabBar.appearance().tintColor = getColourForStyleKey("tabBarTintColor")
        
        /*
            UITabBarItem -----------------------------------------
        */
        
        UITabBarItem.appearance().setTitleTextAttributes(getTitleTextAttributesForComponent("UITabBarItem", state: UIControlState.Normal), forState:UIControlState.Normal)
        UITabBarItem.appearance().setTitleTextAttributes(getTitleTextAttributesForComponent("UITabBarItem", state: UIControlState.Selected), forState:UIControlState.Selected)
        
        /*
            UIToolbar -----------------------------------------
        */
        
        UIToolbar.appearance().backgroundColor = getColourForStyleKey("toolbarBackgroundColor")
        UIToolbar.appearance().barTintColor = getColourForStyleKey("toolbarBarTintColor")
        UIToolbar.appearance().tintColor = getColourForStyleKey("toolbarTintColor")
        
        /*
            UIPageControl -----------------------------------------
        */
        
        UIPageControl.appearance().tintColor = getColourForStyleKey("pageControlCurrentPageIndicatorTintColor")
        
        /*
            UIProgressView -----------------------------------------
        */
        
        UIProgressView.appearance().progressTintColor = getColourForStyleKey("progressViewTintColor")
        UIProgressView.appearance().trackTintColor = getColourForStyleKey("progressViewTrackTintColor")
        
        /*
            UIRefreshControl -----------------------------------------
        */
        
        UIRefreshControl.appearance().tintColor = getColourForStyleKey("refreshControlTintColor")
        
        /*
            UISearchBar -----------------------------------------
        */
        
//            UISearchBar.appearance().tintColor = getColourForStyleKey("searchBarTintColor")
        
        /*
            UISegmentedControl -----------------------------------------
        */
        
        UISegmentedControl.appearance().setTitleTextAttributes(getTitleTextAttributesForComponent("UISegmentedControl", state: UIControlState.Normal), forState:UIControlState.Normal)
        UISegmentedControl.appearance().setTitleTextAttributes(getTitleTextAttributesForComponent("UISegmentedControl", state: UIControlState.Selected), forState:UIControlState.Selected)
        
        /*
            UISlider -----------------------------------------
        */
        
        UISlider.appearance().minimumTrackTintColor = getColourForStyleKey("sliderMinTrackTintColor")
        UISlider.appearance().maximumTrackTintColor = getColourForStyleKey("sliderMaxTrackTintColor")
        UISlider.appearance().thumbTintColor = getColourForStyleKey("sliderThumbTintColor")
        
        /*
            UIStepper -----------------------------------------
        */
        
        UIStepper.appearance().tintColor = getColourForStyleKey("stepperTintColor")
        
        /*
            UISwitch -----------------------------------------
        */
        
        UISwitch.appearance().tintColor = getColourForStyleKey("switchTintColor")
        UISwitch.appearance().onTintColor = getColourForStyleKey("switchOnTintColor")
        UISwitch.appearance().thumbTintColor = getColourForStyleKey("switchThumbTintColor")
        
        /*
            UITableView -----------------------------------------
        */
        
        UITableView.appearance().sectionIndexColor = getColourForStyleKey("tableViewSectionIndexColor")
        UITableView.appearance().sectionIndexBackgroundColor = getColourForStyleKey("tableViewSectionIndexBackgroundColor")
        
        /*
            UITableViewHeaderFooterView -----------------------------------------
        */
            
        UITableViewHeaderFooterView.appearance().tintColor = getColourForStyleKey("tableViewHeaderFooterColor")
        
        return true
    }
    
    // MARK: PRIVATE ----------------------------------------------
    
    private func getTitleTextAttributesForComponent(component: String, state: UIControlState) -> [String: AnyObject] {
        
        var attrib = [String: AnyObject]()
        
        if "UIBarButtonItem" == component {
            
            if state == UIControlState.Normal {
                
                attrib = [
                    NSForegroundColorAttributeName: getColourForStyleKey("barButtonItemTextColor"),
                    NSFontAttributeName: getFontForStyleKey("mainFont10")
                ]
            }
        }else if "UINavigationBar" == component {
            
            if state == UIControlState.Normal {
                
                attrib = [
                    NSForegroundColorAttributeName: getColourForStyleKey("navigationBarTitleColor"),
                    NSFontAttributeName: getFontForStyleKey("mainFont16")
                ]
            }
        }else if "UITabBarItem" == component {
            
            if state == UIControlState.Normal {
                
                attrib = [
                    NSForegroundColorAttributeName: getColourForStyleKey("barButtonItemTextColor"),
                    NSFontAttributeName: getFontForStyleKey("mainFont16")
                ]
            }
        }else if "UISegmentedControl" == component {
            
            if state == UIControlState.Normal {
                
                attrib = [
                    NSForegroundColorAttributeName: getColourForStyleKey("barButtonItemTextColor"),
                    NSFontAttributeName: getFontForStyleKey("mainFont16")
                ]
            }
        }
        
        return attrib
    }
    
    
    // MARK: PUBLIC -------------------------------------------------
    
    func getFontForStyleKey(key: String) -> UIFont {
        
        var value:String? = fontsData[key] as? String;
        
        /*
            resolved?
        */
        if nil == value {
            
            // don't give up yet! Does the key need to be capitalised?
            value = fontsData[key.capitalizedString] as? String
            
            // still nil? Just return Arial 18pt font
            if nil == value {
                return UIFont(name: "ArialMT", size: 18.0)!
            }
        }
        
        /*
            We have a value but does the value resolve to another key?
        */
        if nil != fontsData[value!] {
            
            value = fontsData[value!] as? String
        }
        
        let properties:Array? = value!.componentsSeparatedByString(":")
        
        if properties != nil && properties?.count == 2 {
            
            var fontName:String? = properties![0]
            let fontSize:String? = properties![1]
            
            if fontName == "default" {
                
                fontName = fontsData["default"] as? String
            }
            
            if fontName == "defaultBold" {
                
                fontName = fontsData["defaultBold"]  as? String
            }
            
            let font:UIFont? = UIFont(name: fontName!, size: CGFloat(NSString(string: fontSize!).floatValue))
            return font ?? UIFont(name: "ArialMT", size: 18.0)!
        }
        
        // default Arial 18pt
        return UIFont(name: "ArialMT", size: 18.0)!
    }
    
    //-------------------------------
    
    func getColourForStyleKey(key: String) -> UIColor {
        
        var value:String? = colorsData[key] as? String;
        
        /*
            resolved?
        */
        if nil == value {
            
            // don't give up yet! Does the key need to be capitalised?
            value = colorsData[key.capitalizedString] as? String
            
            // still nil? Just return black
            if nil == value {
                return UIColor.blackColor()
            }
        }
        
        /*
            We have a value but does the value resolve to another key?
        */
        if nil != colorsData[value!] {
            
            value = colorsData[value!] as? String
        }
        
        /*
            Does the value refer to a UIColor static method?
        */
        
        let selector:Selector = Selector(value!)
        let isColorMethod:Bool = (selector != nil) ? UIColor.respondsToSelector(selector) : false
        
        if isColorMethod {
            
            // TODO: need to work out how to do this in Swift. performSelector for static methods doesn't seem to be supported.
            
            let col = UIColor.performSelector(selector).takeUnretainedValue()
            return col as! UIColor
        }
        
        /*
            value could be HEX
        */
        
        let isHex:Bool = value!.hasPrefix("#")
        
        if isHex {
            
            let hexcol:UIColor = UIColor(hexString: value!)
            return hexcol
        }
        
        /*
            value could be RGB
        */
        
        let arr:Array = value!.componentsSeparatedByString(",")
        let isRGB:Bool = arr.count == 4
        
        if isRGB {
            
            let rgbCol:UIColor = UIColor(rgbString: value!) // the extension requires the full string
            return rgbCol
        }
        
        /*
            Finally, it is possible to use an image as a texture fill
        */
        let components:Array = value!.componentsSeparatedByString(":")
        if components.count > 1 {
            
            if components[0] == "tile" {
                
                let tiledColor:UIColor = UIColor(patternImage: self.getImageForStyleKey(components[1]))
                return tiledColor;
            }
        }
        
        
        /*
            If we get this far then the colour has not been convertible so we just return black
        */
        return UIColor.blackColor()
    }
    
    //-------------------------------
    
    func getImageForStyleKey(key:String) -> UIImage {
        
        /*
            Images are set in the plist like so :
        
            image1.png:2,2,2,2:stretch
            image2.jpg:4,2,4,2:tile
        
            This is the image name, the edge insets and tile type
        */
        
        var value:String? = imagesData[key] as? String;
        
        /*
            resolved?
        */
        if nil == value {
            
            return UIImage() // empty
        }
        
        /*
            We have a value but does the value resolve to another key?
        */
        if nil != imagesData[value!] {
            
            value = imagesData[value!] as? String
        }
        
        if value!.lowercaseString == "nil" {
            
            /*
                Return empty image if you want to nullify a navBar shadow or background image
            */
            return UIImage();
        }
        
        /*
            If we have got this far the image value is either a resizable image set as a string like this "image1.png:2,2,2,2:stretch"
            or it is an icon reference like this : "icon:iconName:44:44:white" in which case the icon is drawn at the set width and height and then returned as a UIImage
            you would use this to create barButtonItem icons. The names of the icons are described in the IconSuper class and in the styling documentation.
            Or it is a view class that you wish to be converted to an image at a certain size. The syntax in this case is view:ClassName:44:44
        
            Resizable Image :   "image1.png:2,2,2,2:stretch"
            Icon :              "icon:iconName:44:44:white"     // NOT SUPPORTED YET
            View :              "view:ClassName:44:44"          // NOT SUPPORTED YET
        */
        
        let properties = value!.componentsSeparatedByString(":")
        
        if properties.count == 1 {
            
            return UIImage(named: value!) ?? UIImage()
            
        }else{
            
            let filename:String? = properties[0]
            
            if nil == filename {
                
                return UIImage()
            }
            
            let edgeInsetValues:Array = properties[1].componentsSeparatedByString(",")
            let resizingModeType:String = properties[2].capitalizedString
            let edgeInsets:UIEdgeInsets = UIEdgeInsetsMake( CGFloat(NSString(string: edgeInsetValues[0]).floatValue),
                                                            CGFloat(NSString(string: edgeInsetValues[1]).floatValue),
                                                            CGFloat(NSString(string: edgeInsetValues[2]).floatValue),
                                                            CGFloat(NSString(string: edgeInsetValues[3]).floatValue))
            
            let resizingMode:UIImageResizingMode = resizingModeType == "Tile" ? UIImageResizingMode.Tile : UIImageResizingMode.Stretch
            
            let imgA:UIImage? = UIImage(named:filename!)
            
            if nil != imgA {
                
                let imgB:UIImage? = imgA!.resizableImageWithCapInsets(edgeInsets, resizingMode: resizingMode)
                return imgB ?? UIImage();
                
            }else{
                
                return UIImage()
            }
        }
    }
    
    //-------------------------------
    
    func getMetricForKey(key: String) -> Float {
        
        return metricsData[key] as? Float ?? 0.0
    }
    
    //-------------------------------
    
    func getConfigForKey(key: String) -> Bool {
        
        return metricsData[key] as? Bool ?? false
    }
}
