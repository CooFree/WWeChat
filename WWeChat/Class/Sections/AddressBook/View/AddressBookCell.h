//
//  AddressBookCell.h
//  WWeChat
//
//  Created by WzxJiang on 16/7/1.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserObject.h"
@interface AddressBookCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *avaterImgView;
@property (strong, nonatomic)  UILabel *nickNameLabel;

@property(nonatomic, strong)UserObject * model;
@end
