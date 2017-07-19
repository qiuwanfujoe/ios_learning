//
//  PushAnimator.m
//  ios_learning
//
//  Created by Gideon on 19/07/2017.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "PushAnimator.h"

@implementation PushAnimator
// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    fromView.alpha = 1.0;
    toView.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        fromView.alpha = 0;
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        fromView.alpha = 1.0;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
