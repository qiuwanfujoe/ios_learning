//
//  TransitionAnimatorDelegate.m
//  ios_learning
//
//  Created by Gideon on 19/07/2017.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "TransitionAnimatorDelegate.h"
#import "PresentAnimator.h"
#import "DismissAnimator.h"
#import "PresentViewController.h"
#import "TransitionController.h"
@implementation TransitionAnimatorDelegate
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interactive = [[UIPercentDrivenInteractiveTransition alloc]init];
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    if ([source isKindOfClass:[TransitionController class]]) {
        return [[PresentAnimator alloc] init];
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    if ([dismissed isKindOfClass:[PresentViewController class]]) {
        return [[DismissAnimator alloc] init];
    }
    return nil;
}

-(id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactive;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.interactive;
}
@end
