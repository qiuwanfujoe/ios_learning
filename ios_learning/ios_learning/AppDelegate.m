//
//  AppDelegate.m
//  ios_learning
//
//  Created by Gideon on 11/9/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <RongIMKit/RongIMKit.h>
#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *rootVC = [[ViewController alloc] init];
    UINavigationController *navigationVC = [[UINavigationController alloc] initWithRootViewController:rootVC ];
    self.window.rootViewController = navigationVC;
    [self initRongCloud];
    [self initUMeng];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    if ([[RCIM sharedRCIM] openExtensionModuleUrl:url]) {
        return YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[RCIM sharedRCIM] openExtensionModuleUrl:url]) {
        return YES;
    }else if ([[UMSocialManager defaultManager] handleOpenURL:url]) {
        return YES;
    }
    return YES;
}

- (void)initRongCloud
{
    [[RCIM sharedRCIM] initWithAppKey:@"4z3hlwrv4xqkt"];
    //设置红包扩展的Url Scheme。
    [[RCIM sharedRCIM] setScheme:@"learningAlipay" forExtensionModule:@"JrmfPacketManager"];
}

- (void)initUMeng
{
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58455cf8e88bad18ca000fd8"];
    
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx0dc498744b2d7638" appSecret:@"c2fbb4b9f4e8b9123e4ddf9ae2f09fbc" redirectURL:@"http://mobile.umeng.com/social"];
    
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105069449"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"436133357"  appSecret:@"84c5bea419d8a2b84f33074b8c7c662c" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

@end
