//
//  WWeChatApi.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/2.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WWeChatApi.h"

@implementation WWeChatApi

+ (WWeChatApi *)giveMeApi
{
    static WWeChatApi * api = nil;
    if (api == nil) {
        api = [[WWeChatApi alloc]init];
    }
    return api;
}

- (void)loginWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    [AVUser logInWithUsernameInBackground:userName password:passWord block:^(AVUser *user, NSError *error) {
        if (user != nil)
        {
            //存入objectId
            NSString * objectId = [user objectForKey:@"objectId"];
            [[NSUserDefaults standardUserDefaults]setObject:objectId forKey:wUserID];
            NSLog(@"objectId:%@",objectId);

            NSDictionary * userDic = @{
                                       @"username":user.username,
                                       @"sex":[user objectForKey:@"sex"] == nil ?@"":[user objectForKey:@"sex"],
                                       @"wxID":[user objectForKey:@"wxID"] == nil?@"":[user objectForKey:@"wxID"],
                                       @"avaterUrl":[user objectForKey:@"avaterUrl"] == nil?@"":[user objectForKey:@"avaterUrl"]
                                    };

            [[NSUserDefaults standardUserDefaults]setObject:userDic forKey:wUserInfo];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            successBlock(nil);
        }
        else
        {
            failureBlock(error);
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
            NSLog(@"更改性别成功");
        }
        else
        {
            failureBlock(error);
        }
    }];
    
}

- (void)updataUserNameWithName:(NSString *)name andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    
}
@end
