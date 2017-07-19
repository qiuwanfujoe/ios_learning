//
//  PresentViewController.m
//  ios_learning
//
//  Created by Gideon on 19/07/2017.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "PresentViewController.h"
#import "TransitionAnimatorDelegate.h"
@interface PresentViewController ()
@property (strong, nonatomic) TransitionAnimatorDelegate *animatorDelegate;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)];
    [self.view addGestureRecognizer:pan];
    self.animatorDelegate = [[TransitionAnimatorDelegate alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dismiss:(UIPanGestureRecognizer *)recognizer
{
    self.transitioningDelegate = self.animatorDelegate;
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.animatorDelegate.interactive = [[UIPercentDrivenInteractiveTransition alloc]init];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.animatorDelegate.interactive updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.5) {
            [self.animatorDelegate.interactive finishInteractiveTransition];
        }else
        {
            [self.animatorDelegate.interactive cancelInteractiveTransition];
        }
        self.animatorDelegate.interactive = nil;
    }
}

@end
