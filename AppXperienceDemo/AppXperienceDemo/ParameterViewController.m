//
//  FirstViewController.m
//  AppXperience
//
//  Created by fabienLeroi on 1/2/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//

#import "ParameterViewController.h"

#define kAppXperienceKey @"AppXperienceKey"

@interface ParameterViewController ()

@property (strong, nonatomic) UIViewController * offerWallViewController;
@property (strong, nonatomic) UIViewController * offerPageViewController;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView *bannerView;

@property (strong, nonatomic) IBOutlet UILabel *offerwalLastConnexionL;
@property (strong, nonatomic) IBOutlet UILabel *offerwallNumberOfNewAppsL;
@property (strong, nonatomic) IBOutlet UILabel *offerpageLastConnexionL;
@property (strong, nonatomic) IBOutlet UILabel *offerpageNumberOfNewAppsL;
@property (strong, nonatomic) IBOutlet UILabel *versionL;

@property (strong, nonatomic) IBOutlet UITextField *keyTextField;
@property (strong, nonatomic) IBOutlet UITextField *offerwallDetailTimerDurationTF;
@property (strong, nonatomic) IBOutlet UITextField *bannerScrollDurationTF;


// offerwall
- (IBAction)didClickModalButton:(id)sender;
- (IBAction)didTouchFetchDataButton:(id)sender;
- (IBAction)didTouchChangeDeveloperKey:(id)sender;
- (IBAction)didTouchPurgeDataButton:(id)sender;
- (IBAction)didClickChangeOfferwallDetailTimerDurationButton:(id)sender;

// offerpage
- (IBAction)didClickOfferpageModalButton:(id)sender;
- (IBAction)didClickOfferpagePrefetchData:(id)sender;
- (IBAction)didClickOfferpagePurgeData:(id)sender;

// interstitial
- (IBAction)didClickInterstitalButton:(id)sender;

// banner
- (IBAction)didClickBannerButton:(id)sender;
- (IBAction)didClickChangeBannerScrollDurationButton:(id)sender;


@end

@implementation ParameterViewController

#pragma mark - init

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)viewDidLoad {
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
        self.scrollView.contentSize = self.scrollView.frame.size;
        self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [self.view addSubview:self.scrollView];
    }
    
    NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    
    self.versionL.text = [NSString stringWithFormat:@"Demo version: %@ - Fmk version: %@", versionString, [AppXperience sharedManager].version];
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)viewDidAppear:(BOOL)animated {
    // Use [AppXperience sharedManager] offerwallLastConnexionDate] if you want to have the last connexion date
    NSString *dateStr = [NSDateFormatter localizedStringFromDate:[[AppXperience sharedManager] offerwallLastConnexionDate]
                                                        dateStyle:NSDateFormatterShortStyle
                                                        timeStyle:NSDateFormatterShortStyle];
    
    [self.offerwalLastConnexionL setText:dateStr];
    
    dateStr = [NSDateFormatter localizedStringFromDate:[[AppXperience sharedManager] offerpageLastConnexionDate]
                                             dateStyle:NSDateFormatterShortStyle
                                             timeStyle:NSDateFormatterShortStyle];
    
    [self.offerpageLastConnexionL setText:dateStr];
    
    NSString *key = [[NSUserDefaults standardUserDefaults] stringForKey:kAppXperienceKey];
    if (key != nil && [key isEqualToString:@""] == NO) {
        self.keyTextField.text = key;
        [[AppXperience sharedManager] setDeveloperKey:key];
    }
}

#pragma mark - offerwall

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
- (IBAction)didTouchFetchDataButton:(id)sender {    
    // Prepare data for not have to wait when you call offerWallViewControllerFromModal
    // You can use numberNewApps to indicate the number of new application since last connexion
    [[AppXperience sharedManager] prepareOrRefreshOfferWallDataWithCompletion:^(NSNumber *numberNewApps) {
        [self.offerwallNumberOfNewAppsL setText:[numberNewApps stringValue]];
        
        // Use [AppXperience sharedManager] lastConnexionDate] if you want to have the last
        // connexion date
        NSString *dateStr = [NSDateFormatter localizedStringFromDate:[[AppXperience sharedManager] offerwallLastConnexionDate]
                                                           dateStyle:NSDateFormatterShortStyle
                                                           timeStyle:NSDateFormatterShortStyle];
        
        [self.offerwalLastConnexionL setText:dateStr];
    } error:^(NSError *error) {
        
    }];
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (IBAction)didTouchChangeDeveloperKey:(id)sender {
    [self.keyTextField resignFirstResponder];
    
    [[NSUserDefaults standardUserDefaults] setValue:self.keyTextField.text forKey:kAppXperienceKey];
    
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
    [[AppXperience sharedManager] setAppSelectorClosingDuration:delay];
    
    
    self.offerWallViewController = nil;// create a new offerwall
}

#pragma mark - interstitial

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
        // You must use presentViewController:animated:completion: with the controller
        [self presentViewController:interstitialViewController animated:YES completion:nil];
        
    } error:^(NSError *error) {
        // remove waiting View
        [activityIndicator removeFromSuperview];
        [bgBlack removeFromSuperview];
    }];
}

#pragma mark - offerpage

- (IBAction)didClickOfferpageModalButton:(id)sender {    
    if (!self.offerPageViewController) {
        self.offerPageViewController = [[AppXperience sharedManager] offerPageViewControllerFromModal];
    }
    
    self.offerPageViewController.view.frame = self.view.frame;
    
    [self presentViewController:self.offerPageViewController animated:YES completion:nil];
}

- (IBAction)didClickOfferpagePrefetchData:(id)sender {    
    [[AppXperience sharedManager] prepareOrRefreshOfferPageDataWithCompletion:^(NSNumber *numberNewApps) {
        [self.offerpageNumberOfNewAppsL setText:[numberNewApps stringValue]];
        
        NSString *dateStr = [NSDateFormatter localizedStringFromDate:[[AppXperience sharedManager] offerpageLastConnexionDate]
                                                           dateStyle:NSDateFormatterShortStyle
                                                           timeStyle:NSDateFormatterShortStyle];
        
        [self.offerpageLastConnexionL setText:dateStr];
    } error:^(NSError *error) {
        
    }];
}

- (IBAction)didClickOfferpagePurgeData:(id)sender {    
    self.offerPageViewController = nil;
    [[AppXperience sharedManager] purgeOfferpageDatas];
}

#pragma mark - banner

- (IBAction)didClickBannerButton:(id)sender {
    [[AppXperience sharedManager] prepareBannerWithCompletion:^(UIView *view) {
        [self.bannerView addSubview:view];
    } error:^(NSError *error) {
        
    }];
}

- (IBAction)didClickChangeBannerScrollDurationButton:(id)sender {
    [self.bannerScrollDurationTF resignFirstResponder];
    
    // Set the banner scrool timer duration to AppXperience objet.
    // This will be use for the banner scrool.
    CGFloat delay = [self.bannerScrollDurationTF.text floatValue];
    [[AppXperience sharedManager] setBannerScrollDuration:delay];
}

#pragma mark - memory

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)viewDidUnload {
    [self setOfferwalLastConnexionL:nil];
    [self setOfferwallNumberOfNewAppsL:nil];
    [self setKeyTextField:nil];
    [self setKeyTextField:nil];
    [self setOfferwallDetailTimerDurationTF:nil];
    [self setScrollView:nil];
    [self setOfferpageNumberOfNewAppsL:nil];
    [self setOfferpageLastConnexionL:nil];
    [self setBannerView:nil];
    [self setVersionL:nil];
    [self setBannerScrollDurationTF:nil];
    [super viewDidUnload];
}

#pragma mark - UITextFieldDelegate

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - Orientation


//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{    return NO;
//
//}
//- (NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationPortrait;
//}

@end
