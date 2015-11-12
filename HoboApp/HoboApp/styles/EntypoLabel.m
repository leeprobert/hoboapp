//
//  EntypoLabel.m
//  Engager
//
//  Created by Lee Probert on 31/05/2013.
//  Copyright (c  2013 Agnitio. All rights reserved.
//

#import "EntypoLabel.h"
#import <QuartzCore/QuartzCore.h>
@interface EntypoLabel ()

- (void) setDefaultFontsAndColor;

@end

@implementation EntypoLabel

- (id) initWithFrame:(CGRect) frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setDefaultFontsAndColor];
    }
    return self;
}

- (id) initWithFrame:(CGRect) frame iconType:(EntypoIconType) type {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setDefaultFontsAndColor];
        [self setIconFromType:type];
        
        self.social = type >= EntypoIconSocialTypeGithub;
    }
    return self;
}

-(void) awakeFromNib {
    
    [super awakeFromNib];
    [self setDefaultFontsAndColor];
}

- (void)  setDefaultFontsAndColor {
    
    entypoFont = [UIFont fontWithName:@"Entypo" size:48.0];
    entypoSocialFont = [UIFont fontWithName:@"EntypoSocial" size:48.0];
    
    self.font = entypoFont;
    
    self.social = NO;
    
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)  setIconFromType:(EntypoIconType) type {
    
    float p = self.font.pointSize;
    self.social = type >= EntypoIconSocialTypeGithub;
    
    /*
        Fonts have been created as static variables;
     */
    UIFont *f = self.social?    entypoSocialFont :
                                entypoFont;
    
    self.font = [f fontWithSize:p]; // should return same modified UIFont instance
    
    self.text = [EntypoLabel stringFromFontSocialType:self.social iconType:type];
    
    /*
        Important NOT to use the setter here so we don't go cyclic
     */
    _numberIconType = @(type); // the NSNumber property is for archiving and use in IB
}

-(void) setPointSize:(CGFloat)pointSize {
    
    UIFont *f = self.social?    entypoSocialFont :
                                entypoFont;
    
    self.font = [f fontWithSize:pointSize];
}

#pragma mark - private



#pragma mark - Setters

-(void) setNumberIconType:(NSNumber *)numberIconType {
    
    // the NSNumber property is for archiving and use in IB
    
    [self setIconFromType:[numberIconType intValue]];
    
    _numberIconType = numberIconType;
}

#pragma mark - static methods

+ (EntypoLabel*)  newLabelWithIcon:(EntypoIconType) type {
    
    CGRect f = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    EntypoLabel *l = [[EntypoLabel alloc] initWithFrame:f iconType:type];
    l.social = type >= EntypoIconSocialTypeGithub;
    return l;
}
/*
+ (UIImage*) imageOfIcon:(EntypoIconType)type {
    
    float p = 36.0f;
    BOOL isSocial = type >= EntypoIconSocialTypeGithub;
    
    UIFont *f = isSocial?   [entypoSocialFont fontWithSize:p]:
    [entypoFont fontWithSize:p];
    
    CGRect r = CGRectMake(0.0f, 0.0f, 40.0f, 40.0f);
    
    UIGraphicsBeginImageContext(r.size);
    
    [[EntypoLabel stringFromFontSocialType:isSocial iconType:type] drawInRect:CGRectIntegral(r) withFont:f];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
*/
+ (UIImage*) imageOfIcon:(EntypoIconType)type {
    
    CGRect r = CGRectMake(0.0f, 0.0f, 44.0f, 44.0f);
    
    UIGraphicsBeginImageContext(r.size);
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    EntypoLabel* label = [EntypoLabel newLabelWithIcon:type];
    label.textAlignment = NSTextAlignmentCenter;
    CALayer *layer = [label layer];
    
    [layer renderInContext:c];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(NSString*)stringFromFontSocialType:(BOOL)isSocial iconType:(EntypoIconType)type {
    
    NSString *s;
    
    if (isSocial){
        
        long socialIndex = type-[EntypoLabel totalIcons];
        NSAssert(socialIndex < self.totalSocialIcons, @"Type out-of-range");
        
        unichar chr = socialUniChars[socialIndex];
        s = [[NSString alloc] initWithBytes:&chr length:sizeof(chr) encoding:NSUTF16LittleEndianStringEncoding];
        
    } else {
        
        NSAssert(type < self.totalIcons, @"Type out-of-range");
        int i = uniChars[type];
        s = [[NSString alloc] initWithBytes:&i length:sizeof(i) encoding:NSUTF32LittleEndianStringEncoding];
    }
    
    return s;
}

+ (NSInteger)  totalIcons {
    
    return 238;
}

+ (NSInteger)  totalSocialIcons{
    
    return 46;
}

# pragma mark - static variables

static int uniChars[] = {
    
    0x1f4de,    // EntypoIconTypePhone
    0x1f4f1,    // EntypoIconTypeMobile
    0xe789,     // EntypoIconTypeMouse
    0xe723,     // EntypoIconTypeAddress
    0x2709,     // EntypoIconTypeMail
    0x1f53f,    // EntypoIconTypePaperPlane
    0x270e,     // EntypoIconTypePencil
    0x2712,         //   EntypoIconTypeFeather,
    0x1F4CE,         //   EntypoIconTypeAttach,
    0xE777,         //   EntypoIconTypeInbox,
    0xE712,         //   EntypoIconTypeReply,
    0xE713,         //   EntypoIconTypereplyAll,
    0x27A6,         //   EntypoIconTypeForward,
    0x1F464,         //   EntypoIconTypeUser,
    0x1F465,         //   EntypoIconTypeUsers,
    0xE700,         //   EntypoIconTypeAddUser,
    0xE722,         //   EntypoIconTypeVCard,
    0xE715,         //   EntypoIconTypeExport,
    0xE724,         //   EntypoIconTypeLocation,
    0xE727,         //   EntypoIconTypeMap,
    0xE728,         //   EntypoIconTypeCompass,
    0x27A2,         //   EntypoIconTypeDirection,
    0x1F3AF,         //   EntypoIconTypeHaircross,
    0xE73C,         //   EntypoIconTypeShare,
    0xE73E,         //   EntypoIconTypeShareable,
    0x2665,         //   EntypoIconTypeHeart,
    0x2661,         //   EntypoIconTypeHeartEmpty,
    0x2605,         //   EntypoIconTypeStar,
    0x2606,         //   EntypoIconTypeStarEmpty,
    0x1F44D,         //   EntypoIconTypeThumbsUp,
    0x1F44E,         //   EntypoIconTypeThumbsDown,
    0xE720,         //   EntypoIconTypeChat,
    0xE718,         //   EntypoIconTypeComment,
    0x275E,         //   EntypoIconTypeQuote,
    0x2302,         //   EntypoIconTypeHome,
    0xE74C,         //   EntypoIconTypePopup,
    0x1F50D,         //   EntypoIconTypeSearch,
    0x1F526,         //   EntypoIconTypeFlashlight,
    0xE716,         //   EntypoIconTypePrint,
    0x1F514,         //   EntypoIconTypeBell,
    0x1F517,         //   EntypoIconTypeLink,
    0x2691,         //   EntypoIconTypeFlag,
    0x2699,         //   EntypoIconTypeCog,
    0x2692,         //   EntypoIconTypeTools,
    0x1F3C6,         //   EntypoIconTypeTrophy,
    0xE70C,         //   EntypoIconTypeTag,
    0x1F4F7,         //   EntypoIconTypeCamera,
    0x1F4E3,         //   EntypoIconTypeMegaphone,

    0x263D,         //   EntypoIconTypeMoon,
    0x1F3A8,         //   EntypoIconTypePalette,
    0x1F342,         //   EntypoIconTypeLeaf,
    0x266A,         //   EntypoIconTypeNote,
    0x266B,         //   EntypoIconTypeBeamedNote,
    0x1F4A5,         //   EntypoIconTypeNew,
    0x1F393,         //   EntypoIconTypeGraduationCap,
    0x1F4D5,         //   EntypoIconTypeBook,
    0x1F4F0,         //   EntypoIconTypeNewspaper,
    0x1F45C,         //   EntypoIconTypeBag,
    0x2708,         //   EntypoIconTypeAirplane,
    0xE788,         //   EntypoIconTypeLifebuoy,
    0xE70A,         //   EntypoIconTypeEye,
    0x1F554,         //   EntypoIconTypeClock,
    0x1F3A4,         //   EntypoIconTypeMic,
    0x1F4C5,         //   EntypoIconTypeCalendar,
    0x26A1,         //   EntypoIconTypeFlash,
    0x26C8,         //   EntypoIconTypeThunderCloud,
    0x1F4A7,         //   EntypoIconTypeDroplet,
    0x1F4BF,         //   EntypoIconTypeCD,
    0x1F4BC,         //   EntypoIconTypeBriefcase,
    0x1F4A8,         //   EntypoIconTypeAir,
    0x23F3,         //   EntypoIconTypeHourglass,
    0x1F6C7,         //   EntypoIconTypeGauge,
    0x1F394,         //   EntypoIconTypeLanguage,
    0xE776,         //   EntypoIconTypeNetwork,
    0x1F511,         //   EntypoIconTypeKey,
    0x1F50B,         //   EntypoIconTypeBattery,
    0x1F4FE,         //   EntypoIconTypeBucket,
    0xE7A1,         //   EntypoIconTypeMagnet,
    0x1F4FD,         //   EntypoIconTypeDrive,
    0x2615,         //   EntypoIconTypeCup,
    0x1F680,         //   EntypoIconTypeRocket,
    0xE79A,         //   EntypoIconTypeBrush,
    0x1F6C6,         //   EntypoIconTypeSuitcase,
    0x1F6C8,         //   EntypoIconTypeTrafficCone,
    0x1F30E,         //   EntypoIconTypeGlobe,
    0x2328,         //   EntypoIconTypeKeyboard,
    0xE74E,         //   EntypoIconTypeBrowser,
    0xE74D,         //   EntypoIconTypePublish,
    0xE76B,         //   EntypoIconTypeProgress3,
    0xE76A,         //   EntypoIconTypeProgress2,
    0xE769,         //   EntypoIconTypeProgress1,
    0xE768,         //   EntypoIconTypeProgress0,
    0x1F505,         //   EntypoIconTypeLightDown,
    0x1F506,         //   EntypoIconTypeLightUp,
    0x25D1,         //   EntypoIconTypeAdjust,
    0xE714,         //   EntypoIconTypeCode,
    0x1F4BB,         //   EntypoIconTypeMonitor,
    0x221E,         //   EntypoIconTypeInfinity,
    
    
    
    0x1F4A1,         //   EntypoIconTypeLightBulb,
    0x1F4B3,         //   EntypoIconTypeCreditCard,
    0x1F4F8,         //   EntypoIconTypeDatabase,
    0x2707,         //   EntypoIconTypeVoicemail,
    0x1F4CB,         //   EntypoIconTypeClipboard,
    0xE73D,         //   EntypoIconTypeCart,
    0x1F4E6,         //   EntypoIconTypeBox,
    0x1F3AB,         //   EntypoIconTypeTicket,
    0xE73A,         //   EntypoIconTypeRSS,
    0x1F4F6,         //   EntypoIconTypeSignal,
    0x1F4FF,         //   EntypoIconTypeThermometer,
    0x1F4A6,         //   EntypoIconTypeWater,
    0xF601,         //   EntypoIconTypeSweden,
    0x1F4C8,         //   EntypoIconTypeLineGraph,
    0x25F4,         //   EntypoIconTypePieChart,
    0x1F4CA,         //   EntypoIconTypeBarGraph,
    0x1F53E,         //   EntypoIconTypeAreaGraph,
    0x1F512,         //   EntypoIconTypeLock,
    0x1F513,         //   EntypoIconTypeLockOpen,
    0xE741,         //   EntypoIconTypeLogout,
    0xE740,         //   EntypoIconTypeLogin,
    0x2713,         //   EntypoIconTypeCheck,
    0x274C,         //   EntypoIconTypeCross,
    0x229F,         //   EntypoIconTypeSquaredMinus,
    0x229E,         //   EntypoIconTypeSquaredPlus,
    0x274E,         //   EntypoIconTypeSquaredCross,
    0x2296,         //   EntypoIconTypeCircledMinus,
    0x2295,         //   EntypoIconTypeCircledPlus,
    0x2716,         //   EntypoIconTypeCircledCross,
    0x2796,         //   EntypoIconTypeMinus,
    0x2795,         //   EntypoIconTypePlus,
    0x232B,         //   EntypoIconTypeErase,
    0x1F6AB,         //   EntypoIconTypeBlock,
    0x2139,         //   EntypoIconTypeInfo,
    0xE705,         //   EntypoIconTypeCircledInfo,
    0x2753,         //   EntypoIconTypeHelp,
    0xE704,         //   EntypoIconTypeCircledHelp,
    0x26A0,         //   EntypoIconTypeWarning,
    0x1F504,         //   EntypoIconTypeCycle,
    0x27F3,         //   EntypoIconTypeCW,
    0x27F2,         //   EntypoIconTypeCCW,
    0x1F500,         //   EntypoIconTypeShuffle,
    0x1F519,         //   EntypoIconTypeBack,
    0x21B3,         //   EntypoIconTypeLevelDown,
    0xE717,         //   EntypoIconTypeRetweet,
    0x1F501,         //   EntypoIconTypeLoop,
    0xE771,         //   EntypoIconTypeBackInTime,
    0x21B0,         //   EntypoIconTypeLevelUp,
    0x21C6,         //   EntypoIconTypeSwitch,
    0xE005,         //   EntypoIconTypeNumberedList,
    0xE003,         //   EntypoIconTypeAddtoList,
    0x268F,         //   EntypoIconTypeLayout,
    0x2630,         //   EntypoIconTypeList,
    0x1F4C4,         //   EntypoIconTypeTextDoc,
    0xE731,         //   EntypoIconTypeTextDocInverted,
    0xE730,         //   EntypoIconTypeDoc,
    0xE736,         //   EntypoIconTypeDocs,
    0xE737,         //   EntypoIconTypeLandscapeDoc,
    
    
    
    
    
    0x1F304,         //   EntypoIconTypePicture,
    0x1F3AC,         //   EntypoIconTypeVideo,
    0x1F3B5,         //   EntypoIconTypeMusic,
    0x1F4C1,         //   EntypoIconTypeFolder,
    0xE800,         //   EntypoIconTypeArchive,
    0xE729,         //   EntypoIconTypeTrash,
    0x1F4E4,         //   EntypoIconTypeUpload,
    0x1F4E5,         //   EntypoIconTypeDownload,
    0x1F4BE,         //   EntypoIconTypeSave,
    0xE778,         //   EntypoIconTypeInstall,
    0x2601,         //   EntypoIconTypeCloud,
    0xE711,         //   EntypoIconTypeUploadCloud,
    0x1F516,         //   EntypoIconTypeBookmark,
    0x1F4D1,         //   EntypoIconTypeBookmarks,
    0x1F4D6,         //   EntypoIconTypeOpenBook,
    0x25B6,         //   EntypoIconTypePlay,
    0x2016,         //   EntypoIconTypePause,
    0x25CF,         //   EntypoIconTypeRecord,
    0x25A0,         //   EntypoIconTypeStop,
    0x23E9,         //   EntypoIconTypeFF,
    0x23EA,         //   EntypoIconTypeFB,
    0x23EE,         //   EntypoIconTypeToStart,
    0x23ED,         //   EntypoIconTypeToEnd,
    0xE744,         //   EntypoIconTypeResizeFull,
    0xE746,         //   EntypoIconTypeResizeSmall,
    0x23F7,         //   EntypoIconTypeVolume,
    0x1F50A,         //   EntypoIconTypeSound,
    0x1F507,         //   EntypoIconTypeMute,
    0x1F568,         //   EntypoIconTypeFlowCascade,
    0x1F569,         //   EntypoIconTypeFlowBranch,
    0x1F56A,         //   EntypoIconTypeFlowTree,
    0x1F56B,         //   EntypoIconTypeFlowLine,
    0x1F56C,         //   EntypoIconTypeFlowParallel,
    0xE4AD,         //   EntypoIconTypeLeftBold,
    0xE4B0,         //   EntypoIconTypeDownBold,
    0xE4AF,         //   EntypoIconTypeUpBold,
    0xE4AE,         //   EntypoIconTypeRightBold,
    0x2B05,         //   EntypoIconTypeLeft,
    0x2B07,         //   EntypoIconTypeDown,
    0x2B06,         //   EntypoIconTypeUp,
    0x27A1,         //   EntypoIconTypeRight,
    0xE759,         //   EntypoIconTypeCircledLeft,
    0xE758,         //   EntypoIconTypeCircledDown,
    0xE75B,         //   EntypoIconTypeCircledUp,
    0xE75A,         //   EntypoIconTypeCircledRight,
    0x25C2,         //   EntypoIconTypeTriangleLeft,
    0x25BE,         //   EntypoIconTypeTriangleDown,
    0x25B4,         //   EntypoIconTypeTriangleUp,
    0x25B8,         //   EntypoIconTypeTriangleRight,
    0xE75D,         //   EntypoIconTypeChevronLeft,
    0xE75C,         //   EntypoIconTypeChevronDown,
    0xE75F,         //   EntypoIconTypeChevronUp,
    0xE75E,         //   EntypoIconTypeChevronRight,
    0xE761,         //   EntypoIconTypeChevronSmallLeft,
    0xE760,         //   EntypoIconTypeChevronSmallDown,
    0xE763,         //   EntypoIconTypeChevronSmallUp,
    0xE762,         //   EntypoIconTypeChevronSmallRight,
    0xE765,         //   EntypoIconTypeChevronThinLeft,
    0xE764,         //   EntypoIconTypeChevronThinDown,
    0xE767,         //   EntypoIconTypeChevronThinUp,
    0xE766,         //   EntypoIconTypeChevronThinRight,
    0x2190,         //   EntypoIconTypeLeftThin,
    0x2193,         //   EntypoIconTypeDownThin,
    0x2191,         //   EntypoIconTypeUpThin,
    0x2192,         //   EntypoIconTypeRightThin,
    0xE74F,         //   EntypoIconTypeArrowCombo,
    0x23F6,         //   EntypoIconTypeThreeDots,
    0x23F5,         //   EntypoIconTypeTwoDots,
    0x23F4,         //   EntypoIconTypeDot,
    0x1F545,         //   EntypoIconTypeCC,
    0x1F546,         //   EntypoIconTypeCCBY,
    0x1F547,         //   EntypoIconTypeCCNC,
    0x1F548,         //   EntypoIconTypeCCNCEU,
    0x1F549,         //   EntypoIconTypeCCNCJP,
    0x1F54A,         //   EntypoIconTypeCCSA,
    0x1F54B,         //   EntypoIconTypeCCND,
    0x1F54C,         //   EntypoIconTypeCCPD,
    0x1F54D,         //   EntypoIconTypeCCZero,
    0x1F54E,         //   EntypoIconTypeCCShare,
    0x1F54F,         //   EntypoIconTypeCCremix,
    0x1F5F9,         //   EntypoIconTypeDBLogo,
    0x1F5FA,         //   EntypoIconTypeDBShape,
    
    0xF300,         //   EntypoIconSocialTypeGithub,
    0xF301,         //   EntypoIconSocialTypeCGithub,
    0xF303,         //   EntypoIconSocialTypeFlickr,
    0xF304,         //   EntypoIconSocialTypeCFlickr,
    0xF306,         //   EntypoIconSocialTypeVimeo,
    0xF307,         //   EntypoIconSocialTypeCVimeo,
    0xF309,         //   EntypoIconSocialTypeTwitter,
    0xF30A,         //   EntypoIconSocialTypeCTwitter,
    0xF30C,         //   EntypoIconSocialTypeFacebook,
    0xF30D,         //   EntypoIconSocialTypeCFacebook,
    0xF30E,         //   EntypoIconSocialTypeSFacebook,
    0xF30F,         //   EntypoIconSocialTypeGooglePlus,
    0xF310,         //   EntypoIconSocialTypeCGooglePlus,
    0xF312,         //   EntypoIconSocialTypePinterest,
    0xF313,         //   EntypoIconSocialTypeCPinterest,
    0xF315,         //   EntypoIconSocialTypeTumblr,
    0xF316,         //   EntypoIconSocialTypeCtumblr,
    0xF318,         //   EntypoIconSocialTypeLinkedIn,
    0xF319,         //   EntypoIconSocialTypeClinkedIn,
    0xF31B,         //   EntypoIconSocialTypeDribbble,
    0xF31C,         //   EntypoIconSocialTypeCDribbble,
    0xF31E,         //   EntypoIconSocialTypeStumbleupon,
    0xF31F,         //   EntypoIconSocialTypeCStumbleupon,
    0xF321,         //   EntypoIconSocialTypeLastFM,
    0xF322,         //   EntypoIconSocialTypeCLastFM,
    0xF324,         //   EntypoIconSocialTypeRdio,
    0xF325,         //   EntypoIconSocialTypeCRdio,
    0xF327,         //   EntypoIconSocialTypeSpotify,
    0xF328,         //   EntypoIconSocialTypeCSpotify,
    0xF32A,         //   EntypoIconSocialTypeQQ,
    0xF32D,         //   EntypoIconSocialTypeInstagram,
    0xF330,         //   EntypoIconSocialTypeDropBox,
    0xF333,         //   EntypoIconSocialTypeEvernote,
    0xF336,         //   EntypoIconSocialTypeFlattr,
    0xF339,         //   EntypoIconSocialTypeSkype,
    0xF33A,         //   EntypoIconSocialTypeCSkype,
    0xF33C,         //   EntypoIconSocialTypeRenren,
    0xF33F,         //   EntypoIconSocialTypeSinaWeibo,
    0xF342,         //   EntypoIconSocialTypePayPal,
    0xF345,         //   EntypoIconSocialTypePicasa,
    0xF348,         //   EntypoIconSocialTypeSoundcloud,
    0xF34B,         //   EntypoIconSocialTypeMixi,
    0xF34E,         //   EntypoIconSocialTypeBehance,
    0xF351,         //   EntypoIconSocialTypeGoogleCircles,
    0xF354,         //   EntypoIconSocialTypeVK,
    0xF357          //   EntypoIconSocialTypeSmashing
    
};

static unichar socialUniChars[] = {
    
    0xF300,         //   EntypoIconSocialTypeGithub,
    0xF301,         //   EntypoIconSocialTypeCGithub,
    0xF303,         //   EntypoIconSocialTypeFlickr,
    0xF304,         //   EntypoIconSocialTypeCFlickr,
    0xF306,         //   EntypoIconSocialTypeVimeo,
    0xF307,         //   EntypoIconSocialTypeCVimeo,
    0xF309,         //   EntypoIconSocialTypeTwitter,
    0xF30A,         //   EntypoIconSocialTypeCTwitter,
    0xF30C,         //   EntypoIconSocialTypeFacebook,
    0xF30D,         //   EntypoIconSocialTypeCFacebook,
    0xF30E,         //   EntypoIconSocialTypeSFacebook,
    0xF30F,         //   EntypoIconSocialTypeGooglePlus,
    0xF310,         //   EntypoIconSocialTypeCGooglePlus,
    0xF312,         //   EntypoIconSocialTypePinterest,
    0xF313,         //   EntypoIconSocialTypeCPinterest,
    0xF315,         //   EntypoIconSocialTypeTumblr,
    0xF316,         //   EntypoIconSocialTypeCtumblr,
    0xF318,         //   EntypoIconSocialTypeLinkedIn,
    0xF319,         //   EntypoIconSocialTypeClinkedIn,
    0xF31B,         //   EntypoIconSocialTypeDribbble,
    0xF31C,         //   EntypoIconSocialTypeCDribbble,
    0xF31E,         //   EntypoIconSocialTypeStumbleupon,
    0xF31F,         //   EntypoIconSocialTypeCStumbleupon,
    0xF321,         //   EntypoIconSocialTypeLastFM,
    0xF322,         //   EntypoIconSocialTypeCLastFM,
    0xF324,         //   EntypoIconSocialTypeRdio,
    0xF325,         //   EntypoIconSocialTypeCRdio,
    0xF327,         //   EntypoIconSocialTypeSpotify,
    0xF328,         //   EntypoIconSocialTypeCSpotify,
    0xF32A,         //   EntypoIconSocialTypeQQ,
    0xF32D,         //   EntypoIconSocialTypeInstagram,
    0xF330,         //   EntypoIconSocialTypeDropBox,
    0xF333,         //   EntypoIconSocialTypeEvernote,
    0xF336,         //   EntypoIconSocialTypeFlattr,
    0xF339,         //   EntypoIconSocialTypeSkype,
    0xF33A,         //   EntypoIconSocialTypeCSkype,
    0xF33C,         //   EntypoIconSocialTypeRenren,
    0xF33F,         //   EntypoIconSocialTypeSinaWeibo,
    0xF342,         //   EntypoIconSocialTypePayPal,
    0xF345,         //   EntypoIconSocialTypePicasa,
    0xF348,         //   EntypoIconSocialTypeSoundcloud,
    0xF34B,         //   EntypoIconSocialTypeMixi,
    0xF34E,         //   EntypoIconSocialTypeBehance,
    0xF351,         //   EntypoIconSocialTypeGoogleCircles,
    0xF354,         //   EntypoIconSocialTypeVK,
    0xF357          //   EntypoIconSocialTypeSmashing
};

static UIFont* entypoSocialFont;
static UIFont* entypoFont;

@end
