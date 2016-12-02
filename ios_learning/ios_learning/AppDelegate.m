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
    }
    return YES;
}

- (void)initRongCloud
{
    [[RCIM sharedRCIM] initWithAppKey:@"4z3hlwrv4xqkt"];
    //设置红包扩展的Url Scheme。
    [[RCIM sharedRCIM] setScheme:@"learningAlipay" forExtensionModule:@"JrmfPacketManager"];
}


@end
