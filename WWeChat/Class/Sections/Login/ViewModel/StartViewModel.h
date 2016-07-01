//
//  StartViewModel.h
//  WWeChat
//
//  Created by WzxJiang on 16/6/29.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "BaseViewModel.h"

@interface StartViewModel : BaseViewModel

- (void)autoLoginWithSuccess:(SuccessBlock)successBlock
                     failure:(FailureBlock)failureBlock;

@end
