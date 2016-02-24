//
//  ChatViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCell.h"

#import "UserInfoManager.h"
#import "GlassView.h"
#import "WWeChatApi.h"
#import "WZXChatTool.h"
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,AVIMClientDelegate>

/**
 *  tableView
 */
@property(nonatomic,strong)UITableView * tableView;


@property(nonatomic,copy)NSMutableArray * dataArr;

@property(nonatomic,strong)UISearchController * searchController;

@end

@implementation ChatViewController

- (void)viewWillAppear:(BOOL)animated
{
     [self preData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addRightBtnWithImgName:@"chat_add" andSelector:@selector(rightBtnClick:)];
}

- (void)preData
{
    _dataArr = [[NSMutableArray alloc]init];
    if ([UserInfoManager manager].isLogin == NO)
    {
        [[WWeChatApi giveMeApi]loginWithUserName:@"110" andPassWord:@"123456" andSuccess:^(id response) {
            NSLog(@"登录成功%@",response);
            self.navigationItem.title = @"微信";
            
            if ([UserInfoManager manager].isOpenIm == NO)
            {
                self.client = [[AVIMClient alloc]initWithClientId:[UserInfoManager manager].mid];
                
                self.client.delegate = self;
                
                WZXChatTool * tool = [WZXChatTool shareTool];
                [tool openWithClient:self.client andSuccessBlock:^{
                    
                    [self getConversationData];
                    
                } andFailureBlock:^{
                    
                } andError:^(NSError *error) {
                    
                }];
            }

            
        } andFailure:^(NSError *error) {
            NSLog(@"登录失败%@",error);
            self.navigationItem.title = @"微信(未连接)";
        }];
    }
    
    if([UserInfoManager manager].isOpenIm == YES)
    {
        [self getConversationData];
    }
}

- (void)getConversationData
{
    self.client = [[AVIMClient alloc]initWithClientId:[UserInfoManager manager].mid];
    WZXChatTool * tool = [WZXChatTool shareTool];
    
    [tool openWithClient:self.client andSuccessBlock:^{
        
        [tool getConversationWithClient:self.client withMId:[UserInfoManager manager].mid andSuccessBlock:^(NSArray *conversations) {

            
            for (int i = 0; i < conversations.count; i++)
            {
                AVIMConversation * conversation = conversations[i];

                [tool getMessageWithConversation:conversation andLimitNum:1 andSuccessBlock:^(NSArray *messages) {
                    
                    AVIMMessage * message = messages.lastObject;
                    ChatModel * model = [[ChatModel alloc]init];
                    model.avatar = @"";
                    model.userName = conversation.name;
                    model.message = message.content;
                    model.time = [NSString stringWithFormat:@"%lld",message.sendTimestamp];
                    [_dataArr addObject:model];
                    if (_tableView)
                    {
                        [_tableView reloadData];
                    }
                    else
                    {
                        [self createTableView];
                    }
                    
                } andFailureBlock:^{
                    
                } andError:^(NSError *error) {
                    
                }];
                
            }
             [tool sendTextMessage:@"你好啊" withConversation:conversations[0] andSuccessBlock:^{
                 
             } andFailureBlock:^{
                 
             } andError:^(NSError *error) {
                 
             }];
            

        } andFailureBlock:^{

        } andError:^(NSError *error) {

        }];
    } andFailureBlock:^{
        
    } andError:^(NSError *error) {
        
    }];
    
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
    self.searchController.delegate = self;
    
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    [self.searchController.searchBar sizeToFit];
    
    self.searchController.searchBar.backgroundImage = [[UIImage alloc]init];
    
    self.searchController.searchBar.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
    
    self.searchController.searchBar.tintColor = WXGreen;
    
    self.searchController.searchBar.placeholder = @"搜索";
    
   
    
    return self.searchController.searchBar;
}

- (void)willPresentSearchController:(UISearchController *)searchController
{
    [self.glassView showToView:self.view];
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    [self.glassView hide];
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
