//
//  PersonCell.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/29.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "PersonCell.h"
#import "UIImageView+WebCache.h"
@implementation PersonCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PersonModel *)model
{
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    [self.avaterImgView setImageWithURL:[NSURL URLWithString:_model.avater] placeholderImage:[UIImage imageNamed:@"avater.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
    }];
    
    self.userNameLabel.text = model.nickName;
    
    self.weIDLabel.text = [NSString stringWithFormat:@"微信号: %@",model.weID];
    
    self.wmImgView.image = [UIImage imageNamed:@"me_wm"];
    self.wmImgView.backgroundColor = [UIColor grayColor];
    
}

//懒加载
- (UIImageView *)avaterImgView
{
    if (!_avaterImgView)
    {
        _avaterImgView = ({
        
            UIImageView * avaterImgView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(12), WGiveHeight(12), self.frame.size.height - 2*WGiveHeight(12), self.frame.size.height - 2*WGiveHeight(12))];
            
            avaterImgView.clipsToBounds = YES;
            
            //加点圆角
            avaterImgView.layer.cornerRadius = 3;
            
            avaterImgView;
        });
        [self addSubview:_avaterImgView];
    }
    return _avaterImgView;
}

- (UILabel *)userNameLabel
{
    if (!_userNameLabel)
    {
        _userNameLabel = ({
        
            UILabel * userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height - 2*WGiveHeight(12) + 2*WGiveWidth(12), WGiveHeight(19), WGiveWidth(160), WGiveHeight(22))];
            
            userNameLabel.font = [UIFont systemFontOfSize:15];
            
            userNameLabel;
        });
        [self addSubview:_userNameLabel];
    }
    return _userNameLabel;
}

- (UILabel *)weIDLabel
{
    if (!_weIDLabel)
    {
        _weIDLabel = ({
            
            UILabel * weIDLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height - 2*WGiveHeight(12) + 2*WGiveWidth(12), _userNameLabel.frame.origin.y + _userNameLabel.frame.size.height + WGiveHeight(5), WGiveWidth(160), WGiveHeight(20))];
            
            weIDLabel.font = [UIFont systemFontOfSize:12];
            
            weIDLabel;
        });
        [self addSubview:_weIDLabel];
    }
    return _weIDLabel;
}

- (UIImageView *)wmImgView
{
    if (!_wmImgView)
    {
        _wmImgView = ({
        
            UIImageView * wmImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - WGiveWidth(50),((self.frame.size.height - WGiveHeight(35/2.0))/2.0), WGiveWidth(35/2.0), WGiveWidth(35/2.0))];
            
            wmImgView;
        });
        [self addSubview:_wmImgView];
    }
    return _wmImgView;
}

@end
