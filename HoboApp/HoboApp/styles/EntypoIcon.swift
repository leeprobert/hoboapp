//
//  EntypoIcon.swift
//  HoboApp
//
//  Created by WLD_MBP_20 on 09/11/2015.
//  Copyright © 2015 probert. All rights reserved.
//

import Foundation
import UIKit

class EntypoIcon: NSObject {
    
    static var entypoSocialFont:UIFont?
    static var entypoFont:UIFont?
    static var iconType:EntypoIconType?
    static let defaultFontSize:CGFloat = 48.0
    
    // MARK: Initializer
    
    override init() {
        
        super.init()
    }
    
    // MARK: Static ------------------------------
    
    class func fontForEntypoIcon(isSocialFont:Bool = false, fontSize:CGFloat = 48.0) throws -> UIFont {
        
        // returns UIFont for either Entypo or EntypoSocial font
        let font:UIFont? = isSocialFont == true ? UIFont(name: "EntypoSocial", size: fontSize) : UIFont(name: "Entypo", size: fontSize)
        
        if font != nil {
            
            return font!
            
        }else{
            
            throw EntypoIconError.FontNameNotFoundError(msg: "The Font name was not found so a Font was not created")
        }
    }
    
    class func StringFromIconType(type:EntypoIconType!, isSocialIcon:Bool = false) -> String {
        
        // returns an Entypo String for an icon. Requires that the container uses the Entypo font
        let str:String = String(UnicodeScalar(type.rawValue))
        return str
    }
    
    class func labelFromIconType(type:EntypoIconType!, isSocialIcon:Bool = false) -> UILabel {
        
        // returns UILabel without a frame set but with an Entypo font and string
        let str:String = String(UnicodeScalar(type.rawValue))
        let label:UILabel = UILabel()
        let font:UIFont = try! EntypoIcon.fontForEntypoIcon(isSocialIcon)
        
        label.font = font
        label.text = str
        
        return UILabel()
    }
    
    class func tabBarIconImageFromIconType(type:EntypoIconType!, isSocialIcon:Bool = false) -> UIImage {
        
        // returns UIImage at the correct size for use as a tab bar icon
        return EntypoIcon.imageFromIconType(type, isSocialIcon: isSocialIcon, dimensions: (44,44), fontSize: 32.0)
    }
    
    class func imageFromIconType(type:EntypoIconType!, isSocialIcon:Bool = false, dimensions:(w:CGFloat,h:CGFloat), fontSize:CGFloat = 48.0, labelColor: UIColor = UIColor.blackColor()) -> UIImage {
        
        // returns UIImage at the correct size for use as a tab bar icon
        
        let rect:CGRect = CGRectMake(0.0, 0.0, dimensions.w, dimensions.h)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        let label:UILabel = EntypoIcon.labelFromIconType(type, isSocialIcon: isSocialIcon)
        label.font = try! EntypoIcon.fontForEntypoIcon(isSocialIcon, fontSize: fontSize)
        label.textColor = labelColor
        label.textAlignment = NSTextAlignment.Center
        let layer:CALayer = label.layer
        layer.renderInContext(context)
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
}

    
    // MARK: Error Handlling -------------------
    
    enum EntypoIconError: ErrorType {
        
        case FontNameNotFoundError(msg:String)
        
    }
    
    // MARK: EntypoIconType enum ---------------
    
    enum EntypoIconType: UInt32 {
        
        case EntypoIconTypePhone = 0x1f4de
        case EntypoIconTypeMobile = 0x1f4f1
        case EntypoIconTypeMouse = 0xe789
        case EntypoIconTypeAddress = 0xe723
        case EntypoIconTypeMail = 0x2709
        case EntypoIconTypePaperPlane = 0x1f53f
        case EntypoIconTypePencil = 0x270e
        case EntypoIconTypeFeather = 0x2712
        case EntypoIconTypeAttach = 0x1F4CE
        case EntypoIconTypeInbox = 0xE777
        case EntypoIconTypeReply = 0xE712
        case EntypoIconTypereplyAll = 0xE713
        case EntypoIconTypeForward = 0x27A6
        case EntypoIconTypeUser = 0x1F464
        case EntypoIconTypeUsers = 0x1F465
        case EntypoIconTypeAddUser = 0xE700
        case EntypoIconTypeVCard = 0xE722
        case EntypoIconTypeExport = 0xE715
        case EntypoIconTypeLocation = 0xE724
        case EntypoIconTypeMap = 0xE727
        case EntypoIconTypeCompass = 0xE728
        case EntypoIconTypeDirection = 0x27A2
        case EntypoIconTypeHaircross = 0x1F3AF
        case EntypoIconTypeShare = 0xE73C
        case EntypoIconTypeShareable = 0xE73E
        case EntypoIconTypeHeart = 0x2665
        case EntypoIconTypeHeartEmpty = 0x2661
        case EntypoIconTypeStar = 0x2605
        case EntypoIconTypeStarEmpty = 0x2606
        case EntypoIconTypeThumbsUp = 0x1F44D
        case EntypoIconTypeThumbsDown = 0x1F44E
        case EntypoIconTypeChat = 0xE720
        case EntypoIconTypeComment = 0xE718
        case EntypoIconTypeQuote = 0x275E
        case EntypoIconTypeHome = 0x2302
        case EntypoIconTypePopup = 0xE74C
        case EntypoIconTypeSearch = 0x1F50D
        case EntypoIconTypeFlashlight = 0x1F526
        case EntypoIconTypePrint = 0xE716
        case EntypoIconTypeBell = 0x1F514
        case EntypoIconTypeLink = 0x1F517
        case EntypoIconTypeFlag = 0x2691
        case EntypoIconTypeCog = 0x2699
        case EntypoIconTypeTools = 0x2692
        case EntypoIconTypeTrophy = 0x1F3C6
        case EntypoIconTypeTag = 0xE70C
        case EntypoIconTypeCamera = 0x1F4F7
        case EntypoIconTypeMegaphone = 0x1F4E3
        case EntypoIconTypeMoon = 0x263D
        case EntypoIconTypePalette = 0x1F3A8
        case EntypoIconTypeLeaf = 0x1F342
        case EntypoIconTypeNote = 0x266A
        case EntypoIconTypeBeamedNote = 0x266B
        case EntypoIconTypeNew = 0x1F4A5
        case EntypoIconTypeGraduationCap = 0x1F393
        case EntypoIconTypeBook = 0x1F4D5
        case EntypoIconTypeNewspaper = 0x1F4F0
        case EntypoIconTypeBag = 0x1F45C
        case EntypoIconTypeAirplane = 0x2708
        case EntypoIconTypeLifebuoy = 0xE788
        case EntypoIconTypeEye = 0xE70A
        case EntypoIconTypeClock = 0x1F554
        case EntypoIconTypeMic = 0x1F3A4
        case EntypoIconTypeCalendar = 0x1F4C5
        case EntypoIconTypeFlash = 0x26A1
        case EntypoIconTypeThunderCloud = 0x26C8
        case EntypoIconTypeDroplet = 0x1F4A7
        case EntypoIconTypeCD = 0x1F4BF
        case EntypoIconTypeBriefcase = 0x1F4BC
        case EntypoIconTypeAir = 0x1F4A8
        case EntypoIconTypeHourglass = 0x23F3
        case EntypoIconTypeGauge = 0x1F6C7
        case EntypoIconTypeLanguage = 0x1F394
        case EntypoIconTypeNetwork = 0xE776
        case EntypoIconTypeKey = 0x1F511
        case EntypoIconTypeBattery = 0x1F50B
        case EntypoIconTypeBucket = 0x1F4FE
        case EntypoIconTypeMagnet = 0xE7A1
        case EntypoIconTypeDrive = 0x1F4FD
        case EntypoIconTypeCup = 0x2615
        case EntypoIconTypeRocket = 0x1F680
        case EntypoIconTypeBrush = 0xE79A
        case EntypoIconTypeSuitcase = 0x1F6C6
        case EntypoIconTypeTrafficCone = 0x1F6C8
        case EntypoIconTypeGlobe = 0x1F30E
        case EntypoIconTypeKeyboard = 0x2328
        case EntypoIconTypeBrowser = 0xE74E
        case EntypoIconTypePublish = 0xE74D
        case EntypoIconTypeProgress3 = 0xE76B
        case EntypoIconTypeProgress2 = 0xE76A
        case EntypoIconTypeProgress1 = 0xE769
        case EntypoIconTypeProgress0 = 0xE768
        case EntypoIconTypeLightDown = 0x1F505
        case EntypoIconTypeLightUp = 0x1F506
        case EntypoIconTypeAdjust = 0x25D1
        case EntypoIconTypeCode = 0xE714
        case EntypoIconTypeMonitor = 0x1F4BB
        case EntypoIconTypeInfinity = 0x221E
        case EntypoIconTypeLightBulb = 0x1F4A1
        case EntypoIconTypeCreditCard = 0x1F4B3
        case EntypoIconTypeDatabase = 0x1F4F8
        case EntypoIconTypeVoicemail = 0x2707
        case EntypoIconTypeClipboard = 0x1F4CB
        case EntypoIconTypeCart = 0xE73D
        case EntypoIconTypeBox = 0x1F4E6
        case EntypoIconTypeTicket = 0x1F3AB
        case EntypoIconTypeRSS = 0xE73A
        case EntypoIconTypeSignal = 0x1F4F6
        case EntypoIconTypeThermometer = 0x1F4FF
        case EntypoIconTypeWater = 0x1F4A6
        case EntypoIconTypeSweden = 0xF601
        case EntypoIconTypeLineGraph = 0x1F4C8
        case EntypoIconTypePieChart = 0x25F4
        case EntypoIconTypeBarGraph = 0x1F4CA
        case EntypoIconTypeAreaGraph = 0x1F53E
        case EntypoIconTypeLock = 0x1F512
        case EntypoIconTypeLockOpen = 0x1F513
        case EntypoIconTypeLogout = 0xE741
        case EntypoIconTypeLogin = 0xE740
        case EntypoIconTypeCheck = 0x2713
        case EntypoIconTypeCross = 0x274C
        case EntypoIconTypeSquaredMinus = 0x229F
        case EntypoIconTypeSquaredPlus = 0x229E
        case EntypoIconTypeSquaredCross = 0x274E
        case EntypoIconTypeCircledMinus = 0x2296
        case EntypoIconTypeCircledPlus = 0x2295
        case EntypoIconTypeCircledCross = 0x2716
        case EntypoIconTypeMinus = 0x2796
        case EntypoIconTypePlus = 0x2795
        case EntypoIconTypeErase = 0x232B
        case EntypoIconTypeBlock = 0x1F6AB
        case EntypoIconTypeInfo = 0x2139
        case EntypoIconTypeCircledInfo = 0xE705
        case EntypoIconTypeHelp = 0x2753
        case EntypoIconTypeCircledHelp = 0xE704
        case EntypoIconTypeWarning = 0x26A0
        case EntypoIconTypeCycle = 0x1F504
        case EntypoIconTypeCW = 0x27F3
        case EntypoIconTypeCCW = 0x27F2
        case EntypoIconTypeShuffle = 0x1F500
        case EntypoIconTypeBack = 0x1F519
        case EntypoIconTypeLevelDown = 0x21B3
        case EntypoIconTypeRetweet = 0xE717
        case EntypoIconTypeLoop = 0x1F501
        case EntypoIconTypeBackInTime = 0xE771
        case EntypoIconTypeLevelUp = 0x21B0
        case EntypoIconTypeSwitch = 0x21C6
        case EntypoIconTypeNumberedList = 0xE005
        case EntypoIconTypeAddtoList = 0xE003
        case EntypoIconTypeLayout = 0x268F
        case EntypoIconTypeList = 0x2630
        case EntypoIconTypeTextDoc = 0x1F4C4
        case EntypoIconTypeTextDocInverted = 0xE731
        case EntypoIconTypeDoc = 0xE730
        case EntypoIconTypeDocs = 0xE736
        case EntypoIconTypeLandscapeDoc = 0xE737
        case EntypoIconTypePicture = 0x1F304
        case EntypoIconTypeVideo = 0x1F3AC
        case EntypoIconTypeMusic = 0x1F3B5
        case EntypoIconTypeFolder = 0x1F4C1
        case EntypoIconTypeArchive = 0xE800
        case EntypoIconTypeTrash = 0xE729
        case EntypoIconTypeUpload = 0x1F4E4
        case EntypoIconTypeDownload = 0x1F4E5
        case EntypoIconTypeSave = 0x1F4BE
        case EntypoIconTypeInstall = 0xE778
        case EntypoIconTypeCloud = 0x2601
        case EntypoIconTypeUploadCloud = 0xE711
        case EntypoIconTypeBookmark = 0x1F516
        case EntypoIconTypeBookmarks = 0x1F4D1
        case EntypoIconTypeOpenBook = 0x1F4D6
        case EntypoIconTypePlay = 0x25B6
        case EntypoIconTypePause = 0x2016
        case EntypoIconTypeRecord = 0x25CF
        case EntypoIconTypeStop = 0x25A0
        case EntypoIconTypeFF = 0x23E9
        case EntypoIconTypeFB = 0x23EA
        case EntypoIconTypeToStart = 0x23EE
        case EntypoIconTypeToEnd = 0x23ED
        case EntypoIconTypeResizeFull = 0xE744
        case EntypoIconTypeResizeSmall = 0xE746
        case EntypoIconTypeVolume = 0x23F7
        case EntypoIconTypeSound = 0x1F50A
        case EntypoIconTypeMute = 0x1F507
        case EntypoIconTypeFlowCascade = 0x1F568
        case EntypoIconTypeFlowBranch = 0x1F569
        case EntypoIconTypeFlowTree = 0x1F56A
        case EntypoIconTypeFlowLine = 0x1F56B
        case EntypoIconTypeFlowParallel = 0x1F56C
        case EntypoIconTypeLeftBold = 0xE4AD
        case EntypoIconTypeDownBold = 0xE4B0
        case EntypoIconTypeUpBold = 0xE4AF
        case EntypoIconTypeRightBold = 0xE4AE
        case EntypoIconTypeLeft = 0x2B05
        case EntypoIconTypeDown = 0x2B07
        case EntypoIconTypeUp = 0x2B06
        case EntypoIconTypeRight = 0x27A1
        case EntypoIconTypeCircledLeft = 0xE759
        case EntypoIconTypeCircledDown = 0xE758
        case EntypoIconTypeCircledUp = 0xE75B
        case EntypoIconTypeCircledRight = 0xE75A
        case EntypoIconTypeTriangleLeft = 0x25C2
        case EntypoIconTypeTriangleDown = 0x25BE
        case EntypoIconTypeTriangleUp = 0x25B4
        case EntypoIconTypeTriangleRight = 0x25B8
        case EntypoIconTypeChevronLeft = 0xE75D
        case EntypoIconTypeChevronDown = 0xE75C
        case EntypoIconTypeChevronUp = 0xE75F
        case EntypoIconTypeChevronRight = 0xE75E
        case EntypoIconTypeChevronSmallLeft = 0xE761
        case EntypoIconTypeChevronSmallDown = 0xE760
        case EntypoIconTypeChevronSmallUp = 0xE763
        case EntypoIconTypeChevronSmallRight = 0xE762
        case EntypoIconTypeChevronThinLeft = 0xE765
        case EntypoIconTypeChevronThinDown = 0xE764
        case EntypoIconTypeChevronThinUp = 0xE767
        case EntypoIconTypeChevronThinRight = 0xE766
        case EntypoIconTypeLeftThin = 0x2190
        case EntypoIconTypeDownThin = 0x2193
        case EntypoIconTypeUpThin = 0x2191
        case EntypoIconTypeRightThin = 0x2192
        case EntypoIconTypeArrowCombo = 0xE74F
        case EntypoIconTypeThreeDots = 0x23F6
        case EntypoIconTypeTwoDots = 0x23F5
        case EntypoIconTypeDot = 0x23F4
        case EntypoIconTypeCC = 0x1F545
        case EntypoIconTypeCCBY = 0x1F546
        case EntypoIconTypeCCNC = 0x1F547
        case EntypoIconTypeCCNCEU = 0x1F548
        case EntypoIconTypeCCNCJP = 0x1F549
        case EntypoIconTypeCCSA = 0x1F54A
        case EntypoIconTypeCCND = 0x1F54B
        case EntypoIconTypeCCPD = 0x1F54C
        case EntypoIconTypeCCZero = 0x1F54D
        case EntypoIconTypeCCShare = 0x1F54E
        case EntypoIconTypeCCremix = 0x1F54F
        case EntypoIconTypeDBLogo = 0x1F5F9
        case EntypoIconTypeDBShape = 0x1F5FA
        
        case EntypoIconSocialTypeGithub = 0xF300
        case EntypoIconSocialTypeCGithub = 0xF301
        case EntypoIconSocialTypeFlickr = 0xF303
        case EntypoIconSocialTypeCFlickr = 0xF304
        case EntypoIconSocialTypeVimeo = 0xF306
        case EntypoIconSocialTypeCVimeo = 0xF307
        case EntypoIconSocialTypeTwitter = 0xF309
        case EntypoIconSocialTypeCTwitter = 0xF30A
        case EntypoIconSocialTypeFacebook = 0xF30C
        case EntypoIconSocialTypeCFacebook = 0xF30D
        case EntypoIconSocialTypeSFacebook = 0xF30E
        case EntypoIconSocialTypeGooglePlus = 0xF30F
        case EntypoIconSocialTypeCGooglePlus = 0xF310
        case EntypoIconSocialTypePinterest = 0xF312
        case EntypoIconSocialTypeCPinterest = 0xF313
        case EntypoIconSocialTypeTumblr = 0xF315
        case EntypoIconSocialTypeCtumblr = 0xF316
        case EntypoIconSocialTypeLinkedIn = 0xF318
        case EntypoIconSocialTypeClinkedIn = 0xF319
        case EntypoIconSocialTypeDribbble = 0xF31B
        case EntypoIconSocialTypeCDribbble = 0xF31C
        case EntypoIconSocialTypeStumbleupon = 0xF31E
        case EntypoIconSocialTypeCStumbleupon = 0xF31F
        case EntypoIconSocialTypeLastFM = 0xF321
        case EntypoIconSocialTypeCLastFM = 0xF322
        case EntypoIconSocialTypeRdio = 0xF324
        case EntypoIconSocialTypeCRdio = 0xF325
        case EntypoIconSocialTypeSpotify = 0xF327
        case EntypoIconSocialTypeCSpotify = 0xF328
        case EntypoIconSocialTypeQQ = 0xF32A
        case EntypoIconSocialTypeInstagram = 0xF32D
        case EntypoIconSocialTypeDropBox = 0xF330
        case EntypoIconSocialTypeEvernote = 0xF333
        case EntypoIconSocialTypeFlattr = 0xF336
        case EntypoIconSocialTypeSkype = 0xF339
        case EntypoIconSocialTypeCSkype = 0xF33A
        case EntypoIconSocialTypeRenren = 0xF33C
        case EntypoIconSocialTypeSinaWeibo = 0xF33F
        case EntypoIconSocialTypePayPal = 0xF342
        case EntypoIconSocialTypePicasa = 0xF345
        case EntypoIconSocialTypeSoundcloud = 0xF348
        case EntypoIconSocialTypeMixi = 0xF34B
        case EntypoIconSocialTypeBehance = 0xF34E
        case EntypoIconSocialTypeGoogleCircles = 0xF351
        case EntypoIconSocialTypeVK = 0xF354
        case EntypoIconSocialTypeSmashing = 0xF357
    }
