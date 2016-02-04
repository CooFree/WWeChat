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
    AVQuery *query = [AVQuery queryWithClassName:wUserClass];
    
    [query whereKey:@"username" equalTo:userName];
    
    [query whereKey:@"passWord" equalTo:passWord];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count>0)
            {
                //存入userID
                NSString * userID = [objects[0] objectForKey:@"objectId"];
                [[NSUserDefaults standardUserDefaults]setObject:userID forKey:wUserID];
                NSLog(@"userID:%@",userID);
                successBlock(nil);
            }
        } else
        {
            failureBlock(error);
        }
    }];
}

- (void)registerWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andSuccess:(void (^)(id response))successBlock andFailure:(void (^)(NSError * error))failureBlock
{
    AVObject * user = [AVObject objectWithClassName:wUserClass];
    
    user[@"username"] = userName;
    
    user[@"password"] = @"123";
    
    user[@"passWord"] = passWord;
    
    AVQuery *query = [AVQuery queryWithClassName:wUserClass];
    
    [query whereKey:@"username" equalTo:userName];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count == 0)
            {
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (successBlock)
                    {
                        successBlock(nil);
                    }
                    else
                    {
                        failureBlock(error);
                    }
                }];
            }
            else
            {
                failureBlock(nil);
            }
        } else {
            failureBlock(error);
        }
    }];
}

- (void)updataAvaterWithImg:(UIImage *)img andSuccess:(void (^)(id))successBlock andFailure:(void (^)(NSError *))failureBlock
{
    NSString * userId = [[NSUserDefaults standardUserDefaults]objectForKey:wUserID];
    
    NSData *imageData = UIImagePNGRepresentation(img);
    AVFile *imageFile = [AVFile fileWithName:@"image.png" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    
    } progressBlock:^(NSInteger percentDone) {
        
    }];
    
}
@end
