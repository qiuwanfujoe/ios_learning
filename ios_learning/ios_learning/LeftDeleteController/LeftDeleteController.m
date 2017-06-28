//
//  LeftDeleteController.m
//  ios_learning
//
//  Created by Gideon on 23/06/2017.
//  Copyright © 2017 Gideon. All rights reserved.
//

#import "LeftDeleteController.h"
#import "LeftDeleteCell.h"
@interface LeftDeleteController ()
@property (nonatomic,strong) UIView *deleteView;
@property (nonatomic,strong)  UIButton *deleteButton;
@end

@implementation LeftDeleteController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (!cell) {
        cell = [[LeftDeleteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
        CGFloat cellHeight = 44;
        cell.textLabel.text = [NSString stringWithFormat:@"Cell%ld", (long)indexPath.row];
        self.deleteView = [[UIView alloc] init];
        self.deleteView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-160, 0, 160, cellHeight);
        self.deleteView.backgroundColor = [UIColor blueColor];
        CGFloat buttonSize = cellHeight * 0.5;
        self.deleteButton = [[UIButton alloc] init];
        self.deleteButton.frame = CGRectMake(0, (cellHeight - buttonSize) *0.5, buttonSize, buttonSize);
        self.deleteButton.backgroundColor = [UIColor yellowColor];
        self.deleteButton.layer.cornerRadius = buttonSize *0.5;
        self.deleteButton.layer.masksToBounds = YES;
        [self.deleteView addSubview:self.deleteButton];
        
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(80, (cellHeight - buttonSize) *0.5, buttonSize, buttonSize);
        button.backgroundColor = [UIColor blackColor];
        [self.deleteView addSubview:button];
        cell.backgroundColor = [UIColor whiteColor];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        view.backgroundColor = [UIColor redColor];
       // [cell.contentView addSubview:view];
        //[cell insertSubview:self.deleteView belowSubview:cell.contentView];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 自定义左滑显示编辑按钮
-(NSArray<UITableViewRowAction*>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *rowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"//该行可实现设定侧滑button的宽度
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           
                                                                       }];
    rowAction.backgroundColor = [UIColor grayColor];//自定义侧滑控件的背景色
    UITableViewRowAction *rowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"分享"//该行可实现设定侧滑button的宽度
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                                                           
                                                                       }];
    rowAction1.backgroundColor = [UIColor yellowColor];//自定义侧滑控件的背景色
    NSArray *arr = @[rowAction, rowAction1];
    return arr;
}


@end
