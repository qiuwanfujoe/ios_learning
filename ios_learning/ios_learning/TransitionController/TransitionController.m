//
//  TransitionController.m
//  ios_learning
//
//  Created by Gideon on 19/07/2017.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "TransitionController.h"
#import "PresentViewController.h"
#import "TransitionAnimatorDelegate.h"
#import "CustomPushController.h"
#import "PushTransitionDelegate.h"
@interface TransitionController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *funtionArray;
@property (strong, nonatomic) TransitionAnimatorDelegate *animatorDelegate;
@property (strong, nonatomic) PushTransitionDelegate *pushsDelegate;

@end

@implementation TransitionController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view, typically from a nib.
    self.funtionArray = [@[@"Present", @"Push"] mutableCopy];
    //添加滑动手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(next:)];
    [self.view addGestureRecognizer:pan];
    self.animatorDelegate = [[TransitionAnimatorDelegate alloc] init];
    self.pushsDelegate = [[PushTransitionDelegate alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.funtionArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentify = @"ReuseTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReuseTableCell"];
    }
    cell.textLabel.text = [self.funtionArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [self.funtionArray objectAtIndex:indexPath.row];
    if ([title isEqualToString:@"Present"]) {
        PresentViewController *vc = [[PresentViewController alloc] init];
        vc.transitioningDelegate = self.animatorDelegate;
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    } else if ([title isEqualToString:@"Push"]) {
        CustomPushController *vc = [[CustomPushController alloc] init];
        self.navigationController.delegate = self.pushsDelegate;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)next:(UIPanGestureRecognizer *)recognizer
{
    //获得滑动的比例 0.0 - 1.0之间的数值
    //从右向左滑动的时候为负数
    //从左向右滑动的时候为整数
    NSLog(@"%@",NSStringFromCGPoint([recognizer locationInView:self.view]));
    CGFloat progress = [recognizer translationInView:recognizer.view].x / recognizer.view.bounds.size.width;
    NSLog(@"%f",progress);
    //当滑动开始的时候
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        //初始化交互对象
        self.animatorDelegate.interactive = [[UIPercentDrivenInteractiveTransition alloc]init];
        //推出的视图
        PresentViewController * sec = [[PresentViewController alloc]init];
        //设置推出的视图的代理为自己,这样的话,就能调用UIViewControllerTransitioningDelegate的代理方法
        sec.transitioningDelegate = self.animatorDelegate;
        //推出视图
        [self presentViewController:sec animated:YES completion:nil];
    }else if (recognizer.state == UIGestureRecognizerStateChanged)
    {
        //当状态改变的时候,更新交互界面,也就是界面随着手指运动,从右向左滑动的时候,时progress是负数,取反
        [self.animatorDelegate.interactive updateInteractiveTransition:-progress];
        
    }else if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        //当滑动大于一半的时候,完成转场,否则,取消转场
        if (progress < -0.5) {
            [self.animatorDelegate.interactive finishInteractiveTransition];
        }else
        {
            [self.animatorDelegate.interactive cancelInteractiveTransition];
        }
        self.animatorDelegate.interactive = nil;
    }
}

@end
