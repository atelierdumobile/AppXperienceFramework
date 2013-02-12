//
//  SecondViewController.h
//  AppXperience
//
//  Created by fabienLeroi on 1/2/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InAppViewController : UIViewController

@property (strong, nonatomic) UIViewController * offerWallViewController;

- (IBAction)didTouchModalOfferwallButton:(id)sender;

@end
