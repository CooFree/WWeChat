//
//  WZXTimeStampToTimeTool.m
//  WWeChat
//
//  Created by wordoor－z on 16/2/27.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "WZXTimeStampToTimeTool.h"
@interface WZXTimeStampToTimeTool()

@property(nonatomic,copy)NSDateFormatter * formatter;

@end
@implementation WZXTimeStampToTimeTool

+ (WZXTimeStampToTimeTool *)tool
{
    static WZXTimeStampToTimeTool * tool = nil;
    if (tool == nil)
    {
        tool = [[WZXTimeStampToTimeTool alloc]init];
    }
    return tool;
}

- (NSDictionary *)timeStampToTimeToolWithTimeStamp:(NSTimeInterval)timeStamp andScale:(NSInteger)scale
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStamp/pow(10, scale)];
    
//    NSDate *datenow = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:datenow];
//    NSDate   *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    
    return [self strToDicWithStr:[self.formatter stringFromDate:confromTimesp]];
}

- (NSDictionary *)locationTime
{
    NSDate *datenow = [NSDate date];
    
    return [self strToDicWithStr:[self.formatter stringFromDate:datenow]];
}

- (NSDictionary *)strToDicWithStr:(NSString *)str
{
    NSMutableDictionary * muDic = [[NSMutableDictionary alloc]init];
    
    NSArray * arr = [str componentsSeparatedByString:@"-"];
    
    [muDic setObject:arr[0] forKey:@"year"];
    
    [muDic setObject:arr[1] forKey:@"month"];
    
    [muDic setObject:arr[2] forKey:@"day"];
    
    [muDic setObject:arr[3] forKey:@"hour"];
    
    [muDic setObject:arr[4] forKey:@"minute"];
    
    [muDic setObject:arr[5] forKey:@"second"];
    
    return [muDic copy];
}

- (NSDateFormatter *)formatter
{
    if (!_formatter)
    {
        _formatter = [[NSDateFormatter alloc]init];
        
        [_formatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
    }
    return _formatter;
}

- (NSString *)compareWithTimeDic:(NSDictionary *)timeDic
{
    
   NSDictionary * nowDic = [self locationTime];
    NSString * timeStr = @"";
    if ([timeDic[@"year"] isEqualToString: nowDic[@"year"]]
        && [timeDic[@"month"] isEqualToString: nowDic[@"month"]]
        && [timeDic[@"day"] isEqualToString: nowDic[@"day"]])
    {
        timeStr = [NSString stringWithFormat:@"%@:%@",timeDic[@"hour"],timeDic[@"minute"]];
    }
    return timeStr;
}

@end
