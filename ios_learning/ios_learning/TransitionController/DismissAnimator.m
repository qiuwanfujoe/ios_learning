//
//  DismissAnimator.m
//  ios_learning
//
//  Created by Gideon on 19/07/2017.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "DismissAnimator.h"

@implementation DismissAnimator
// This is used for percent driven interactive transitions, as well as for
// container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //拿到上下文的view,相当于一个舞台
    UIView * view = [transitionContext containerView];
    //则 fromeView 就是B,
    //则 toView    就是A
    UIView * fromeView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    UIView * toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    //根据动画的样式不同,两个view摆放的位置不同,这里的动画时模仿navController pop时候的滑动返回效果
    //所以,把将要出现的view放在自己下边
    [view insertSubview:toView belowSubview:fromeView];
    //开始动画
    [UIView animateWithDuration:1.0 animations:^{
        //让自己走出一个屏幕
        fromeView.transform = CGAffineTransformMakeTranslation(375, 0);
    } completion:^(BOOL finished) {
        //完成时候一定要调用这个方法,不然会发生意想不到的情况
        //这个方法标志者动画的完成
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
