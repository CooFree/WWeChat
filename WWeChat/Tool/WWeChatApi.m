//
//  WWeChatApi.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/2.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WWeChatApi.h"
#import "UserInfoManager.h"
@implementation WWeChatApi

+ (WWeChatApi *)giveMeApi
{
    static WWeChatApi * api = nil;
    if (api == nil) {
        api = [[WWeChatApi alloc]init];
    }
    return api;
}

- (void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id))successBlock andFailure:(void (^)())failureBlock andError:(void (^)(NSError *))errorBlock
{
    MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [AVUser logInWithUsernameInBackground:userName password:passWord block:^(AVUser *user, NSError *error) {
        if (error)
        {
             NSLog(@"登录错误:%@",error.localizedDescription);
            errorBlock(error);
            [hub hideAnimated:YES];
        }
        else
        {
            if (user != nil)
            {
                //存入objectId
                NSString * objectId = [user objectForKey:@"objectId"];
                [[NSUserDefaults standardUserDefaults]setObject:objectId forKey:wUserID];
                NSLog(@"objectId:%@",objectId);
                
                NSDictionary * userDic = @{
                                           @"mid":[user objectForKey:@"username"] == nil ?@"":[user objectForKey:@"username"],
                                           @"nickName":[user objectForKey:@"nickName"] == nil ?@"":[user objectForKey:@"nickName"],
                                           
                                           @"sex":[user objectForKey:@"sex"] == nil ?@"":[user objectForKey:@"sex"],
                                           
                                           @"wxID":[user objectForKey:@"wxID"] == nil?@"":[user objectForKey:@"wxID"],
                                           
                                           @"avaterUrl":[user objectForKey:@"avaterUrl"] == nil?@"":[user objectForKey:@"avaterUrl"],
                                           
                                           @"sign":[user objectForKey:@"sign"] == nil?@"":[user objectForKey:@"sign"]
                                           };
                
                [[NSUserDefaults standardUserDefaults]setObject:userDic forKey:wUserInfo];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                [UserInfoManager manager].isLogin = YES;
                
                 NSLog(@"登录成功");
                [hub hideAnimated:YES];
                successBlock(nil);
            }
            else
            {
                NSLog(@"登录失败");
                [hub hideAnimated:YES];
                failureBlock();
            }
        }
    }];
}

- (void)registerWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock
{
    AVUser * user = [AVUser user];
    user.username = userName;
    user.password = passWord;

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];
}

- (void)updataAvaterWithImg:(UIImage *)img andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    
    NSData *imageData = UIImagePNGRepresentation(img);
    AVFile *imageFile = [AVFile fileWithName:@"image.png" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
        if (succeeded)
        {
            AVUser *currentUser = [AVUser currentUser];
            currentUser[@"avaterUrl"] = imageFile.url;
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
             {
                if (succeeded)
                {
                    NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
                    NSMutableDictionary * muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
                    [muDic setObject:imageFile.url forKey:@"avaterUrl"];
                    [[NSUserDefaults standardUserDefaults]setObject:[muDic copy] forKey:wUserInfo];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    successBlock(imageFile.url);
                }
                else
                {
                    failureBlock(error);
                }
            }];

        }
        
    } progressBlock:^(NSInteger percentDone) {
        
    }];
    
}

- (void)updataSexWithIsMan:(BOOL)isMan andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    AVUser *currentUser = [AVUser currentUser];
    currentUser[@"sex"] = [NSNumber numberWithInt:isMan];
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
            NSMutableDictionary * muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
            [muDic setObject:[NSNumber numberWithInt:isMan] forKey:@"sex"];
            [[NSUserDefaults standardUserDefaults]setObject:[muDic copy] forKey:wUserInfo];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"更改性别成功");
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];
    
}

- (void)updataUserNameWithName:(NSString *)name andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    AVUser *currentUser = [AVUser currentUser];
    currentUser[@"nickName"] = name;
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
            NSMutableDictionary * muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
            [muDic setObject:name forKey:@"nickName"];
            [[NSUserDefaults standardUserDefaults]setObject:[muDic copy] forKey:wUserInfo];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"更改昵称成功");
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
        }
    }];
}

@end
