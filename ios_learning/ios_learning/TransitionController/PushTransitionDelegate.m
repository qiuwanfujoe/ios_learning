//
//  PushTransitionDelegate.m
//  ios_learning
//
//  Created by Gideon on 19/07/2017.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "PushTransitionDelegate.h"
#import "PushAnimator.h"
#import "PopAnimator.h"
#import "CustomPushController.h"
@implementation PushTransitionDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if ([toVC isKindOfClass:[CustomPushController class]] && operation == UINavigationControllerOperationPush) {
        return [[PushAnimator alloc] init];
    } else if ([fromVC isKindOfClass:[CustomPushController class]] && operation == UINavigationControllerOperationPop) {
        return [[PopAnimator alloc] init];
    }
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return nil;//需要手势交互的时候可设置UIPercentDrivenInteractiveTransition
}

@end
