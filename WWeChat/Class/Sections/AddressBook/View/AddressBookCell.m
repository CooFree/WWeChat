//
//  AddressBookCell.m
//  WWeChat
//
//  Created by WzxJiang on 16/7/1.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "AddressBookCell.h"

@implementation AddressBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.avaterImgView = [UIImageView new];
    [self.contentView addSubview:self.avaterImgView];
    [self.avaterImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    self.nickNameLabel = [UILabel new];
    [self.contentView addSubview:self.nickNameLabel];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.avaterImgView.mas_right).offset(15);
    }];
}

- (void)setModel:(UserObject *)model {
    [self.avaterImgView yy_setImageWithURL:[NSURL URLWithString:model.avaterUrl] placeholder:[UIImage imageNamed:@"default_avater"]];
    self.nickNameLabel.text    = model.nickName;
}

@end
