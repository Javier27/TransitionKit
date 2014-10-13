//
//  AnimationController.h
//  TransitionKit
//
//  Created by Richie Davis on 10/5/14.
//  Copyright (c) 2014 Vissix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransitionTypes.h"

@interface AnimationController : UIViewController <UIViewControllerAnimatedTransitioning>

/* if presenting, then use present animation, else use dismissing animation */
@property bool isPresenting;
@property bool callAnimateSubviewsForPresent;
@property bool callAnimateSubviewsForPresenting;
@property bool callAnimateSubviewsForDismiss;
@property bool callAnimateSubviewsForDismissing;
@property TransitionAnimationType animationType;

@property NSTimeInterval transitionPresentationDuration;
@property NSTimeInterval transitionDismissalDuration;
@property CGFloat dampingRatio;
@property CGFloat initialVelocity;

- (void)setSubviewAnimationForPresented:(bool)animatePresentedSubviews forDismissed:(bool)animateDismissedSubviews forPresenting:(bool)animatePresentingSubviews forDismissing:(bool)animateDismissingSubviews;
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
