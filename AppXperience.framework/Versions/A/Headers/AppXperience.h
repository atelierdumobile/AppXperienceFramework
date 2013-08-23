//
//  AppXperience.h
//  AppXperience
//
//  Created by fabienLeroi on 1/4/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void (^AXAppXperienceBlock)(NSNumber *numberNewApps);
typedef void (^AXBannerBlock)(UIView *view);
typedef void (^AXControllerBlock)(UIViewController* controller);
typedef void (^AXErrorBlock)(NSError* error);

typedef enum {
    kAXServerProd = 0,
	kAXServerPreprod = 1,
    kAXServerDev = 2
} AXServerMode;

#define kAXServerMode @"AXServerMode"


typedef enum {
    kAXInterstitialAppOfTheDay = 0,
	kAXInterstitialImage = 1,
    kAXInterstitialVideo = 2,
    kAXInterstitialVideoWithImage = 3
} AXInterstitialMode;

#define kAXInterstitialMode @"AXInterstitialMode"


// The singleton object from which you can configure and access the AppXperience data.
@interface AppXperience : NSObject

/// Your developer key to identify yourself on appXperience. (Mandatory)
@property (nonatomic, strong) NSString *developerKey;

/// Timer for the left menu close duration in offerwall's detail
/// Optional : by default it's automatiquely closing after delay
/// Set -1 to force user to close menu manually
@property (nonatomic, assign) CGFloat appSelectorClosingDuration;

/// Timer for the scrollview in the baner
/// Optional : by default 3s
@property (nonatomic, assign) CGFloat bannerScrollDuration;

/// Singleton access
/// @return the singleton instance
+ (AppXperience *)sharedManager;

/// This methode call the model to get interstitial data and return an InterstitialViewController in the block
/// @param completion return an Interstitial controller with data
/// @param error return an error if data can't be download
-(void) prepareInterstitialWithCompletion:(AXControllerBlock) completion
                                    error:(AXErrorBlock) error;

/// This methode call the model to get banner data and return an BannerView in the block
/// @param completion return an banner view with data
/// @param error return an error if data can't be download
-(void) prepareBannerWithCompletion:(AXBannerBlock) completion
                              error:(AXErrorBlock) error;


/// This method fetch the offerwall data
/// @param completion numberNewApp give you the number of new application since last connexion
/// @param error return an error if data can't be download
- (void) prepareOrRefreshOfferWallDataWithCompletion:(AXAppXperienceBlock) completion
                                               error:(AXErrorBlock) error;

/// This method fetch the offerpage data
/// @param completion numberNewApp give you the number of new application since last connexion
/// @param error return an error if data can't be download
- (void) prepareOrRefreshOfferPageDataWithCompletion:(AXAppXperienceBlock) completion
                                               error:(AXErrorBlock) error;

/// Return the view controller of the offerwall.
/// You need to retain it. This will always return a new view.
///
/// @return return the offerwall view controller
- (UIViewController *) offerWallViewControllerFromTabBar;

/// Return the view controller of the offerwall with headerView.
/// You need to retain it. This will always return a new view.
///
/// @return return the offerwall view controller
- (UIViewController *) offerWallViewControllerFromModal;

/// Return the view controller of the offerpage.
/// You need to retain it. This will always return a new view.
///
/// @return return the offerpage view controller
- (UIViewController *) offerPageViewControllerFromTabBar;

/// Return the view controller of the offerpage with headerView.
/// You need to retain it. This will always return a new view.
///
/// @return return the offerpage view controller
- (UIViewController *) offerPageViewControllerFromModal;

/// Return the last connexion date since offerwallData has been fetch.
///
/// @return return the date
- (NSDate *) offerwallLastConnexionDate;

/// Return the last connexion date since offerpage Data has been fetch.
///
/// @return return the date
- (NSDate *) offerpageLastConnexionDate;

/// This methode purge all the offerwall saved datas
- (void) purgeOfferwallDatas;

/// This methode purge all the offerpage saved datas
- (void) purgeOfferpageDatas;

/// Get the version number of the fmk
- (NSString *) version;

@end
