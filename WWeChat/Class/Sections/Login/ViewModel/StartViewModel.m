//
//  StartViewModel.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/29.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "StartViewModel.h"

@implementation StartViewModel

- (void)autoLoginWithSuccess:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self.manager GET:@"login" version:V1_1 parameters:nil success:^(id response, NSInteger code) {
        if (code == 200) {
            [WZXKeyChain saveToken:response[@"sessionToken"]];
            [Statics saveCurrentUserWithDic:response];
        }
        successBlock(response, code);
    } failure:^(NSError *error) {
        failureBlock(error);
    }];
}

@end
