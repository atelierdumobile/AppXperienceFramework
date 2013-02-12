//
//  FirstViewController.h
//  AppXperience
//
//  Created by fabienLeroi on 1/2/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AXOfferwallViewController;

@interface ParameterViewController : UIViewController

@property (strong, nonatomic) UIViewController * offerWallViewController;

@property (strong, nonatomic) IBOutlet UILabel *lastConnexionL;
@property (strong, nonatomic) IBOutlet UILabel *numberOfNewAppsL;

- (IBAction)didClickModalButton:(id)sender;
- (IBAction)didClickInterstitalButton:(id)sender;
- (IBAction)didTouchFetchDataButton:(id)sender;

@end
