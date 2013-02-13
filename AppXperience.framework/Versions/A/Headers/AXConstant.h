//
//  Constant.h
//  AppXperience
//
//  Created by fabienLeroi on 1/4/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//

/**
 * Application constantes
 */


#define kAXFree @"free"
#define kAXMore @"more"
#define kAXDescription @"Description"
#define kAXDownload @"Download"
#define kAXCancel @"Cancel"
#define KAXWebSite @"Web site"
#define KAXDownloadInformation @"You will quit this app to go to appleStore"

#define kAXFreeTranslation @"AXFreeTranslation"
#define kAXMoreTranslation @"AXMoreTranslation"
#define kAXDownloadTranslation @"AXDownloadTranslation"
#define kAXCancelTranslation @"AXCancelTranslation"
#define kAXDownloadInformationTranslation @"AXDdownloadInformationTranslation"
#define kAXDescriptionTranslation @"AXDescriptionTranslation"

#define kAXLastConnexion @"AXLastConnexionDate"
#define kAXIntervalBeforReload 300

#define kAXDomain @"AXdomain"
#define kAXErrorDataNotValidInWS 406 //not valid object

//#define kAXlogOn 0 //enable or disable log in the framework
#define kAXLogNetworkOn 0 // enable or disable network log (internal use)

typedef enum {
    kAXServerProd = 0,
    kAXServerTest = 1
    //kAXWSDebugStateTest = 2
} AXServerMode;

// height of top section cell
#define kTopSectionCellHeight 130

// time duration for remove the waiting view
#define kRemoveWaitingViewTimeDuration 1

// font PassingNotes
#define kAXPassingNotes @"PassingNotes"

/**
 * Application Macro
 */

#ifdef kAXlogOn
#   define AXDebugLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define AXDebugLightLog(fmt, ...) {NSLog((fmt), ##__VA_ARGS__);}

#else
#   define AXDebugLog(...)
#   define AXDebugLightLog(...)

#endif

#   define AXWarningLog(fmt, ...) {NSLog((@"AX Warning -> %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define AXErrorLog(fmt, ...) {NSLog((@"AX Error -> %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}

/**
 * a simply test to kmow if I am on iPhone 5 or other
 */
#define ASSET_BY_SCREEN_HEIGHT(regular, longScreen) (([[UIScreen mainScreen] bounds].size.height <= 480.0) ? regular : longScreen)

/**
 * Creates an opaque UIColor object from a byte-value color definition.
 */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

/**
 * Creates a UIColor object from a byte-value color definition and alpha transparency.
 */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define AppXperienceFmkBundleName @"AppXperience.bundle"
