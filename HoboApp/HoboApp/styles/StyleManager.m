//
//  StyleManager.m
//  Engager
//
//  Created by Lee Probert on 22/04/2013.
//
// https://agnitio-as.atlassian.net/browse/DEV-355

#import "StyleManager.h"
#import "UIColor+Hex.h"
//#import "IconSuper.h"
//#import "UIImage+ImageWithUIView.h"

//#import "ContactDetailViewController.h"

static StyleManager *_instance = nil;

@interface StyleManager ()

-(NSDictionary*) getTitleTextAttributesForComponent:(Class)component forState:(UIControlState)controlState;
-(NSValue*) getShadowOffsetForComponent:(Class)component forState:(UIControlState)controlState;

@end

@implementation StyleManager

#pragma mark - Private

-(void)loadStyles {
    
    /*
        Get the required style plist from the bundle. The filename is set in the
     */
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    self.filename = (NSString*)info[kStylesFilenameInfoKey];
    
    /*
        Now load the styles plist
     */
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:self.filename ofType:@"plist"];
    self.styleData = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    /*
        UIBarButtonItem -----------------------------------------
     */
    
    if([UIBarButtonItem respondsToSelector:@selector(appearance)])
    {
//        [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes: [self getTitleTextAttributesForComponent:[UIBarButtonItem class] forState:UIControlStateNormal] forState:UIControlStateNormal];
//        
//        [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes: [self getTitleTextAttributesForComponent:[UIBarButtonItem class] forState:UIControlStateSelected] forState:UIControlStateSelected];
        
        // Normal
        [[UIBarButtonItem appearance] setTitleTextAttributes: [self getTitleTextAttributesForComponent:[UIBarButtonItem class] forState:UIControlStateNormal] forState:UIControlStateNormal];
        
        // Disabled
        [[UIBarButtonItem appearance] setTitleTextAttributes: [self getTitleTextAttributesForComponent:[UIBarButtonItem class] forState:UIControlStateDisabled] forState:UIControlStateDisabled];
        
        // Selected
        [[UIBarButtonItem appearance] setTitleTextAttributes: [self getTitleTextAttributesForComponent:[UIBarButtonItem class] forState:UIControlStateSelected] forState:UIControlStateSelected];
        
        // Highlighted
        [[UIBarButtonItem appearance] setTitleTextAttributes: [self getTitleTextAttributesForComponent:[UIBarButtonItem class] forState:UIControlStateSelected] forState:UIControlStateHighlighted];
        
        if(IOS6){
            
            [[UIBarButtonItem appearance] setBackgroundImage:[self getImageForStyleKey:@"menuButtonBackground"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        }
        
        if(IOS7){
            
            [[UIBarButtonItem appearance] setTintColor: [self getColorForStyleKey:@"barButtonItemTextColor"]];
        }
    }
    
    /*
        UIButton -----------------------------------------
     */
    
    if([UIButton respondsToSelector:@selector(appearance)])
    {
        if(IOS7){
            
            [[UIButton appearance] setTintColor:[self getColorForStyleKey:@"buttonTintColor"]];
        }
    }
    
    /*
        UINavigationBar -----------------------------------------
     */
    
    if([UINavigationBar respondsToSelector:@selector(appearance)])
    {   
        [[UINavigationBar appearance] setTitleTextAttributes: [self getTitleTextAttributesForComponent:[UINavigationBar class] forState:0]];
        
        if(IOS6){
            
            [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
            [[UINavigationBar appearance] setTintColor:[self getColorForStyleKey:@"navigationBarBackgroundColor"]];
        }
        
        if(IOS7){
            
            [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
            [[UINavigationBar appearance] setBarTintColor:[self getColorForStyleKey:@"navigationBarBackgroundColor"]];
            [[UINavigationBar appearance] setTintColor:[self getColorForStyleKey:@"navigationBarTintColor"]];
        }
    }
    
    /*
        UITabBar
     */
    
    if([UITabBar respondsToSelector:@selector(appearance)]){
        
        [[UITabBar appearance] setBackgroundColor:[self getColorForStyleKey:@"navigationBarBackgroundColor"]];
        
        if(!(SYSTEM_VERSION_LESS_THAN(@"6.0")) && SYSTEM_VERSION_LESS_THAN(@"7.0")){
            
            // this is iOS 6
            [[UITabBar appearance] setTintColor:[self getColorForStyleKey:@"navigationBarBackgroundColor"]];
        }
        
        if(!(SYSTEM_VERSION_LESS_THAN(@"7.0"))){
            
            // this is iOS 7
            [[UITabBar appearance] setBarTintColor:[self getColorForStyleKey:@"navigationBarBackgroundColor"]];
            [[UITabBar appearance] setTintColor:[self getColorForStyleKey:@"tabBarTintColor"]];
            
        }
        
        [[UITabBar appearance] setSelectedImageTintColor:[self getColorForStyleKey:@"tabBarSelectedTintColor"]];
    }
    
    /*
     UITabBarItem
     */
    if([UITabBarItem respondsToSelector:@selector(appearance)])
    {
        [[UITabBarItem appearance] setTitleTextAttributes:[self getTitleTextAttributesForComponent:[UITabBarItem class] forState:UIControlStateNormal] forState:UIControlStateNormal];
        [[UITabBarItem appearance] setTitleTextAttributes:[self getTitleTextAttributesForComponent:[UITabBarItem class] forState:UIControlStateSelected] forState:UIControlStateSelected];
    }
    
    /*
        UIToolbar
     */
    if([UIToolbar respondsToSelector:@selector(appearance)]){
        
        if(IOS7){
            
            // this is iOS 7
            [[UIToolbar appearance] setBackgroundColor:[self getColorForStyleKey:@"navigationBarBackgroundColor"]];
            [[UIToolbar appearance] setBarTintColor:[self getColorForStyleKey:@"navigationBarBackgroundColor"]];
            [[UIToolbar appearance] setTintColor:[self getColorForStyleKey:@"tabBarTintColor"]];
        }
    }
    
    /*
        UIPageControl -----------------------------------------
     */
    
    if([UIPageControl respondsToSelector:@selector(appearance)])
    {
        if(!(SYSTEM_VERSION_LESS_THAN(@"6.0"))){
            [[UIPageControl appearance] setCurrentPageIndicatorTintColor:[self getColorForStyleKey:@"pageControlCurrentPageIndicatorTintColor"]];
            [[UIPageControl appearance] setPageIndicatorTintColor:[self getColorForStyleKey:@"pageControlCurrentPageIndicatorTintColor"]];
        }
    }
    
    /*
        UIProgressView -----------------------------------------
     */
     
    if([UIProgressView respondsToSelector:@selector(appearance)])
    {
        [[UIProgressView appearance] setProgressTintColor: [self getColorForStyleKey:@"progressViewTintColor"]];
        [[UIProgressView appearance] setTrackTintColor:[self getColorForStyleKey:@"progressViewTrackTintColor"]];
    }
    
    /*
        UIRefreshControl -----------------------------------------
     */
    
    if(!(SYSTEM_VERSION_LESS_THAN(@"6.0"))){
        
        if([UIRefreshControl respondsToSelector:@selector(appearance)])
        {
            [[UIRefreshControl appearance] setTintColor: [self getColorForStyleKey:@"refreshControlTintColor"]];
        }
    }
    
    /*
        UISearchBar -----------------------------------------
     */
    
    if([UISearchBar respondsToSelector:@selector(appearance)])
    {
        // backgroundImage
    }
    
    /*
        UISegmentedControl -----------------------------------------
     */
    
    if([UISegmentedControl respondsToSelector:@selector(appearance)])
    {
        if(!(SYSTEM_VERSION_LESS_THAN(@"6.0"))){
            
            [[UISegmentedControl appearance] setTintColor: [self getColorForStyleKey:@"segmentedControlTintColor"]];
        }
        [[UISegmentedControl appearance] setTitleTextAttributes:[self getTitleTextAttributesForComponent:[UISegmentedControl class] forState:UIControlStateNormal] forState:UIControlStateNormal];
        [[UISegmentedControl appearance] setTitleTextAttributes:[self getTitleTextAttributesForComponent:[UISegmentedControl class] forState:UIControlStateSelected] forState:UIControlStateSelected];
    }
    
    /*
        UISlider -----------------------------------------
     */
    
    if([UISlider respondsToSelector:@selector(appearance)])
    {
        [[UISlider appearance] setMinimumTrackTintColor: [self getColorForStyleKey:@"sliderMinTrackTintColor"]];
        [[UISlider appearance] setMaximumTrackTintColor: [self getColorForStyleKey:@"sliderMaxTrackTintColor"]];
        [[UISlider appearance] setThumbTintColor: [self getColorForStyleKey:@"sliderThumbTintColor"]];
    }
    
    /*
        UIStepper -----------------------------------------
     */
    
    if([UIStepper respondsToSelector:@selector(appearance)])
    {
        if(!(SYSTEM_VERSION_LESS_THAN(@"6.0"))){
            
            [[UIStepper appearance] setTintColor: [self getColorForStyleKey:@"stepperTintColor"]];
        }
    }
    
    /*
        UISwitch -----------------------------------------
     */
    
    if([UISwitch respondsToSelector:@selector(appearance)])
    {
        if(!(SYSTEM_VERSION_LESS_THAN(@"6.0"))){
            
            [[UISwitch appearance] setTintColor:[self getColorForStyleKey:@"switchTintColor"]];
            [[UISwitch appearance] setOnTintColor:[self getColorForStyleKey:@"switchOnTintColor"]];
            [[UISwitch appearance] setThumbTintColor:[self getColorForStyleKey:@"switchThumbTintColor"]];
        }
        
    }
    
    /*
        UITableView -----------------------------------------
     */
    
    if([UITableView respondsToSelector:@selector(appearance)])
    {
        if((IOS6) || (IOS7)){
        
            // this is iOS 6
            [[UITableView appearance] setSectionIndexColor:[self getColorForStyleKey:@"tableViewSectionIndexColor"]];
            [[UITableView appearance] setSectionIndexTrackingBackgroundColor:[self getColorForStyleKey:@"tableViewSectionIndexTrackBackgroundColor"]];
        }
        
        if(IOS7){
            
            // this is iOS 7
            [[UITableView appearance] setSectionIndexBackgroundColor:[self getColorForStyleKey:@"tableViewSectionIndexBackgroundColor"]];
        }
    }
    
    /*
        UITableViewHeaderFooterView -----------------------------------------
     */
    
    if([UITableViewHeaderFooterView respondsToSelector:@selector(appearance)])
    {
        if(!(SYSTEM_VERSION_LESS_THAN(@"6.0"))){
            
            [[UITableViewHeaderFooterView appearance] setTintColor:[self getColorForStyleKey:@"tableViewHeaderFooterColor"]];
        }
    }
    
    /*
        UIToolbar -----------------------------------------
     */
    
    if([UIToolbar respondsToSelector:@selector(appearance)])
    {
        if(!(SYSTEM_VERSION_LESS_THAN(@"6.0"))){
            
            [[UIToolbar appearance] setTintColor:[self getColorForStyleKey:@"toolbarTintColor"]];
        }
    }
    
    self.isLoaded = YES;
}

-(NSDictionary*) getTitleTextAttributesForComponent:(Class)component forState:(UIControlState)controlState {
    
    NSDictionary *attrib = nil;
    
    if([UINavigationBar class] == component) {
        
        attrib = @{
                 UITextAttributeTextColor: [self getColorForStyleKey:@"navigationBarTitleColor"],
                 UITextAttributeTextShadowColor: [self getColorForStyleKey:@"clearColor"],
                 UITextAttributeTextShadowOffset: [self getShadowOffsetForComponent:component forState:UIControlStateNormal],
                 UITextAttributeFont: [self getFontForStyleKey:@"mainNavBarFont"],
                 };
        
    } else if ([UIBarButtonItem class] == component) {
        
        if(controlState == UIControlStateNormal){
            
            attrib = @{
                       UITextAttributeTextColor: [self getColorForStyleKey:@"barButtonItemTextColor"],
                       UITextAttributeTextShadowColor: [self getColorForStyleKey:@"clearColor"],
                       UITextAttributeTextShadowOffset: [self getShadowOffsetForComponent:component forState:UIControlStateNormal],
                       UITextAttributeFont: [self getFontForStyleKey:@"barButtonItemFont"],
                       };
            
        }else if(controlState == UIControlStateSelected){
            
            attrib = @{
                       UITextAttributeTextColor: [self getColorForStyleKey:@"barButtonItemSelectedTextColor"],
                       UITextAttributeTextShadowColor: [self getColorForStyleKey:@"clearColor"],
                       UITextAttributeTextShadowOffset: [self getShadowOffsetForComponent:component forState:UIControlStateNormal],
                       UITextAttributeFont: [self getFontForStyleKey:@"barButtonItemFont"],
                       };
        }else if(controlState == UIControlStateDisabled){
            
            attrib = @{
                       UITextAttributeTextColor: [self getColorForStyleKey:@"barButtonItemDisabledTextColor"],
                       UITextAttributeTextShadowColor: [self getColorForStyleKey:@"clearColor"],
                       UITextAttributeTextShadowOffset: [self getShadowOffsetForComponent:component forState:UIControlStateNormal],
                       UITextAttributeFont: [self getFontForStyleKey:@"barButtonItemFont"],
                       };
        }
        
    }else if ([UISegmentedControl class] == component) {
        
        if(controlState == UIControlStateNormal){
            
            attrib = @{
                       UITextAttributeTextColor: [self getColorForStyleKey:@"segmentedControlTextColor"],
                       UITextAttributeTextShadowColor: [self getColorForStyleKey:@"clearColor"],
                       UITextAttributeTextShadowOffset: [self getShadowOffsetForComponent:component forState:UIControlStateNormal],
                       UITextAttributeFont: [self getFontForStyleKey:@"mainFont12"]
                       };
        }
        
    }else if ([UITabBarItem class] == component){
        
        if(controlState == UIControlStateNormal){
            
            attrib = @{
                       UITextAttributeTextColor: [self getColorForStyleKey:@"tabBarItemTextColor"],
                       UITextAttributeTextShadowColor: [self getColorForStyleKey:@"clearColor"],
                       UITextAttributeTextShadowOffset: [self getShadowOffsetForComponent:component forState:UIControlStateNormal],
                       UITextAttributeFont: [self getFontForStyleKey:@"mainFont10"]
                       };
            
        }else if (controlState == UIControlStateSelected){
            
            attrib = @{
                       UITextAttributeTextColor: [self getColorForStyleKey:@"tabBarItemSelectedTextColor"],
                       UITextAttributeTextShadowColor: [self getColorForStyleKey:@"clearColor"],
                       UITextAttributeTextShadowOffset: [self getShadowOffsetForComponent:component forState:UIControlStateSelected],
                       UITextAttributeFont: [self getFontForStyleKey:@"mainFont10"]
                       };
        }
    }
    
    return attrib;
}

-(NSNumber*) getMetricForKey:(NSString*)key {
    
    NSNumber *n = self.metricsData[key];
    return @([n floatValue]);
}

-(NSNumber*) getConfigForKey:(NSString*)key {
    
    NSNumber *n = self.configData[key];
    return @([n boolValue]);
}

-(NSValue*) getShadowOffsetForComponent:(Class)component forState:(UIControlState)controlState {
    
    NSValue* value;
    NSArray *offsetSrc = nil;
    CGFloat h;
    CGFloat v;
    
    if([UINavigationBar class] == component) {
        
        offsetSrc = [self.metricsData[@"navigationBarTitleShadowOffset"] componentsSeparatedByString:@","];
        
    }else if ([UIBarButtonItem class] == component) {
        
        offsetSrc = [self.metricsData[@"barButtonItemTextShadowOffset"] componentsSeparatedByString:@","];
        
    }else if ([UISegmentedControl class] == component) {
        
        if(controlState == UIControlStateNormal){
            
            offsetSrc = [self.metricsData[@"defaultShadowOffset"] componentsSeparatedByString:@","];
            
        }else if(controlState == UIControlStateSelected){
            
            offsetSrc = [self.metricsData[@"defaultSelectedShadowOffset"] componentsSeparatedByString:@","];
        }
    }else if([UITabBarItem class] == component){
        
        if(controlState == UIControlStateNormal){
            
            offsetSrc = [self.metricsData[@"defaultShadowOffset"] componentsSeparatedByString:@","];
            
        }else if(controlState == UIControlStateSelected){
            
            offsetSrc = [self.metricsData[@"defaultSelectedShadowOffset"] componentsSeparatedByString:@","];
        }
    }
    
    h = offsetSrc? [offsetSrc[0] floatValue] : 1.0f;
    v = offsetSrc? [offsetSrc[1] floatValue] : 1.0f;
    value = [NSValue valueWithUIOffset:UIOffsetMake(h, v)];
    
    return value;
}

-(UIColor*) getColorForStyleKey:(NSString*)key {
    
    NSString *value = self.colorsData[key];
    
    if([value isEqualToString:@"<ignore>"]){
        
        return nil;
    }
    
    /*
        If value is nil does the KEY resolve if capitalised?
     */
    if(nil == value){
        
        value = self.colorsData[[key capitalizedString]];
    }
    
    /*
        Does the value resolve to another key?
     */
    if(nil != self.colorsData[value]){
        
        value = self.colorsData[value];
    }
    
    /*
        Can we resolve the value by capitalization to a CSS color key?
     */
    if(nil != self.colorsData[[value capitalizedString]]){
        
        value = self.colorsData[[value capitalizedString]];
    }
    
    /*
        Can UIColor resolve the value as a class method?
     */
    
    SEL selector = NSSelectorFromString(value);
    
    BOOL isColorMethod = [[UIColor class] respondsToSelector:selector];
    BOOL isHex = [value hasPrefix:@"#"];
    
    // If not HEX or a UIColorMethod, can we resolve the value to a CSS name?
    BOOL isCSSName = nil != self.colorsData[value] && !(isColorMethod || isHex);
    if(isCSSName){
        value = self.colorsData[value];
        isHex = YES;
    }
    
    // Is this an RGBA color string?
    BOOL isRGBA = [[value componentsSeparatedByString:@","] count]==4;
    
    if(isRGBA){
        NSArray *rgba = [value componentsSeparatedByString:@","];
        CGFloat r = [rgba[0] floatValue];
        CGFloat g = [rgba[1] floatValue];
        CGFloat b = [rgba[2] floatValue];
        CGFloat a = [rgba[3] floatValue];
        UIColor *rgbaCol = [UIColor colorWithRed:r green:g blue:b alpha:a];
        
        return rgbaCol;
    }
    
    UIColor *color;
    
    if(isColorMethod){
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        color = [[UIColor class] performSelector:selector];
        
#pragma clang diagnostic pop
        
    }else{
        
        if(isHex){
            
            color = [UIColor colorWithHexString:value];
            
        }else{
            
            color = [UIColor blackColor];
        }
    }
    
    /*
        Is the key a reference to a tiled image?
     */
    NSArray *components = [value componentsSeparatedByString:@":"];
    if([components count]>1){
        
        if([components[0] isEqualToString:@"tile"]){
            
            UIColor *tiledColor = [UIColor colorWithPatternImage:[self getImageForStyleKey:components[1]]];
            return tiledColor;
        }
    }
    
    return color;
}

-(UIFont*) getFontForStyleKey:(NSString*)key {
    
    /*
        Fonts are set in the plist like so :
     
        Avenir:14
        Helvetica:16.5
     */
    
    NSString *value = (NSString*)self.fontsData[key];
    
    /*
        First, can we resolve the value to another key?
     */
    if(nil != self.fontsData[value]){
        
        value = self.fontsData[value];
    }
    
    NSArray *properties = [value componentsSeparatedByString:@":"];
    NSString *fontName = properties[0];
    NSString *fontSize = properties[1];
    
    if([fontName isEqualToString:@"default"]){
        
        fontName = self.fontsData[@"default"];
    }
    
    if([fontName isEqualToString:@"defaultBold"]){
        
        fontName = self.fontsData[@"defaultBold"];
    }
    
    if (SYSTEM_VERSION_LESS_THAN(@"6.0")){
        
        fontName = @"ArialMT";
    }
    
    UIFont *font = [UIFont fontWithName:fontName size:[fontSize floatValue]];
    return font;
}

-(UIImage*) getImageForStyleKey:(NSString*)key {
    
    /*
        Images are set in the plist like so :
     
        image1.png:2,2,2,2:stretch
        image2.jpg:4,2,4,2:tile
     */
    
    NSString *value = self.imagesData[key];
    
    if([value isEqualToString:@"<ignore>"]){
        
        return nil;
    }
    
    /*
        Does the value resolve to another key?
     */
    if(nil != self.imagesData[value]){
        
        value = self.imagesData[value];
    }
    
    if([[value lowercaseString] isEqualToString:@"nil"]){
        
        /*
            Return empty image if you want to nullify a navBar shadow or background image
         */
        return [[UIImage alloc] init];
    };
    
    /*
        Does the value resolve to a UIColor static method?
        If so, return a 1x1 pixel colored UIImage
     */
    SEL selector = NSSelectorFromString(value);
    
    BOOL isColorMethod = [[UIColor class] respondsToSelector:selector];
    
    if(isColorMethod) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        UIColor *color = [[UIColor class] performSelector:selector];
        
#pragma clang diagnostic pop
        
        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    /*
        If we have got this far the image value is either a resizable image set as a string like this "image1.png:2,2,2,2:stretch"
        or it is an icon reference like this : "icon:iconName:44:44:white" in which case the icon is drawn at the set width and height and then returned as a UIImage
        you would use this to create barButtonItem icons. The names of the icons are described in the IconSuper class and in the styling documentation.
        Or it is a view class that you wish to be converted to an image at a certain size. The syntax in this case is view:ClassName:44:44
     
        Resizable Image :   "image1.png:2,2,2,2:stretch"
        Icon :              "icon:iconName:44:44:white"
        View :              "view:ClassName:44:44"
     */
    
    NSArray *properties = [value componentsSeparatedByString:@":"];
    
    if([properties count]==1){
        
        return [UIImage imageNamed:value];
        
    }else if([properties[0] isEqualToString:@"icon"]){
        
        CGRect r = CGRectMake(0, 0, [properties[2] floatValue], [properties[3] floatValue]);
        AGNIconType iconType = [IconSuper newIconTypeFromString:properties[1]];
        IconSuper *icon = [IconSuper newIconOfType:iconType frame:r];
        UIColor *fillColor = [self getColorForStyleKey:properties[4]];
        icon.fillColor = fillColor;
        return [self imageFromIconClass:icon];
        
    }else if([properties[0] isEqualToString:@"view"]){
        
        CGRect r = CGRectMake(0, 0, [properties[2] floatValue], [properties[3] floatValue]);
        Class c = NSClassFromString(properties[1]);
        UIView *view = [[c alloc] initWithFrame:r];
        return [UIImage imageWithUIView:view];
    }
    
    NSString* filename = properties[0];
    NSArray *edgeInsetValues = [properties[1] componentsSeparatedByString:@","];
    NSString *resizingModeType = [properties[2] capitalizedString];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake([edgeInsetValues[0] floatValue], [edgeInsetValues[1] floatValue], [edgeInsetValues[2] floatValue], [edgeInsetValues[3] floatValue]);
    UIImageResizingMode resizingMode = [resizingModeType isEqualToString:@"tile"]? UIImageResizingModeTile : UIImageResizingModeStretch;
    
    UIImage *imgA = [UIImage imageNamed:filename];
    UIImage *imgB = [imgA resizableImageWithCapInsets:edgeInsets resizingMode:resizingMode];
    return imgB;
}

-(UIImage*) imageFromIconClass:(IconSuper*)icon {
    
    UIImage *iconImage = [UIImage imageWithUIView:icon];
    return iconImage;
}

-(UIView*) getViewForKey:(NSString*)key {
    
    NSString *value = self.viewsData[key];
    
    if([value isEqualToString:@"<ignore>"])
        return nil;
    
    Class ViewClass;
    CGRect rect;
    NSArray *properties = [value componentsSeparatedByString:@":"];
    
    if(properties.count>1){
        
        ViewClass = NSClassFromString(properties[0]);
        
        NSArray *floats = [properties[1] componentsSeparatedByString:@","];
        
        if(floats.count==4){
            rect = CGRectMake([floats[0] floatValue], [floats[1] floatValue], [floats[2] floatValue], [floats[3] floatValue]);
        }else{
            rect = CGRectZero;
        }
        
    }else{
        
        ViewClass = NSClassFromString(value);
        rect = CGRectZero;
    }
    
    UIView *v = [(UIView*)[ViewClass alloc] initWithFrame:rect];
    
    return v;
}


#pragma mark - Setters

-(void) setFilename:(NSString *)filename {
    
    _filename = filename;
}

#pragma mark - Getters

-(NSDictionary*) configData {
    
    if(nil == _configData){
        _configData = self.styleData[@"config"];
    }
    return _configData;
}

-(NSDictionary*) colorsData {
    
    if(nil == _colorsData){
        _colorsData = self.styleData[@"colors"];
    }
    return _colorsData;
}

-(NSDictionary*) fontsData {
    
    if(nil == _fontsData){
        _fontsData = self.styleData[@"fonts"];
    }
    return _fontsData;
}

-(NSDictionary*) metricsData {
    
    if(nil == _metricsData){
        _metricsData = self.styleData[@"metrics"];
    }
    return _metricsData;
}

-(NSDictionary*) imagesData {
    
    if(nil == _imagesData){
        _imagesData = self.styleData[@"images"];
    }
    return _imagesData;
}

-(NSDictionary*) viewsData {
    
    if(nil == _viewsData){
        _viewsData = self.styleData[@"views"];
    }
    return _viewsData;
}


#pragma mark - Singleton

+ (StyleManager *)sharedStyleManager{
    
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _instance = [[StyleManager alloc] init];
    });
    
    return _instance;

}

@end
