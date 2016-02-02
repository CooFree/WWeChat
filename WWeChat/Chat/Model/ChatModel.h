//
//  ChatModel.h
//  WWeChat
//
//  Created by wordoor－z on 16/1/29.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject

/**
 *  头像
 */
@property (nonatomic,copy)NSString * avatar;

/**
 *  名字
 */
@property (nonatomic,copy)NSString * userName;

/**
 *  信息
 */
@property (nonatomic,copy)NSString * message;

/**
 *  时间
 */
@property (nonatomic,copy)NSString * time;

@end
