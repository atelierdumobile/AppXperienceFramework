//
//  AppDelegate.m
//  AppXperience
//
//  Created by fabienLeroi on 1/2/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//

#import "AppDelegate.h"

#import "ParameterViewController.h"

// Ask your key to demo-keys@appxperience.com
#define kAXDevKey @""

@implementation AppDelegate

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Set the developer key to AppXperience
    // AppXperience will not work whis no key
    [[AppXperience sharedManager] setDeveloperKey:kAXDevKey];
    
    // While WS not ready we use test WS
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *viewController1 = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        viewController1 = [[ParameterViewController alloc] initWithNibName:@"ParameterViewController~ipad" bundle:nil];
    } else {
        viewController1 = [[ParameterViewController alloc] initWithNibName:@"ParameterViewController" bundle:nil];
    }
    
    // Call AppXperience to recup OfferwallViewController with no headerView
    // You must use offerWallViewControllerFromTabBar if you want to implement
    // AppXperience offerwall from a tabBar
    UIViewController *viewController2 = [[AppXperience sharedManager] offerWallViewControllerFromTabBar];
    
    // Call AppXperience to recup OfferpageViewController with no back button
    // You must use offerPageViewControllerFromTabBar if you want to implement
    // AppXperience offerpage from a tabBar
    UIViewController *viewController3 = [[AppXperience sharedManager] offerPageViewControllerFromTabBar];
	
    self.tabBarController = [[TabViewController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2, viewController3];
    self.window.rootViewController = self.tabBarController;

	UIViewController *tab2 =  [self.tabBarController.viewControllers objectAtIndex:0];
	tab2.tabBarItem.image = [UIImage imageNamed:@"first.png"];
	tab2.tabBarItem.title = NSLocalizedString(@"Param", @"Param");
    
    UIViewController *tab3 =  [self.tabBarController.viewControllers objectAtIndex:1];
	tab3.tabBarItem.image = [UIImage imageNamed:@"second.png"];
	tab3.tabBarItem.title = NSLocalizedString(@"Offerwal Tab", @"Offerwal Tab");
    
    UIViewController *tab4 =  [self.tabBarController.viewControllers objectAtIndex:2];
	tab4.tabBarItem.image = [UIImage imageNamed:@"second.png"];
	tab4.tabBarItem.title = NSLocalizedString(@"Offerpage Tab", @"Offerpage Tab");
	
    [self.window makeKeyAndVisible];
	
    return YES;
}


@end
