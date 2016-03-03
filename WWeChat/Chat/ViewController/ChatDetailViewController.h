//
//  ChatDetailViewController.h
//  WWeChat
//
//  Created by wordoor－z on 16/3/3.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "BaseViewController.h"
@interface ChatDetailViewController : BaseViewController

/**
 *  会话名
 */
@property(nonatomic,copy)NSString * name;

/**
 *  会话ID
 */
@property(nonatomic,copy)NSString * converseID;
@end
