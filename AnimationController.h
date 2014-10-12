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
@property TransitionAnimationType animationType;
@property NSTimeInterval transitionDuration;
@property CGFloat dampingRatio;
@property CGFloat initialVelocity;

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext;
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
