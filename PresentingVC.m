//
//  PresentingVC.m
//  TransitionKit
//
//  Created by Richie Davis on 10/11/14.
//  Copyright (c) 2014 Vissix. All rights reserved.
//

#import "PresentingVC.h"
#import "PresentedVC.h"
#import "AnimationController.h"

@implementation PresentingVC

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.animationController = [[AnimationController alloc] init];
    
    // hide the status bar
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    UIButton *button;
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    [titles addObject:@[@"Top",@"DropAndFade",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp"]];
    [titles addObject:@[@"Bottom",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp"]];
    [titles addObject:@[@"Left",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp"]];
    [titles addObject:@[@"Right",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp",@"Temp"]];
    
    CGFloat width = self.view.frame.size.width/4;
    CGFloat height = self.view.frame.size.height/8;
    for (int x=0; x<4; x++) {
        for (int y=0; y<8; y++) {
            button = [[UIButton alloc] initWithFrame:CGRectMake(x*width, y*height, width, height)];
            [button setBackgroundColor:[UIColor colorWithRed:1-((float)x+1)/5 green:1-((float)x+(float)y+1)/12 blue:1-((float)y+1)/9 alpha:1.0]];
            [button setTitle:titles[x][y] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(changeViews:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }
}

- (void)changeViews:(id)sender
{
    UIButton *button = sender;
    TransitionAnimationType transitionAnimation;
    
    if ([button.titleLabel.text isEqualToString:@"Top"]) {
        transitionAnimation = TransitionAnimationFromTop;
    } else if ([button.titleLabel.text isEqualToString:@"Bottom"]) {
        transitionAnimation = TransitionAnimationFromBottom;
    } else if ([button.titleLabel.text isEqualToString:@"Left"]) {
        transitionAnimation = TransitionAnimationFromLeft;
    } else if ([button.titleLabel.text isEqualToString:@"DropAndFade"]) {
        transitionAnimation = TransitionAnimationDropAndFade;
    } else {
        transitionAnimation = TransitionAnimationFromRight;
    }
    
    self.animationController.animationType = transitionAnimation;
    
    PresentedVC *controller = [[PresentedVC alloc] init];
    controller.transitioningDelegate = self;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    self.animationController.isPresenting = YES;
    return self.animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animationController.isPresenting = NO;
    return self.animationController;
}

@end
