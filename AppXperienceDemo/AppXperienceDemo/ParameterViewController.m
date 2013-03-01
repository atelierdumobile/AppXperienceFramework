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
    [bgBlack setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f]];
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
    [[AppXperience sharedManager] prepareOrRefreshOfferWallDataWithCompletion:^(NSNumber *numberNewApps) {
        [self.numberOfNewAppsL setText:[numberNewApps stringValue]];
        
        // Use [AppXperience sharedManager] lastConnexionDate] if you want to have the last
        // connexion date
        NSString *dateStr = [NSDateFormatter localizedStringFromDate:[[AppXperience sharedManager] lastConnexionDate]
                                                           dateStyle:NSDateFormatterShortStyle
                                                           timeStyle:NSDateFormatterShortStyle];
        
        [self.lastConnexionL setText:dateStr];
    } error:^(NSError *error) {
        
    }];
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (IBAction)didTouchChangeDeveloperKey:(id)sender {
    [self.keyTextField resignFirstResponder];
    
    // Set the developer key to AppXperience objet.
    // This key will be use for Offerwall and Interstitial.
    [[AppXperience sharedManager] setDeveloperKey:self.keyTextField.text];
    
    self.offerWallViewController = nil;// create a new offerwall
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (IBAction)didTouchPurgeDataButton:(id)sender {
    self.offerWallViewController = nil;// create a new offerwall
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (IBAction)didClickChangeOfferwallDetailTimerDurationButton:(id)sender {
    [self.offerwallDetailTimerDurationTF resignFirstResponder];
    
    // Set the offerwall's detail timer duration to AppXperience objet.
    // This will be use for the left menu first close in offerwall's detail.
    // Set -1 if the menu don't need to close automaticaly
    CGFloat delay = [self.offerwallDetailTimerDurationTF.text floatValue];
    [[AppXperience sharedManager] setOfferwallDetailTimerDuration:delay];
    
    
    self.offerWallViewController = nil;// create a new offerwall
    
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)viewDidUnload {
    [self setLastConnexionL:nil];
    [self setNumberOfNewAppsL:nil];
    [self setKeyTextField:nil];
    [self setKeyTextField:nil];
    [self setOfferwallDetailTimerDurationTF:nil];
    [super viewDidUnload];
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

@end
