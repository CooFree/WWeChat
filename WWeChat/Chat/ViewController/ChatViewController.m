//
//  ChatViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCell.h"
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 *  tableView
 */
@property(nonatomic,strong)UITableView * tableView;


@property(nonatomic,copy)NSArray * dataArr;

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
