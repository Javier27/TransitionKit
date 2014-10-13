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
    // direct to animation or dismissal
    if (self.isPresenting) {
        [self animatePresentTransition:ctx];
        if (self.callAnimateSubviewsForPresent) {
            [(TransitionViewController *)[ctx viewControllerForKey:UITransitionContextToViewControllerKey] animateSubviewsForPresent];
        }
        if (self.callAnimateSubviewsForPresenting) {
            [(TransitionViewController *)[ctx viewControllerForKey:UITransitionContextFromViewControllerKey] animateSubviewsForPresenting];
        }
    } else {
        [self animateDismissTransition:ctx];
        if (self.callAnimateSubviewsForDismiss) {
            [(TransitionViewController *)[ctx viewControllerForKey:UITransitionContextToViewControllerKey] animateSubviewsForDismissing];
        }
        if (self.callAnimateSubviewsForDismissing) {
            [(TransitionViewController *)[ctx viewControllerForKey:UITransitionContextFromViewControllerKey] animateSubviewsForDismiss];
        }
    }
}

- (void)animatePresentTransition:(id<UIViewControllerContextTransitioning>)ctx
{
    switch (self.animationType) {
        case TransitionAnimationFromTop:
            [self standardFromTop:ctx :YES];
            break;
        case TransitionAnimationFromBottom:
            [self standardFromBottom:ctx :YES];
            break;
        case TransitionAnimationFromLeft:
            [self standardFromLeft:ctx :YES];
            break;
        case TransitionAnimationDropAndFade:
            [self dropBackAndFade:ctx :YES];
            break;
        default:
            [self standardFromRight:ctx :YES];
            break;
    }
}

- (void)animateDismissTransition:(id<UIViewControllerContextTransitioning>)ctx
{
    switch (self.animationType) {
        case TransitionAnimationFromTop:
            [self standardFromTop:ctx :NO];
            break;
        case TransitionAnimationFromBottom:
            [self standardFromBottom:ctx :NO];
            break;
        case TransitionAnimationFromLeft:
            [self standardFromLeft:ctx :NO];
            break;
        case TransitionAnimationDropAndFade:
            [self dropBackAndFade:ctx :NO];
            break;
        default:
            [self standardFromRight:ctx :NO];
            break;
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
    UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
    [UIView animateWithDuration: [self transitionDuration:ctx]
                     animations: ^(void) {
                         [ctx completeTransition:YES];
                         [[[UIApplication sharedApplication] keyWindow] addSubview:toVC.view];
                     }];
}

- (void)setSubviewAnimationForPresented:(bool)animatePresentedSubviews forDismissed:(bool)animateDismissedSubviews forPresenting:(bool)animatePresentingSubviews forDismissing:(bool)animateDismissingSubviews
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

// All methods below are for handling the actual animations

- (void)standardFromTop:(id<UIViewControllerContextTransitioning>)ctx :(bool)present
{
    if (present) {
        UIView *inView = [ctx containerView];
        UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        toVC.view.frame = CGRectMake(self.view.frame.origin.x, -1*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        [inView addSubview:toVC.view];
        [UIView animateWithDuration:0.5 animations:^(void){
            toVC.view.center = inView.center;
        } completion:^(bool finished){
            [self completeAnimation:ctx];
        }];
    } else {
        UIView *inView = [ctx containerView];
        UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        // fromVC.view.alpha = 1.0;
        
        CGPoint finalCenter = CGPointMake(inView.center.x, inView.center.y - inView.frame.size.height);
        
        [inView insertSubview:toVC.view belowSubview:fromVC.view];
        [UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^(void){
            fromVC.view.center = finalCenter;
        } completion:^(bool finished) {
            [self completeDismissal:ctx];
        }];
    }
    
}

- (void)standardFromBottom:(id<UIViewControllerContextTransitioning>)ctx :(bool)present
{
    if (present) {
        UIView *inView = [ctx containerView];
        UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        toVC.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
        [inView addSubview:toVC.view];
        [UIView animateWithDuration:0.5 animations:^(void){
            toVC.view.center = inView.center;
        } completion:^(bool finished){
            [self completeAnimation:ctx];
        }];
    } else {
        UIView *inView = [ctx containerView];
        UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        // fromVC.view.alpha = 1.0;
        
        CGPoint finalCenter = CGPointMake(inView.center.x, inView.center.y + inView.frame.size.height);
        
        [inView insertSubview:toVC.view belowSubview:fromVC.view];
        [UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^(void){
            fromVC.view.center = finalCenter;
        } completion:^(bool finished) {
            [self completeDismissal:ctx];
        }];
    }
}

- (void)standardFromLeft:(id<UIViewControllerContextTransitioning>)ctx :(bool)present
{
    if (present) {
        UIView *inView = [ctx containerView];
        UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        toVC.view.frame = CGRectMake(-1*self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        
        [inView addSubview:toVC.view];
        [UIView animateWithDuration:0.5 animations:^(void){
            toVC.view.center = inView.center;
        } completion:^(bool finished){
            [self completeAnimation:ctx];
        }];
    } else {
        UIView *inView = [ctx containerView];
        UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        // fromVC.view.alpha = 1.0;
        
        CGPoint finalCenter = CGPointMake(inView.center.x - inView.frame.size.width, inView.center.y);
        
        [inView insertSubview:toVC.view belowSubview:fromVC.view];
        [UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^(void){
            fromVC.view.center = finalCenter;
        } completion:^(bool finished) {
            [self completeDismissal:ctx];
        }];
    }
}

- (void)standardFromRight:(id<UIViewControllerContextTransitioning>)ctx :(bool)present
{
    if (present) {
        UIView *inView = [ctx containerView];
        UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        toVC.view.frame = CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        
        [inView addSubview:toVC.view];
        [UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^(void){
            toVC.view.center = inView.center;
        } completion:^(bool finished) {
            [self completeAnimation:ctx];
        }];
    } else {
        UIView *inView = [ctx containerView];
        UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        // fromVC.view.alpha = 1.0;
        
        CGPoint finalCenter = CGPointMake(inView.center.x + inView.frame.size.width, inView.center.y);
        
        [inView insertSubview:toVC.view belowSubview:fromVC.view];
        [UIView animateWithDuration:0.5 delay:0.5 options:0 animations:^(void){
            fromVC.view.center = finalCenter;
        } completion:^(bool finished) {
            [self completeDismissal:ctx];
        }];
    }
}

- (void)dropBackAndFade:(id<UIViewControllerContextTransitioning>)ctx :(bool)present
{
    if (present) {
        UIView *inView = [ctx containerView];
        UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        CGPoint centerOffScreen = inView.center;
        centerOffScreen.y = (-1)*inView.frame.size.height;
        toVC.view.center = centerOffScreen;
        
        [inView addSubview:toVC.view];
        
        
        [UIView animateWithDuration:0.5 animations:^(void){
            fromVC.view.transform = (CGAffineTransformScale(fromVC.view.transform, .8, .8));
            fromVC.view.alpha = 0.5;
            toVC.view.center = inView.center;
        } completion:^(bool finished){
            [self completeAnimation:ctx];
        }];
    } else {
        UIView *inView = [ctx containerView];
        UIViewController *toVC = [ctx viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromVC = [ctx viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        CGPoint centerOffScreen = inView.center;
        centerOffScreen.y = (-1)*inView.frame.size.height;
        
        [inView insertSubview:toVC.view belowSubview:fromVC.view];
        toVC.view.alpha = 0.5;
        
        [UIView animateWithDuration:0.5 delay:0.5 options:0
                         animations:^(void) {
                             toVC.view.transform = (CGAffineTransformScale(toVC.view.transform, 1/.8, 1/.8));
                             toVC.view.alpha = 1.0;
                             fromVC.view.center = centerOffScreen;
                         } completion:^(bool finished){
                             [self completeDismissal:ctx];
                         }];
    }
    
}

@end
