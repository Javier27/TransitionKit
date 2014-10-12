//
//  PresentingVC.h
//  TransitionKit
//
//  Created by Richie Davis on 10/11/14.
//  Copyright (c) 2014 Vissix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionTypes.h"
@class AnimationController;

@interface PresentingVC : UIViewController <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) AnimationController *animationController;
@property (strong, nonatomic) UIView *containerView;

@end
