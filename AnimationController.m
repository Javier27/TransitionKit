//
//  AnimationController.m
//  TransitionKit
//
//  Created by Richie Davis on 10/5/14.
//  Copyright (c) 2014 Vissix. All rights reserved.
//

#import "AnimationController.h"
#import "TransitionViewController.h"
#import "TransitionTypes.h"

@implementation AnimationController

- (id)init
{
    self = [super init];
    if (self) {
        self.transitionPresentationDuration = 0.5;
        self.transitionDismissalDuration = 0.5;
        self.transitionPresentationDelay = 0.0;
        self.transitionDismissalDelay = 0.0;
    }
    
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.isPresenting) {
        return self.transitionPresentationDuration;
    } else {
        return self.transitionDismissalDuration;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)ctx
{
    UIView *inView = [ctx containerView];
    UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // call animation
    switch (self.animationType) {
        case TransitionAnimationFromTop:
            [self standardFromTop:ctx :inView :toVC :fromVC];
            break;
        case TransitionAnimationFromBottom:
            [self standardFromBottom:ctx :inView :toVC :fromVC];
            break;
        case TransitionAnimationFromLeft:
            [self standardFromLeft:ctx :inView :toVC :fromVC];
            break;
        case TransitionAnimationDropAndFade:
            [self dropBackAndFade:ctx :inView :toVC :fromVC];
            break;
        default:
            [self standardFromRight:ctx :inView :toVC :fromVC];
            break;
    }
    
    // direct to animation or dismissal
    if (self.isPresenting) {
        if (self.callAnimateSubviewsForPresent) {
            [(TransitionViewController *)[ctx viewControllerForKey:UITransitionContextToViewControllerKey] animateSubviewsForPresent];
        }
        if (self.callAnimateSubviewsForPresenting) {
            [(TransitionViewController *)[ctx viewControllerForKey:UITransitionContextFromViewControllerKey] animateSubviewsForPresenting];
        }
    } else {
        if (self.callAnimateSubviewsForDismiss) {
            [(TransitionViewController *)[ctx viewControllerForKey:UITransitionContextToViewControllerKey] animateSubviewsForDismissing];
        }
        if (self.callAnimateSubviewsForDismissing) {
            [(TransitionViewController *)[ctx viewControllerForKey:UITransitionContextFromViewControllerKey] animateSubviewsForDismiss];
        }
    }
}

- (void)completeAnimation:(id<UIViewControllerContextTransitioning>)ctx
{
    [UIView animateWithDuration: [self transitionDuration:ctx]
                     animations: ^(void) {
                         [ctx completeTransition:YES];
                     }];
}

- (void)completeDismissal:(id<UIViewControllerContextTransitioning>)ctx
{
    [UIView animateWithDuration: [self transitionDuration:ctx]
                     animations: ^(void) {
                         [ctx completeTransition:YES];
                     }];
}

- (void)setSubviewAnimationForPresented:(BOOL)animatePresentedSubviews forDismissed:(BOOL)animateDismissedSubviews forPresenting:(BOOL)animatePresentingSubviews forDismissing:(BOOL)animateDismissingSubviews
{
    self.callAnimateSubviewsForPresent = animatePresentedSubviews;
    self.callAnimateSubviewsForDismiss = animateDismissedSubviews;
    self.callAnimateSubviewsForPresenting = animatePresentingSubviews;
    self.callAnimateSubviewsForDismissing = animateDismissingSubviews;
}

- (void)setDurationForPresentation:(NSTimeInterval)duration
{
    self.transitionPresentationDuration = duration;
}

- (void)setDurationForDismissal:(NSTimeInterval)duration
{
    self.transitionDismissalDuration = duration;
}

- (void)setDurationForPresentationDelay:(NSTimeInterval)delay
{
    self.transitionPresentationDelay = delay;
}

- (void)setDurationForDismissalDelay:(NSTimeInterval)delay
{
    self.transitionDismissalDelay = delay;
}

- (void)setDurationForPresentation:(NSTimeInterval)presentDuration presentationDelay:(NSTimeInterval)presentDelay dismissal:(NSTimeInterval)dismissDuration dismissalDelay:(NSTimeInterval)dismissDelay
{
    self.transitionPresentationDuration = presentDuration;
    self.transitionPresentationDelay = presentDelay;
    self.transitionDismissalDuration = dismissDuration;
    self.transitionDismissalDelay = dismissDelay;
}

// All methods below are for handling the actual animations

- (void)standardFromTop:(id<UIViewControllerContextTransitioning>)ctx :(UIView *)inView :(UIViewController *)toVC :(UIViewController *)fromVC
{
    if (self.isPresenting) {
        toVC.view.frame = CGRectMake(self.view.frame.origin.x, -1*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        [inView addSubview:toVC.view];

        void(^animationBlock)(void) = ^() {
            toVC.view.center = inView.center;
        };
        
        void(^completionBlock)(BOOL) = ^(BOOL finished) {
            [self completeAnimation:ctx];
        };
        
        [self handleAnimationWithAnimation:animationBlock andCompletion:completionBlock];
    } else {
        void(^animationBlock)(void) = ^() {
            CGPoint finalCenter = CGPointMake(inView.center.x, inView.center.y - inView.frame.size.height);
            fromVC.view.center = finalCenter;
        };
        
        void(^completionBlock)(BOOL) = ^(BOOL finished) {
            [self completeDismissal:ctx];
        };
        
        [self handleAnimationWithAnimation:animationBlock andCompletion:completionBlock];
    }
    
}

- (void)standardFromBottom:(id<UIViewControllerContextTransitioning>)ctx :(UIView *)inView :(UIViewController *)toVC :(UIViewController *)fromVC
{
    if (self.isPresenting) {
        toVC.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        [inView addSubview:toVC.view];

        void(^animationBlock)(void) = ^() {
            toVC.view.center = inView.center;
        };
        
        void(^completionBlock)(BOOL) = ^(BOOL finished) {
            [self completeAnimation:ctx];
        };
        
        [self handleAnimationWithAnimation:animationBlock andCompletion:completionBlock];
    } else {
        void(^animationBlock)(void) = ^() {
            CGPoint finalCenter = CGPointMake(inView.center.x, inView.center.y + inView.frame.size.height);
            fromVC.view.center = finalCenter;
        };
        
        void(^completionBlock)(BOOL) = ^(BOOL finished) {
            [self completeDismissal:ctx];
        };
        
        [self handleAnimationWithAnimation:animationBlock andCompletion:completionBlock];
    }
}

- (void)standardFromLeft:(id<UIViewControllerContextTransitioning>)ctx :(UIView *)inView :(UIViewController *)toVC :(UIViewController *)fromVC
{
    if (self.isPresenting) {
        toVC.view.frame = CGRectMake(-1*self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        
        [inView addSubview:toVC.view];

        void(^animationBlock)(void) = ^() {
            toVC.view.center = inView.center;
        };
        
        void(^completionBlock)(BOOL) = ^(BOOL finished) {
            [self completeAnimation:ctx];
        };
        
        [self handleAnimationWithAnimation:animationBlock andCompletion:completionBlock];
    } else {
        void(^animationBlock)(void) = ^() {
            CGPoint finalCenter = CGPointMake(inView.center.x - inView.frame.size.width, inView.center.y);
            fromVC.view.center = finalCenter;
        };
        
        void(^completionBlock)(BOOL) = ^(BOOL finished) {
            [self completeDismissal:ctx];
        };
        
        [self handleAnimationWithAnimation:animationBlock andCompletion:completionBlock];
    }
}

- (void)standardFromRight:(id<UIViewControllerContextTransitioning>)ctx :(UIView *)inView :(UIViewController *)toVC :(UIViewController *)fromVC
{
    if (self.isPresenting) {
        toVC.view.frame = CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        
        [inView addSubview:toVC.view];
        
        void(^animationBlock)(void) = ^() {
            toVC.view.center = inView.center;
        };
        
        void(^completionBlock)(BOOL) = ^(BOOL finished) {
            [self completeAnimation:ctx];
        };
        
        [self handleAnimationWithAnimation:animationBlock andCompletion:completionBlock];
    } else {
        void(^animationBlock)(void) = ^() {
            CGPoint finalCenter = CGPointMake(inView.center.x + inView.frame.size.width, inView.center.y);
            fromVC.view.center = finalCenter;
        };
        
        void(^completionBlock)(BOOL) = ^(BOOL finished) {
            [self completeDismissal:ctx];
        };
        
        [self handleAnimationWithAnimation:animationBlock andCompletion:completionBlock];
    }
}

- (void)dropBackAndFade:(id<UIViewControllerContextTransitioning>)ctx :(UIView *)inView :(UIViewController *)toVC :(UIViewController *)fromVC
{
    if (self.isPresenting) {
        CGPoint centerOffScreen = inView.center;
        centerOffScreen.y = (-1)*inView.frame.size.height;
        toVC.view.center = centerOffScreen;
        
        [inView addSubview:toVC.view];
        
        void(^animationBlock)(void) = ^() {
            fromVC.view.transform = (CGAffineTransformScale(fromVC.view.transform, .8, .8));
            fromVC.view.alpha = 0.5;
            toVC.view.center = inView.center;
        };
        
        void(^completionBlock)(BOOL) = ^(BOOL finished) {
            [self completeAnimation:ctx];
        };
        
        [self handleAnimationWithAnimation:animationBlock andCompletion:completionBlock];
    } else {
        CGPoint centerOffScreen = inView.center;
        centerOffScreen.y = (-1)*inView.frame.size.height;
        
        toVC.view.alpha = 0.5;
        
        void(^animationBlock)(void) = ^() {
            toVC.view.transform = (CGAffineTransformScale(toVC.view.transform, 1/.8, 1/.8));
            toVC.view.alpha = 1.0;
            fromVC.view.center = centerOffScreen;
        };
        
        void(^completionBlock)(BOOL) = ^(BOOL finished) {
            [self completeDismissal:ctx];
        };
        
        [self handleAnimationWithAnimation:animationBlock andCompletion:completionBlock];
    }
    
}

// Helper Methods
- (void)handleAnimationWithAnimation:(void (^)(void))animationBlock andCompletion:(void (^)(BOOL finished))completionOrNil
{
    if (self.isPresenting) {
        [UIView animateWithDuration:self.transitionPresentationDuration delay:self.transitionPresentationDelay options:0 animations:animationBlock completion:completionOrNil];
    } else {
        [UIView animateWithDuration:self.transitionDismissalDuration delay:self.transitionDismissalDelay options:0 animations:animationBlock completion:completionOrNil];
    }
}

@end
