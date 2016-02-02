//
//  WWeChatApi.h
//  WWeChat
//
//  Created by 王子轩 on 16/2/2.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVOSCloud/AVOSCloud.h>

@interface WWeChatApi : NSObject

/**
 *  单例
 */
+ (WWeChatApi *)giveMeApi;

/**
 *  登录
 */
- (void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void(^)(id response))successBlock andFailure:(void(^)(NSError * error))failureBlock;

/**
 *  注册
 */
- (void)registerWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;
@end
