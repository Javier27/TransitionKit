//
//  TransitionViewController.h
//  TransitionKit
//
//  Created by Richie Davis on 10/12/14.
//  Copyright (c) 2014 Vissix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionViewController : UIViewController

- (void)animateSubviewsForPresent;
- (void)animateSubviewsForDismiss;
- (void)animateSubviewsForPresenting;
- (void)animateSubviewsForDismissing;

@end