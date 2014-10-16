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
@property BOOL isPresenting;
@property BOOL callAnimateSubviewsForPresent;
@property BOOL callAnimateSubviewsForPresenting;
@property BOOL callAnimateSubviewsForDismiss;
@property BOOL callAnimateSubviewsForDismissing;
@property TransitionAnimationType animationType;

@property NSTimeInterval transitionPresentationDuration;
@property NSTimeInterval transitionDismissalDuration;
@property NSTimeInterval transitionPresentationDelay;
@property NSTimeInterval transitionDismissalDelay;
@property CGFloat dampingRatio;
@property CGFloat initialVelocity;

- (void)setSubviewAnimationForPresented:(BOOL)animatePresentedSubviews forDismissed:(BOOL)animateDismissedSubviews forPresenting:(BOOL)animatePresentingSubviews forDismissing:(BOOL)animateDismissingSubviews;
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)setDurationForPresentation:(NSTimeInterval)presentDuration presentationDelay:(NSTimeInterval)presentDelay dismissal:(NSTimeInterval)dismissDuration dismissalDelay:(NSTimeInterval)dismissDelay;

@end
