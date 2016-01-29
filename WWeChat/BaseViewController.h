//
//  BaseViewController.h
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  添加nav上右按钮，图片
 */
- (void)addRightBtnWithImgName:(NSString *)imgName andSelector:(SEL)sel;

/**
 *  添加nav上右按钮，字符串
 */
- (void)addRightBtnWithStr:(NSString *)str andSelector:(SEL)sel;
@end
