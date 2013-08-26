//
//  TabViewController.m
//  AppXperienceFMKIntegration
//
//  Created by fabienLeroi on 6/28/13.
//  Copyright (c) 2013 AppXperience. All rights reserved.
//

#import "TabViewController.h"

@implementation TabViewController


#pragma marks Interface orientation
//Specific definition to fix orientation for the tabbar

//iOS5
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	if (interfaceOrientation == UIInterfaceOrientationPortrait) {
		return YES;
	}
	else {
		return NO;
	}
	
}
//iOS6
- (BOOL)shouldAutorotate {
    return YES;
}
//iOS6
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
