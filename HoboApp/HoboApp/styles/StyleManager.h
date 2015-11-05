//
//  StyleManager.h
//  Engager
//
//  Created by Lee Probert on 22/04/2013.
//
//

// PLIST FILENAME KEY IN INFO PLIST
#define kStylesFilenameInfoKey @"Application styles filename"
#define kStylesDefaultFontName @"Avenir"

#import <Foundation/Foundation.h>

@interface StyleManager : NSObject

@property (nonatomic, assign) BOOL isLoaded;
@property (nonatomic, strong) NSString* filename;
@property (nonatomic, strong) NSDictionary* styleData;
@property (nonatomic, strong) NSDictionary* configData;
@property (nonatomic, strong) NSDictionary* colorsData;
@property (nonatomic, strong) NSDictionary* metricsData;
@property (nonatomic, strong) NSDictionary* fontsData;
@property (nonatomic, strong) NSDictionary* imagesData;
@property (nonatomic, strong) NSDictionary* viewsData;

-(UIColor*) getColorForStyleKey:(NSString*)key;
-(UIFont*) getFontForStyleKey:(NSString*)key;
-(UIImage*) getImageForStyleKey:(NSString*)key;
-(NSNumber*) getMetricForKey:(NSString*)key;
-(NSNumber*) getConfigForKey:(NSString*)key;
-(UIView*) getViewForKey:(NSString*)key;

-(void) loadStyles;

+ (StyleManager *)sharedStyleManager;

@end
