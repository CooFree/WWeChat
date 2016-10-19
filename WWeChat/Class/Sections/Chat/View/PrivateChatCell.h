//
//  PrivateCell.h
//  WWeChat
//
//  Created by wordoor－z on 16/3/7.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface PrivateChatCell : UITableViewCell

@property (strong, nonatomic) UIImageView * avaterView;

@property(nonatomic, strong)MessageModel * model;
@end
