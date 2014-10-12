//
//  TransitionTypes.h
//  TransitionKit
//
//  Created by Richie Davis on 10/11/14.
//  Copyright (c) 2014 Vissix. All rights reserved.
//

@interface TransitionTypes : NSObject

typedef enum : NSInteger {
    TransitionAnimationFromTop,
    TransitionAnimationFromBottom,
    TransitionAnimationFromLeft,
    TransitionAnimationFromRight,
    TransitionAnimationDropAndFade
} TransitionAnimationType;

@end
