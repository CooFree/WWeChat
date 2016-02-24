//
//  WZXChatTool.m
//  LearnCloudIM
//
//  Created by wordoor－z on 16/2/24.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXChatTool.h"
#import "UserInfoManager.h"
@implementation WZXChatTool

+ (WZXChatTool *)shareTool
{
    static WZXChatTool * tool = nil;
    if (tool == nil)
    {
        tool = [[WZXChatTool alloc]init];
    }
    return tool;
}


- (void)openWithClient:(AVIMClient *)client andSuccessBlock:(void (^)())successBlock andFailureBlock:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    [client openWithCallback:^(BOOL succeeded, NSError *error) {
        if (succeeded == YES)
        {
            [UserInfoManager manager].isOpenIm = YES;
            NSLog(@"打开聊天环境成功");
            successBlock();
        }
        else
        {
            if (error)
            {
                NSLog(@"打开聊天环境错误:%@",error.localizedDescription);
                errorBlock(error);
            }
            else
            {
                NSLog(@"打开聊天环境失败");
                failureBlock();
            }
        }
    }];
}

- (void)createConversationWithClient:(AVIMClient *)client withName:(NSString *)conversationName andClientIds:(NSArray *)clientIds andSuccessBlock:(void (^)(AVIMConversation *))successBlock andFailureBlock:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    [client createConversationWithName:conversationName clientIds:clientIds callback:^(AVIMConversation *conversation, NSError *error) {
        if (error)
        {
            NSLog(@"创建会话错误:%@",error.localizedDescription);
            errorBlock(error);
        }
        else
        {
            if (conversation)
            {
                NSLog(@"创建会话成功");
                successBlock(conversation);
            }
            else
            {
                NSLog(@"创建会话失败");
                failureBlock();
            }
        }
    }];
}

//- (AVIMConversation *)openConversationWithClient:(AVIMClient *)client andConversationId:(NSString *)conversationId
//{
//    if ([client conversationForId:conversationId] == nil)
//    {
//        NSLog(@"查找失败");
//    }
//    else
//    {
//        NSLog(@"成功");
//    }
//    return [client conversationForId:conversationId];
//}

- (void)sendTextMessage:(NSString *)message withConversation:(AVIMConversation *)conversation andSuccessBlock:(void (^)())successBlock andFailureBlock:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    [conversation sendMessage:[AVIMTextMessage messageWithText:message attributes:nil] callback:^(BOOL succeeded, NSError *error) {
        if (succeeded == YES)
        {
            NSLog(@"发送文本信息成功");
            successBlock();
        }
        else
        {
            if (error)
            {
                NSLog(@"发送文本信息错误%@",error.localizedDescription);
                errorBlock(error);
            }
            else
            {
                NSLog(@"发送文本信息失败");
                failureBlock();
            }
        }
    }];
}

- (void)getConversationWithClient:(AVIMClient *)client withMId:(NSString *)mId andSuccessBlock:(void (^)(NSArray *))successBlock andFailureBlock:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock{
    AVIMConversationQuery * query = [client conversationQuery];
     [query whereKey:@"m" containsString:mId];
    [query findConversationsWithCallback:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"请求对话错误%@",error.localizedDescription);
            errorBlock(error);
        }
        else
        {
            if (objects)
            {
                NSLog(@"请求对话成功");
                successBlock(objects);
            }
            else
            {
                NSLog(@"请求对话失败");
                failureBlock();
            }
        }
    }];
}

- (void)getMessageWithConversation:(AVIMConversation *)conversation andLimitNum:(NSInteger)limitNum andSuccessBlock:(void (^)(NSArray *))successBlock andFailureBlock:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    [conversation queryMessagesFromServerWithLimit:limitNum callback:^(NSArray *objects, NSError *error) {
        if (error)
        {
            NSLog(@"获取消息错误:%@",error.localizedDescription);
            errorBlock(error);
        }
        else
        {
            if (objects)
            {
                NSLog(@"获取消息成功");
                successBlock(objects);
            }
            else
            {
                NSLog(@"获取消息失败");
                failureBlock();
            }
        }
    }];
}
@end
