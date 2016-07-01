//
//  UserObject.h
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface FriendObject : RLMObject

@property(nonatomic,copy)NSString * objectId;

@end
RLM_ARRAY_TYPE(FriendObject);

@interface UserObject : RLMObject

/** ID */
@property(nonatomic,copy)NSString * objectId;

/** 手机号 */
@property(nonatomic,copy)NSString * phoneNum;

/** 昵称 */
@property(nonatomic,copy)NSString * nickName;

/** 微信号 */
@property(nonatomic,copy)NSString * wxID;

/** 头像链接 */
@property(nonatomic,copy)NSString * avaterUrl;

/** 简介 */
@property(nonatomic,copy)NSString * sign;

/** 性别 */
@property(nonatomic,assign)BOOL sex;

/** 朋友 */
@property(nonatomic,copy)RLMArray<FriendObject>* friends;

- (NSArray *)friendObjectIds;

- (NSString *)firstPhonetic;
@end
RLM_ARRAY_TYPE(UserObject)


