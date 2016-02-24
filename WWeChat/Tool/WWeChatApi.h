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

/**
 *  上传图片
 */
- (void)updataAvaterWithImg:(UIImage *)img andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;

/**
 *  更改性别
 */
- (void)updataSexWithIsMan:(BOOL)isMan andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;

/**
 *  更改用户名
 */
- (void)updataUserNameWithName:(NSString *)name andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock;

@end
