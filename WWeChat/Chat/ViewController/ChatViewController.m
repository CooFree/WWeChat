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
#import <RongIMLib/RongIMLib.h>
#import "WZXTimeStampToTimeTool.h"
#import "ChatDetailViewController.h"
@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,RCIMClientReceiveMessageDelegate>

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
    // 设置消息接收监听
    [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
     [self preData];
    
    [self changeTitle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addRightBtnWithImgName:@"chat_add" andSelector:@selector(rightBtnClick:)];
}

- (void)preData
{
    _dataArr = [[NSMutableArray alloc]init];
    [self getConversationData];
}

//获取会话列表
- (void)getConversationData
{
    NSArray *conversationList = [[RCIMClient sharedRCIMClient]
                                 getConversationList:@[@(ConversationType_PRIVATE),
                                                       @(ConversationType_DISCUSSION),
                                                       @(ConversationType_GROUP),
                                                       @(ConversationType_SYSTEM),
                                                       @(ConversationType_APPSERVICE),
                                                       @(ConversationType_PUBLICSERVICE)]];
    
    NSArray *sortedArray = [conversationList sortedArrayUsingComparator:^NSComparisonResult(RCConversation * obj1, RCConversation * obj2) {
        if (obj1.sentTime < obj2.sentTime ) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    
    
    for (RCConversation *conversation in sortedArray) {
        NSLog(@"会话类型：%lu，目标会话ID：%@", (unsigned long)conversation.conversationType, conversation.targetId);
        

        ChatModel * model = [[ChatModel alloc]init];
        
        model.nameID = conversation.targetId;
        
        model.time = [[WZXTimeStampToTimeTool tool]compareWithTimeDic:[[WZXTimeStampToTimeTool tool]timeStampToTimeToolWithTimeStamp:conversation.sentTime andScale:3]];
        
        model.converseID = conversation.targetId;
        
        if ([conversation.lastestMessage isMemberOfClass:[RCTextMessage class]]) {
            RCTextMessage *testMessage = (RCTextMessage *)conversation.lastestMessage;
            NSLog(@"消息内容：%@", testMessage.content);
            model.message = testMessage.content;
        }
        
        
        model.noReadNum = conversation.unreadMessageCount;
        model.type = conversation.conversationType;
        NSLog(@"sentTime %lld",conversation.sentTime);
        
        
        [_dataArr addObject:model];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self changeTitle];
            if (_tableView)
            {
                [_tableView reloadData];
            }
            else
            {
                [self createTableView];
            }
        });

        
    }
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
    
    ChatModel * model = _dataArr[indexPath.row];
    
    [chatCell setModel:model];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    ChatModel * model = _dataArr[indexPath.row];
    ChatDetailViewController * chatDetailVC = [[ChatDetailViewController alloc]init];
    chatDetailVC.name = cell.nameLabel.text;
    chatDetailVC.converseID = model.converseID;
    chatDetailVC.hidesBottomBarWhenPushed = YES;
    [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:model.type targetId:model.converseID];
    [self changeTitle];
    [self.navigationController pushViewController:chatDetailVC animated:YES];
}

#pragma mark -- IM --
- (void)onReceived:(RCMessage *)message left:(int)nLeft object:(id)object {
    
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
        RCTextMessage *testMessage = (RCTextMessage *)message.content;
        NSLog(@"消息内容：%@", testMessage.content);
    }
    //没有未接受的消息时刷新
    if (nLeft == 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^
       {
           [self preData];
       });
    }
    
    NSLog(@"还剩余的未接收的消息数：%d", nLeft);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeTitle
{
    int totalUnreadCount = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    if (totalUnreadCount > 0)
    {
        self.navigationItem.title = [NSString stringWithFormat:@"微信(%d)",totalUnreadCount];
    }
    else
    {
        self.navigationItem.title = @"微信";
    }
    

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
