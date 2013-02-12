//
//  SecondViewController.m
//  AppXperience
//
//  Created by fabienLeroi on 1/2/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//

#import "InAppViewController.h"

@interface InAppViewController ()

@end

@implementation InAppViewController

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (IBAction)didTouchModalOfferwallButton:(id)sender {
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
@end
