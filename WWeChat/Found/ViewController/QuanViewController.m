//
//  QuanViewController.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/4.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "QuanViewController.h"

@interface QuanViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView * tableView;


@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation QuanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"朋友圈";
    self.view.backgroundColor = [UIColor colorWithRed:34/255.0 green:37/255.0 blue:38/255.0 alpha:1];
    
    
    
    [self preData];
}

- (void)preData
{
    _dataArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 100; i++)
    {
        [_dataArr addObject:@""];
    }
    
    [self createTableView];
}

- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        tableView.backgroundColor = [UIColor colorWithRed:34/255.0 green:37/255.0 blue:38/255.0 alpha:1];
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"QuanCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return WGiveHeight(256);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, WGiveHeight(256))];
    
    //背景部分
    UIImageView * realView = [[UIImageView alloc]initWithFrame:CGRectMake(0, - WGiveHeight(64), self.view.frame.size.width, WGiveHeight(320))];
    realView.image = [UIImage imageNamed:@"Quan"];
    [view addSubview:realView];
    
    //头像部分
    {
    UIView * avaterBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(WGiveWidth(236), WGiveHeight(269), WGiveHeight(75), WGiveHeight(75))];
    avaterBackGroundView.backgroundColor = [UIColor whiteColor];
    avaterBackGroundView.layer.borderColor = [UIColor grayColor].CGColor;
    avaterBackGroundView.layer.borderWidth = 0.5;
    [realView addSubview:avaterBackGroundView];
    
    UIImageView * avaterImgView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(2), WGiveWidth(2), WGiveHeight(75) - WGiveWidth(4), WGiveHeight(75) - WGiveWidth(4))];
    avaterImgView.image = [UIImage imageNamed:@"avater.jpg"];
    [avaterBackGroundView addSubview:avaterImgView];
    }
    
    //名字部分
    {
        UILabel * userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, WGiveHeight(276), WGiveWidth(218), WGiveHeight(44))];
        userNameLabel.text = @"WzxJiang";
        userNameLabel.font = [UIFont boldSystemFontOfSize:17];
        userNameLabel.textColor = [UIColor whiteColor];
        userNameLabel.textAlignment = NSTextAlignmentRight;
        [realView addSubview:userNameLabel];
    }
    return view;
}

#pragma mark -- scrollview --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"旋转吧，皮卡丘!");
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"end");
//}
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
