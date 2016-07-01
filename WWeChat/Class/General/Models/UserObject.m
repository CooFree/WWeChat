//
//  UserObject.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "UserObject.h"

@implementation FriendObject

- (void)setObjectId:(NSString *)objectId {
    _objectId = objectId;
}

@end


@implementation UserObject

- (NSString *)description {
    return [self yy_modelDescription];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"username"]) {
        [self setValue:value forKey:@"phoneNum"];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"friends"]) {
        NSArray * friends = value;
        RLMArray<FriendObject> * friendObjects = (RLMArray<FriendObject> *)[[RLMArray alloc]initWithObjectClassName:@"FriendObject"];
        for (id friend in friends) {
            FriendObject * friendObject = [FriendObject new];
            friendObject.objectId = friend;
            [friendObjects addObject:friendObject];
        }
        _friends = friendObjects;
    } else {
        [super setValue:value forKey:key];
    }
}

- (NSArray *)friendObjectIds {
    NSMutableArray * friendObjectIds = [NSMutableArray array];
    for (FriendObject * friendObj in _friends) {
        [friendObjectIds addObject:friendObj.objectId];
    }
    return friendObjectIds;
}

- (NSString *)firstPhonetic {
    if (!_nickName) {
        return @"";
    }
    
    if ([_nickName isEqualToString:@""]) {
        return @"#";
    }
    NSMutableString *source = [_nickName mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
    unichar firstChar = [source characterAtIndex:0];
    NSString * firstPhonetic = [NSString stringWithFormat:@"%c",firstChar];
    
    NSString *re = @"[A-Za-z]";
    NSRange range = [firstPhonetic rangeOfString:re options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        return [firstPhonetic uppercaseString];
    }
    else {
        return @"#";
    }
}

@end
