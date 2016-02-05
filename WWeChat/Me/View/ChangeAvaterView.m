//
//  ChangeAvaterView.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/5.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChangeAvaterView.h"

@implementation ChangeAvaterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        self.userInteractionEnabled = YES;
        
        UIControl * control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [control addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        
        [self createPopView];
    }
    return self;
}

- (void)createPopView
{
    _popView = ({
        
        UIView * popView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, WGiveHeight(150))];
        popView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:231/255.0 alpha:1];
        popView;
    });
    [self addSubview:self.popView];
    
    _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cameraBtn.backgroundColor = [UIColor whiteColor];
    _cameraBtn.frame = CGRectMake(0, 0, self.frame.size.width, WGiveHeight(46));
    [_cameraBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [_cameraBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_popView addSubview:_cameraBtn];
    
    _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _photoBtn.backgroundColor = [UIColor whiteColor];
    _photoBtn.frame = CGRectMake(0, WGiveHeight(46) + 2, self.frame.size.width, WGiveHeight(46));
    [_photoBtn setTitle:@"从手机相册中选择" forState:UIControlStateNormal];
    [_photoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_popView addSubview:_photoBtn];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    cancelBtn.frame = CGRectMake(0, _popView.frame.size.height - WGiveHeight(48), self.frame.size.width, WGiveHeight(48));
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:cancelBtn];
}

- (void)show
{
    [UIView animateWithDuration:0.2 animations:^{
       
        self.popView.frame = CGRectMake(0, self.frame.size.height - WGiveHeight(150), self.frame.size.width, WGiveHeight(150));
        
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _popView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, WGiveHeight(150));
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
   
}


@end
