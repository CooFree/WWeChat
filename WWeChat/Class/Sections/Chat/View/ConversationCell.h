//
//  ChatCell.h
//  WWeChat
//
//  Created by wordoor－z on 16/1/31.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZXConversation.h"
@interface ConversationCell : UITableViewCell

/**
 *  头像imgView
 */
@property (strong, nonatomic) UIImageView *avaterImgView;

/**
 *  名字Label
 */
@property (strong, nonatomic) UILabel *nameLabel;

/**
 *  信息Label
 */
@property (strong, nonatomic) UILabel *messagelabel;

/**
 *  时间Label
 */
@property (strong, nonatomic) UILabel *timeLabel;

/**
 *  model
 */
@property (strong, nonatomic) WZXConversation *model;

@property (strong, nonatomic) UIView * unreadView;

@end
