//
//  AppXperience.h
//  AppXperience
//
//  Created by fabienLeroi on 1/4/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AppXperience/AXConstant.h>


typedef void (^AXAppXperienceBlock)(BOOL success, NSNumber *numberNewApps);
typedef void (^AXControllerBlock)(UIViewController* interstitialViewController);
typedef void (^AXErrorBlock)(NSError* error);

// The singleton object from which you can configure and access the AppXperience data.
@interface AppXperience : NSObject

@property (nonatomic, strong) NSString *developerKey;
@property (nonatomic, assign) BOOL testMode;
@property (nonatomic, assign) AXServerMode serverMode;

/// Singleton access
/// @return the singleton instance
+ (AppXperience *)sharedManager;

/// Set the developer key that use to know who request the server
/// @param key the developer
- (void) setDeveloperKey:(NSString *)key;

/// This methode call the model to get interstitial data and return an InterstitialViewController in the block
/// @param completion return an Interstitial controller with data
/// @param error return an error if data can't be download
-(void) prepareInterstitialWithCompletion:(AXControllerBlock) completion
                                    error:(AXErrorBlock) error;


/// This method fetch the offerwall data
/// @param completion return a boolean success that tell you if data is fetch and numberNewApp give you the number of new application since last connexion
/// @param error return an error if data can't be download
- (void) prepareOrRefreshOfferWallDataWithCompletion:(AXAppXperienceBlock) completion
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

/// Return the last connexion date since offerwallData has been fetch.
///
/// @return return the date
- (NSDate *) lastConnexionDate;

/// This methode purge all the saved datas
- (void) purgeDatas;

@end
