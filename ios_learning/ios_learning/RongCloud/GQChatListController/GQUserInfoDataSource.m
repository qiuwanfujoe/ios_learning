//
//  GQUserInfoDataSource.m
//  ios_learning
//
//  Created by Gideon on 11/30/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import "GQUserInfoDataSource.h"
#import <RongIMKit/RongIMKit.h>

@implementation GQUserInfoDataSource
/*!
 获取用户信息
 
 @param userId      用户ID
 @param completion  获取用户信息完成之后需要执行的Block [userInfo:该用户ID对应的用户信息]
 
 @discussion SDK通过此方法获取用户信息并显示，请在completion中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion
{
    RCUserInfo *info = [[RCUserInfo alloc] init];
    info.userId = userId;
    info.name = userId;
    info.portraitUri = @"http://wwc.alicdn.com/avatar/getAvatar.do?userId=869213732&width=160&height=160&type=sns";
    completion(info);
}
@end
