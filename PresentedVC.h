//
//  PresentedVC.h
//  TransitionKit
//
//  Created by Richie Davis on 10/11/14.
//  Copyright (c) 2014 Vissix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentedVC : UIViewController
@property (strong, nonatomic) UIView *containerView;

- (void)animateSubviewsForPresent;
- (void)animateSubviewsForDismiss;
- (void)animateSubviewsForPresenting;
- (void)animateSubviewsForDismissing;
@end
