//
//  AddFriendViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/2/17.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation AddFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"添加好友";
    
    [self createTableView];
}

- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        
        tableView.dataSource= self;
        
        tableView;
    });
    [self.view addSubview:_tableView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
