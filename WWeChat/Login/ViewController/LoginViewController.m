//
//  LoginViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/2.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+ToImg.h"
#import "WWeChatApi.h"

#import "TabBarViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self btnSetting];
    
    [_mobileTextfield addTarget:self action:@selector(judgement) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextfield addTarget:self action:@selector(judgement) forControlEvents:UIControlEventEditingChanged];
}

- (void)judgement
{
    if (_mobileTextfield.text.length > 0 && _passwordTextfield.text.length >0)
    {
        _loginBtn.enabled = YES;
        _loginBtn.alpha = 1;
    }
    else
    {
        _loginBtn.enabled = NO;
        _loginBtn.alpha = 5;
    }
}

- (void)btnSetting
{
    [_loginBtn setBackgroundImage:[WXGreen toImg] forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[[UIColor colorWithRed:36/255.0 green:186/255.0 blue:36/255.0 alpha:0.1] toImg] forState:UIControlStateDisabled];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)loginBtnClick:(id)sender {
    
    [[WWeChatApi giveMeApi]loginWithUserName:_mobileTextfield.text andPassWord:_passwordTextfield.text andSuccess:^(id response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            [self presentViewController:[[TabBarViewController alloc]init] animated:YES completion:^{
                
            }];
        });
       
        
    } andFailure:^{
        
    } andError:^(NSError *error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
