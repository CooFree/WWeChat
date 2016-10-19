//
//  TabBarViewController.m
//  WWeChat
//
//  Created by WzxJiang on 16/6/28.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "TabBarViewController.h"

#import "ChatViewController.h"
#import "AddressBookViewController.h"
#import "ZoneViewController.h"
#import "MeViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

UINavigationController * NavInTabbar(UIViewController * vc, NSString * imgName, NSString * selectImgName) {
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    UIImage * image = [UIImage imageNamed:imgName];
    UIImage * selectImage = [UIImage imageNamed:selectImgName];
    nav.tabBarItem = [[UITabBarItem alloc]initWithTitle:vc.tabBarItem.title image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:
    [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ChatViewController * chatVC = [[ChatViewController alloc]init];
    chatVC.tabBarItem.title = @"微信";
    chatVC.navigationItem.title = @"微信";
    
    AddressBookViewController * addbkVC = [[AddressBookViewController alloc]init];
    addbkVC.title = @"通讯录";
    
    ZoneViewController * zoneVC = [[ZoneViewController alloc]init];
    zoneVC.title = @"发现";
    
    MeViewController * meVC = [[MeViewController alloc]init];
    meVC.title = @"我";
    
    self.viewControllers = @[
      NavInTabbar(chatVC, @"tabbar_mainframe", @"tabbar_mainframeHL"),
      NavInTabbar(addbkVC,@"tabbar_contacts",  @"tabbar_contactsHL"),
      NavInTabbar(zoneVC, @"tabbar_discover",  @"tabbar_discoverHL"),
      NavInTabbar(meVC,   @"tabbar_me",        @"tabbar_meHL")];
    
    self.tabBar.tintColor = BASE_COLOR;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
