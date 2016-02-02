//
//  ChatCell.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/31.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatCell.h"
#import "UIImageView+WebCache.h"

@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//更改约束
- (void)changeConstraints
{
    _avaterImgViewHeight.constant = WGiveHeight(45);
    _avaterImgViewWidth.constant = WGiveHeight(45);
}

- (void)setModel:(ChatModel *)model
{
    
    [self changeConstraints];
    
    [self.avaterImgView setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:[UIImage imageNamed:@"avater.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
    }];
    
    self.nameLabel.text = model.userName;
    
    self.messagelabel.text = model.message;
    
    self.timeLabel.text = model.time;
}

@end
