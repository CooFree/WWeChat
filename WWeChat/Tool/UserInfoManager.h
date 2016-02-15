//
//  UserInfoManager.h
//  WWeChat
//
//  Created by 王子轩 on 16/2/5.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject

+ (UserInfoManager *)manager;

/**
 *  用户名
 */
- (NSString *)userName;

/**
 *  微信号
 */
- (NSString *)wxID;

/**
 *  用户头像url
 */
- (NSString *)avaterUrl;

/**
 *  性别 默认为男
 */
- (BOOL)sex;

/**
 *  个性签名
 */
- (NSString *)sign;
@end
