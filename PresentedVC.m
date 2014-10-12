//
//  PresentedVC.m
//  TransitionKit
//
//  Created by Richie Davis on 10/11/14.
//  Copyright (c) 2014 Vissix. All rights reserved.
//

#import "PresentedVC.h"

@implementation PresentedVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        self.containerView.center = self.view.center;
        [self.view addSubview:self.containerView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(0, 0, 300, 300);
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"lovers"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(removeView:) forControlEvents:UIControlEventTouchDown];
        [self.containerView addSubview:button];
        self.containerView.transform = CGAffineTransformScale(self.containerView.transform, .01, .01);
    }
}

- (void)removeView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
