//
//  PrivateCell.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/7.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "PrivateChatCell.h"
#import "BubbleView.h"

@implementation PrivateChatCell {
    BubbleView * _bubbleView;
    // 上次是B 默认为
    BOOL _lastIsA;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _lastIsA = YES;
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor clearColor];
    
    self.avaterView = [UIImageView new];
    [self.avaterView wzx_addCornerRadius:2];
    [self.contentView addSubview:self.avaterView];
    [self.avaterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(5);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
}

- (void)setModel:(MessageModel *)model {
    _model = model;
    [self.avaterView yy_setImageWithURL:[NSURL URLWithString:@""] placeholder:[UIImage imageNamed:@"default_avater"]];
    
    if (_lastIsA == _model.isLeft) {
        
    } else {
        if (_model.isLeft) {
            [self.avaterView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.left.equalTo(self.contentView).offset(5);
                make.size.mas_equalTo(CGSizeMake(45, 45));
            }];
        } else {
            [self.avaterView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.right.equalTo(self.contentView).offset(-5);
                make.size.mas_equalTo(CGSizeMake(45, 45));
            }];
        }
    }
    
    CGSize size = model.size;
    
    [self.contentView addSubview:[self bubbleView]];
    [_bubbleView setStatus:model.isLeft title:model.message];
    [_bubbleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avaterView);
        
        if (_model.isLeft) {
            make.left.equalTo(self.avaterView.mas_right).offset(5);
        } else {
            make.right.equalTo(self.avaterView.mas_left).offset(-5);
        }
        
        make.size.mas_equalTo(size);
    }];
}

- (BubbleView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [BubbleView new];
    }
    return _bubbleView;
}

@end
