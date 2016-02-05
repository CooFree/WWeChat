//
//  UserInfoManager.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/5.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager

+ (UserInfoManager *)manager
{
    static UserInfoManager * manager = nil;
    if (manager == nil)
    {
        manager = [[UserInfoManager alloc]init];
    }
    return manager;
}

- (NSString *)userName
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return dic[@"username"];
}

- (NSString *)wxID
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return dic[@"wxID"];
}

- (NSString *)avaterUrl
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return dic[@"avaterUrl"];
}

- (BOOL)sex
{
    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
    return [dic[@"sex"]boolValue];
}

@end
