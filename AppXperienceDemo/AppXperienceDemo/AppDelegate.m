//
//  AppDelegate.m
//  AppXperience
//
//  Created by fabienLeroi on 1/2/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//

#import "AppDelegate.h"

#import "ParameterViewController.h"

#import "InAppViewController.h"

@implementation AppDelegate

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
	

	
    // Set the developer key to AppXperience objet.
    // This key will be use for Offerwall and Interstitial.
    // AppXperience will not work whis no key
    [[AppXperience sharedManager] setDeveloperKey:@"ABCDEF"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *viewController1 = [[InAppViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    UIViewController *viewController2 = [[ParameterViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    
    // Call AppXperience to recup OfferwallViewController with no headerView
    // You must use offerWallViewControllerFromTabBar if you want to implement
    // AppXperience offerwall from a tabBar
    UIViewController *viewController3 = [[AppXperience sharedManager] offerWallViewControllerFromTabBar];
	
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2, viewController3];
    self.window.rootViewController = self.tabBarController;
	
	UIViewController *tab1 =  [self.tabBarController.viewControllers objectAtIndex:0];
	tab1.tabBarItem.image = [UIImage imageNamed:@"first.png"];
	tab1.tabBarItem.title = NSLocalizedString(@"From App", @"From Tab");
	
	UIViewController *tab2 =  [self.tabBarController.viewControllers objectAtIndex:1];
	tab2.tabBarItem.image = [UIImage imageNamed:@"second.png"];
	tab2.tabBarItem.title = NSLocalizedString(@"Param", @"From Tab");
    
    UIViewController *tab3 =  [self.tabBarController.viewControllers objectAtIndex:2];
	tab3.tabBarItem.image = [UIImage imageNamed:@"second.png"];
	tab3.tabBarItem.title = NSLocalizedString(@"From Tab", @"From Tab");
	
    [self.window makeKeyAndVisible];
	
    return YES;
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
