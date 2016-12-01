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

- (void)initRongCloud
{
    [[RCIM sharedRCIM] initWithAppKey:@"4z3hlwrv4xqkt"];
}


@end
