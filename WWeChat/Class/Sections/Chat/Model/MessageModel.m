//
//  MessageModel.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/7.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "MessageModel.h"
@implementation MessageModel

- (instancetype)initWithMessage:(RCMessage *)message {
    self = [super init];
    if (self) {
        if ([message.content isMemberOfClass:[RCTextMessage class]]) {
            RCTextMessage * textMessage = (RCTextMessage *)message.content;
            self.messageType = MessageTypeNone;
            self.message = textMessage.content;
        } else if ([message.content isMemberOfClass:[RCImageMessage class]]) {
            RCImageMessage * textMessage = (RCImageMessage *)message.content;
            self.messageType = MessageTypeImg;
            self.message = textMessage.imageUrl;
        }
        
        self.isLeft = [message.senderUserId isEqualToString:[Statics currentUser].objectId];
        self.timestamp = message.sentTime;
        self.sentID = message.senderUserId;
    }
    return self;
}

- (void)setMessage:(id)message {
    _message = message;
    CGSize textSize = [message boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
    
    _size = CGSizeMake(textSize.width + 2 * 5 + 15, textSize.height + 2 * 5);
    
    if (_size.height < 45) {
        _size = CGSizeMake(_size.width, 45);
    }
    
    if (_size.width < 60) {
        _size = CGSizeMake(60, _size.height);
    }
    
}

@end
