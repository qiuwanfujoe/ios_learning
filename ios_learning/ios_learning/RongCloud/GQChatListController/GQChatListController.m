//
//  GQChatListController.m
//  ios_learning
//
//  Created by Gideon on 11/30/16.
//  Copyright © 2016 Gideon. All rights reserved.
//

#import "GQChatListController.h"
#import "GQChatController.h"
#import "GQUserInfoDataSource.h"
NSString *const gideon1_token = @"Qg8/hQpER4qe7wO/nlcWDaFgHT/U7Groa37aXnSD4Yp8jP1gQ3/oh3BeFGhk3/6cbBCIWDxr7Bw=";
NSString *const gideon2_token = @"O+ZQx4E/nmA9LhG4nP8BVdFeUcQ/33FCgm6dJ1qarqZZqk17LL1tPsb8SmgLfi0cmNSN6xGbJnPO4t1P1IG8KQ==";

@implementation GQChatListController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [RCIM sharedRCIM].userInfoDataSource = self;
    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(show)];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    [[RCIM sharedRCIM] connectWithToken:gideon1_token success:^(NSString *userId) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = userId;
        user.name = userId;
        user.portraitUri = @"http://wwc.alicdn.com/avatar/getAvatar.do?userId=869213732&width=160&height=160&type=sns";
        [RCIMClient sharedRCIMClient].currentUserInfo = user;
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
    
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    GQChatController *conversationVC = [[GQChatController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.targetId;
    [self.navigationController pushViewController:conversationVC animated:YES];
}

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
    if ([userId isEqualToString:@"100"]) {
        info.portraitUri = @"http://wwc.alicdn.com/avatar/getAvatar.do?userId=869213732&width=160&height=160&type=sns";
    } else {
        info.portraitUri = @"http://r3.ykimg.com/05140000574CF9C067BC3C261E0132E5";
    }
    completion(info);
}

- (void)show
{
    GQChatController *chat = [[GQChatController alloc] init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    RCUserInfo *user = [RCIMClient sharedRCIMClient].currentUserInfo;
    if ([user.userId isEqualToString:@"100"]) {
        chat.targetId = @"101";
    } else {
        chat.targetId = @"100";
    }
    chat.targetId = chat.targetId;
    //设置聊天会话界面要显示的标题
    chat.title = chat.targetId;
    [self.navigationController pushViewController:chat animated:YES];
}

@end
