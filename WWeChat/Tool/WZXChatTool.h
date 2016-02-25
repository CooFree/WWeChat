//
//  WZXChatTool.h
//  LearnCloudIM
//
//  Created by wordoor－z on 16/2/24.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloudIM/AVOSCloudIM.h>
@interface WZXChatTool : NSObject

/**
 *  单例
 */
+ (WZXChatTool *)shareTool;

/**
 *  打开聊天环境
 */
- (void)openWithClient:(AVIMClient *)client
       andSuccessBlock:(void(^)())successBlock
       andFailureBlock:(void (^)())failureBlock
       andError:(void(^)(NSError * error))errorBlock;

/**
 *  建立会话
 */
- (void)createConversationWithClient:(AVIMClient *)client
                            withName:(NSString *)conversationName
                            andClientIds:(NSArray *)clientIds
                            andSuccessBlock:(void(^)(AVIMConversation *conversation))successBlock
                            andFailureBlock:(void (^)())failureBlock
                            andError:(void(^)(NSError * error))errorBlock;

///**
// *  打开会话
// */
//- (AVIMConversation *)openConversationWithClient:(AVIMClient *)client andConversationId:(NSString *)conversationId;

/**
 *  发送文字信息
 */
- (void)sendTextMessage:(NSString *)message
       withConversation:(AVIMConversation *)conversation
        andSuccessBlock:(void(^)())successBlock
        andFailureBlock:(void (^)())failureBlock
        andError:(void(^)(NSError * error))errorBlock;

/**
 *  获取对话
 */
- (void)getConversationWithClient:(AVIMClient *)client
                  withMId:(NSString *)mId
                  andSuccessBlock:(void(^)(NSArray * conversations))successBlock
                  andFailureBlock:(void (^)())failureBlock
                  andError:(void(^)(NSError * error))errorBlock;

/**
 *  获取对话中信息
 */
- (void)getMessageWithConversation:(AVIMConversation *)conversation
                   andLimitNum:(NSInteger)limitNum
                   andSuccessBlock:(void(^)(NSArray * messages))successBlock
                   andFailureBlock:(void (^)())failureBlock
                   andError:(void(^)(NSError * error))errorBlock;
@end
