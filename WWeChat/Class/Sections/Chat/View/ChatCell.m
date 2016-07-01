//
//  ChatCell.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/31.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)changeConstraints {
    _avaterImgViewHeight.constant = ScaleHeight(45);
    _avaterImgViewWidth.constant = ScaleHeight(45);
}

- (void)setModel:(ChatModel *)model {
    [self changeConstraints];
    
    self.nameLabel.text = model.nickName;
    
    self.messagelabel.text = model.message;
    
    self.timeLabel.text = model.time;
    
    [self.avaterImgView yy_setImageWithURL:[NSURL URLWithString:model.avatarUrl] placeholder:UIImageForKitBundle(@"default_avater")];
    
    if (model.noReadNum > 0) {
        NSString * noReadNumStr = [NSString stringWithFormat:@"%d",model.noReadNum];
        CGFloat strWidth = [self giveMeWidthWithStr:noReadNumStr];
        if (strWidth < ScaleHeight(15)) {
            strWidth = ScaleHeight(15);
        }
        UIView * redPoint = [[UIView alloc]initWithFrame:CGRectMake(ScaleHeight(45) - strWidth/2.0, - ScaleHeight(5), strWidth, ScaleHeight(15))];
        redPoint.layer.cornerRadius  = redPoint.frame.size.height/2.0;
        redPoint.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        
        UILabel * numLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, redPoint.frame.size.width, redPoint.frame.size.height)];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.font = [UIFont systemFontOfSize:10];
        numLabel.text = noReadNumStr;
        numLabel.textAlignment = NSTextAlignmentCenter;
        [redPoint addSubview:numLabel];
        
        [self.avaterImgView addSubview:redPoint];
    }
}

- (CGFloat)giveMeWidthWithStr:(NSString *)str {
    UIFont *font = [UIFont systemFontOfSize:10];
    CGRect tmpRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, ScaleHeight(20)) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return tmpRect.size.width;
}
@end
