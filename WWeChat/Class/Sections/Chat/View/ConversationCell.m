//
//  ChatCell.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/31.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ConversationCell.h"
#import "WZXTimeTool.h"
@implementation ConversationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.avaterImgView = [UIImageView new];
    [self.avaterImgView wzx_addCornerRadius:2];
    [self.contentView addSubview:self.avaterImgView];
    [self.avaterImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(5);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avaterImgView).offset(-45/4.0);
        make.left.equalTo(self.avaterImgView.mas_right).offset(8);
    }];
    
    self.messagelabel = [UILabel new];
    self.messagelabel.font = [UIFont systemFontOfSize:13];
    self.messagelabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.messagelabel];
    [self.messagelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avaterImgView).offset(45/4.0);
        make.left.equalTo(self.nameLabel);
    }];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    self.timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-5);
    }];
    
    
    self.unreadView = [UIView new];
    [self.unreadView wzx_addCornerRadius:5];
    [self.contentView addSubview:self.unreadView];
    [self.unreadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avaterImgView).offset(-5);
        make.right.equalTo(self.avaterImgView).offset(5);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
}

- (void)setModel:(WZXConversation *)model {
    self.nameLabel.text = model.conversationTitle;
    [self.avaterImgView yy_setImageWithURL:[NSURL URLWithString:model.conversationAvaterUrl] placeholder:[UIImage imageNamed:@"default_avater"]];
    
    self.messagelabel.text = model.lastMessage;
    
    self.timeLabel.text = [WZXTimeTool compareWithTime:model.lastMessageTime];
    
    if (model.unreadMessageCount > 0) {
        self.unreadView.backgroundColor = [UIColor redColor];
    } else {
        self.unreadView.backgroundColor = [UIColor clearColor];
    }
}

@end
