//
//  BubbleView.m
//  WWeChat
//
//  Created by WzxJiang on 16/7/6.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "BubbleView.h"


const CGFloat minHeight = 40;
const CGFloat space     = 5;

@implementation BubbleView {
    UITextView  * _messageTextView;
    UIImageView * _messageImgView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _messageImgView = [UIImageView new];
    [self addSubview: _messageImgView];
    [_messageImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_messageImgView addSubview:[self messageTextView]];
    [_messageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_messageImgView).insets(UIEdgeInsetsMake(space, space, space, space));
    }];
}

- (void)setStatus:(BOOL)isA title:(NSString *)title {
    UIImage * bubbleImg;
    if (isA) {
        bubbleImg = [UIImage imageNamed:@"ReceiverTextNodeBkgHL"];
    } else {
        bubbleImg = [UIImage imageNamed:@"SenderTextNodeBkg"];
    }
    
    UIEdgeInsets insets = UIEdgeInsetsMake(15, 15, 15, 15);
    UIImage *insetImage = [bubbleImg resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    self.image = insetImage;

    _messageTextView.text = title;
}



#pragma mark - lazy load
- (UITextView *)messageTextView {
    if (!_messageTextView) {
        _messageTextView = [UITextView new];
        _messageTextView.backgroundColor = [UIColor clearColor];
        _messageTextView.font = [UIFont systemFontOfSize:14];
    }
    return _messageTextView;
}

@end
