//
//  TransitionAnimatorDelegate.h
//  ios_learning
//
//  Created by Gideon on 19/07/2017.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TransitionAnimatorDelegate : NSObject <UIViewControllerTransitioningDelegate>
@property(nonatomic,strong)UIPercentDrivenInteractiveTransition * interactive;

@end
