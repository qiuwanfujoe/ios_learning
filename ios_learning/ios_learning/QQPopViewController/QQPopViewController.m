//
//  ViewController.m
//  QQ_PopMenu_Demo
//
//  Created by Transuner on 16/3/17.
//  Copyright © 2016年 吴冰. All rights reserved.
//

#import "QQPopViewController.h"
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"

@interface QQPopViewController ()
@property (nonatomic, strong) UIButton *button;

@end

@implementation QQPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 150, 30)];
    self.button.layer.borderColor = [UIColor blueColor].CGColor;
    self.button.layer.borderWidth = 1.0;
    [self.button setTitle:@"弹出浮层" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(PopMenuClik:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}
- (void)PopMenuClik:(id)sender {
    
    
    NSMutableArray *obj = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self titles].count; i++) {
        
        WBPopMenuModel * info = [WBPopMenuModel new];
        info.image = [self images][i];
        info.title = [self titles][i];
        [obj addObject:info];
    }
   
    [[WBPopMenuSingleton shareManager]showPopMenuSelecteWithFrame:150
                                                             item:obj
                                                           action:^(NSInteger index) {
        NSLog(@"index:%ld",(long)index);
        
    }];
}

- (NSArray *) titles {
    return @[@"扫一扫",
             @"加好友",
             @"创建讨论组",
             @"发送到电脑",
             @"面对面快传",
             @"收钱"];
}

- (NSArray *) images {
    return @[@"right_menu_QR@3x",
             @"right_menu_addFri@3x",
             @"right_menu_multichat@3x",
             @"right_menu_sendFile@3x",
             @"right_menu_facetoface@3x",
             @"right_menu_payMoney@3x"];
}

@end
