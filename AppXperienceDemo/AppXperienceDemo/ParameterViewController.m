//
//  FirstViewController.m
//  AppXperience
//
//  Created by fabienLeroi on 1/2/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//

#import "ParameterViewController.h"

@interface ParameterViewController ()


@end

@implementation ParameterViewController

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)viewDidAppear:(BOOL)animated {
    // Use [AppXperience sharedManager] lastConnexionDate] if you want to have the last
    // connexion date
    NSString *dateStr = [NSDateFormatter localizedStringFromDate:[[AppXperience sharedManager] lastConnexionDate]
                                                        dateStyle:NSDateFormatterShortStyle
                                                        timeStyle:NSDateFormatterShortStyle];
    
    [self.lastConnexionL setText:dateStr];
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (IBAction)didClickModalButton:(id)sender {
    if (!self.offerWallViewController) {
        // Call AppXperience to recup Offerwall controller with headerView
        self.offerWallViewController = [[AppXperience sharedManager] offerWallViewControllerFromModal];
    }
    
    // Set frame to offerwallViewController's view
    self.offerWallViewController.view.frame = self.view.frame;
    
    // Present offerwallViewController
    // You must use presentViewController:animated:completion: with
    // offerWallViewControllerFromModal
    [self presentViewController:self.offerWallViewController animated:YES completion:nil];
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (IBAction)didClickInterstitalButton:(id)sender {
    
    // adding waintingView bg
    UIView *bgBlack = [[UIView alloc] initWithFrame:self.view.bounds];
    [bgBlack setBackgroundColor:RGBACOLOR(0, 0, 0, 0.7f)];
    [self.view addSubview:bgBlack];
    
    // adding waintingView activityIndicator
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator sizeToFit];
    [activityIndicator startAnimating];
    CGRect frame = activityIndicator.frame;
    frame.origin.x = (self.view.bounds.size.width - frame.size.width) / 2;
    frame.origin.y = (self.view.bounds.size.height - frame.size.height) / 2;
    activityIndicator.frame = frame;
    [self.view addSubview:activityIndicator];
    
    
    // Use prepareInterstitialWithCompletion:error: to recup interstitialViewController
    [[AppXperience sharedManager] prepareInterstitialWithCompletion:^(UIViewController *interstitialViewController) {
        // do what ever you want…
		//in this demo we remove our loading
        [activityIndicator removeFromSuperview];
        [bgBlack removeFromSuperview];
        
        // Present interstitialViewController
        // You must use presentViewController:animated:completion: with
        // the controller 
        [self presentViewController:interstitialViewController animated:YES completion:nil];
        
    } error:^(NSError *error) {
        // remove waiting View
        [activityIndicator removeFromSuperview];
        [bgBlack removeFromSuperview];
    }];
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (IBAction)didTouchFetchDataButton:(id)sender {
    // Prepare data for not have to wait when you call offerWallViewControllerFromModa
    // You can use numberNewApps to indicate the number of new application since last connexion
    [[AppXperience sharedManager] prepareOrRefreshOfferWallDataWithCompletion:^(BOOL success, NSNumber *numberNewApps) {
        if (success) {
            [self.numberOfNewAppsL setText:[numberNewApps stringValue]];
            
            // Use [AppXperience sharedManager] lastConnexionDate] if you want to have the last
            // connexion date
            NSString *dateStr = [NSDateFormatter localizedStringFromDate:[[AppXperience sharedManager] lastConnexionDate]
                                                               dateStyle:NSDateFormatterShortStyle
                                                               timeStyle:NSDateFormatterShortStyle];
            
            [self.lastConnexionL setText:dateStr];
        }
    } error:^(NSError *error) {
        
    }];
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)viewDidUnload {
    [self setLastConnexionL:nil];
    [self setNumberOfNewAppsL:nil];
    [super viewDidUnload];
}

@end
