//
//  WZXChatTool.m
//  LearnCloudIM
//
//  Created by wordoor－z on 16/2/24.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXChatTool.h"
#import "UserInfoManager.h"
@implementation WZXChatTool

+ (WZXChatTool *)shareTool
{
    static WZXChatTool * tool = nil;
    if (tool == nil)
    {
        tool = [[WZXChatTool alloc]init];
    }
    return tool;
}


@end
