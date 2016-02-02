//
//  ChatViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCell.h"

#import "WWeChatApi.h"
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  tableView
 */
@property(nonatomic,strong)UITableView * tableView;


@property(nonatomic,copy)NSArray * dataArr;

@property(nonatomic,strong)UISearchController * searchController;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addRightBtnWithImgName:@"chat_add" andSelector:@selector(rightBtnClick:)];
    
    [self preData];
}

- (void)preData
{
//    [[WWeChatApi giveMeApi]loginWithUserName:@"Wzxhaha" andPassWord:@"123456" andSuccess:^(id response) {
//        NSLog(@"登录成功%@",response);
//    } andFailure:^(NSError *error) {
//        NSLog(@"登录失败%@",error);
//    }];
    
    [[WWeChatApi giveMeApi]registerWithUserName:@"WzxJiang" andPassWord:@"123456" andSuccess:^(id response) {
        
        NSLog(@"注册成功");
        
    } andFailure:^(NSError * error)
    {
        if (error == nil)
        {
            NSLog(@"该昵称已被使用");
        }
        else
        {
            NSLog(@"注册失败:%@",error.localizedDescription);
        }
    }];
    
    ChatModel * model = [[ChatModel alloc]init];
    model.avatar = @"";
    model.userName = @"wzx";
    model.message = @"test";
    model.time = @"昨天";
    _dataArr = @[model,model,model,model,model,model,model,model,model];
    
    [self createTableView];
}

- (void)rightBtnClick:(UIButton *)sender
{
    NSLog(@"点击了");
}

- (void)createTableView
{
    _tableView = ({
    
        UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 44) style:UITableViewStylePlain];
        
        tableview.delegate = self;
        
        tableview.dataSource = self;
        
        tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        tableview;
    });
    [self.view addSubview:_tableView];
}


#pragma mark -- tableView --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell * cell = [tableView dequeueReusableCellWithIdentifier:@"chatCell"];
    
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ChatCell" owner:self options:nil][0];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WGiveHeight(65);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell * chatCell = (ChatCell *)cell;
    
    [chatCell setModel:_dataArr[indexPath.row]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    //self.searchController.searchResultsUpdater = self;
    
    self.searchController.dimsBackgroundDuringPresentation = YES;
    
    [self.searchController.searchBar sizeToFit];
    
    //self.searchController.searchBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1];
    
    self.searchController.searchBar.backgroundImage = [[UIImage alloc]init];
    
    self.searchController.searchBar.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
    
    self.searchController.searchBar.placeholder = @"搜索";
    
    return self.searchController.searchBar;
}

//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return WGiveHeight(43);
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
