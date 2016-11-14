//
//  TouchIdController.m
//  ios_learning
//
//  Created by Gideon on 11/9/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import "TouchIdController.h"
 #import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIdController ()

@end

@implementation TouchIdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化
    LAContext *context = [LAContext new];
    /** 这个属性用来设置指纹错误后的弹出框的按钮文字
     *  不设置默认文字为“输入密码”
     *  设置@""将不会显示指纹错误后的弹出框
     */
    context.localizedFallbackTitle = @"忘记密码";
    
    NSError *error;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"指纹验证"
                          reply:^(BOOL success, NSError * _Nullable error) {
                              if (success) {
                                  //验证成功执行
                                  NSLog(@"指纹识别成功");
                                  //在主线程刷新view，不然会有卡顿
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      //保存设置状态
                                  });
                              } else {
                                  if (error.code == kLAErrorUserFallback) {
                                      //Fallback按钮被点击执行
                                      NSLog(@"Fallback按钮被点击");
                                  } else if (error.code == kLAErrorUserCancel) {
                                      //取消按钮被点击执行
                                      NSLog(@"取消按钮被点击");
                                  } else {
                                      //指纹识别失败执行
                                      NSLog(@"指纹识别失败");
                                  }
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                  });
                              }
                          }];
        
    }
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

@end
