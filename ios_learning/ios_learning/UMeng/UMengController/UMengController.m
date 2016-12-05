//
//  UMengController.m
//  ios_learning
//
//  Created by Gideon on 12/5/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import "UMengController.h"
#import <UShareUI/UMSocialUIManager.h>
#import <UShareUI/UMSocialShareUIConfig.h>
@interface UMengController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation UMengController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 150, 30)];
    self.button.layer.borderColor = [UIColor blueColor].CGColor;
    self.button.layer.borderWidth = 1.0;
    [self.button setTitle:@"弹出分享控件" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

//点击分享按钮
- (IBAction)share:(id)sender {
    __weak typeof(self) weakSelf = self;
    //显示分享面板
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine), @(UMSocialPlatformType_WechatFavorite)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        //参考：http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#7_6_4
        
        
        UMSocialMessageObject *messageObject = [[UMSocialMessageObject alloc] init];
        messageObject.title = @"友盟分享学习";
        messageObject.text = @"集成友盟分享，让运营更加简单";
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"分享标题" descr:@"分享内容描述" thumImage:[UIImage imageNamed:@"faces1.png"]];
        //设置网页地址
        shareObject.webpageUrl =@"http://mobile.umeng.com/social";
        messageObject.shareObject = shareObject;
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            if (error) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"结果" message:@"分享失败" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [weakSelf presentViewController:alert animated:YES completion:^{
                }];

            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"结果" message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [weakSelf presentViewController:alert animated:YES completion:^{
                }];

            }
        }];
    }];
}

@end
