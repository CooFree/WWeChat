//
//  ChatViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatViewController.h"
#import "ConversationCell.h"
#import "ChatDetailViewController.h"

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate>
@end

@implementation ChatViewController {
    UITableView        * _tableView;
    NSArray            * _dataArr;
    UISearchController * _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preData];
    [self createUI];
}

- (void)preData {
    [self getConversationData];
}

//获取会话列表
- (void)getConversationData {
//     _dataArr = [self.chatViewModel getConversationList];
    WZXConversation * conversation1 = [WZXConversation new];
    conversation1.conversationType = ConversationType_PRIVATE;
    conversation1.isTop = NO;
    conversation1.lastMessage = @"你好啊！";
    conversation1.lastMessageTime = [[NSDate date] timeIntervalSince1970];
    conversation1.conversationTitle = @"信息1";
    conversation1.unreadMessageCount = 10;
    
    WZXConversation * conversation2 = [WZXConversation new];
    conversation2.conversationType = ConversationType_PRIVATE;
    conversation2.isTop = NO;
    conversation2.lastMessage = @"你好啊！";
    conversation2.lastMessageTime = [[NSDate date] timeIntervalSince1970];
    conversation2.conversationTitle = @"信息2";
    conversation2.unreadMessageCount = 0;
    
    WZXConversation * conversation3 = [WZXConversation new];
    conversation3.conversationType = ConversationType_PRIVATE;
    conversation3.isTop = NO;
    conversation3.lastMessage = @"你好啊！";
    conversation3.lastMessageTime = [[NSDate date] timeIntervalSince1970];
    conversation3.conversationTitle = @"消息3";
    conversation3.unreadMessageCount = 0;
    
    _dataArr = @[conversation1, conversation2, conversation3];
    
    [[self tableView] reloadData];
}

- (void)createUI {
    [self changeTitle];
    [self.view addSubview:self.tableView];
}

#pragma mark -- tableView --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"conversationCell"];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ConversationCell * conversationCell = (ConversationCell *)cell;
    WZXConversation * model = _dataArr[indexPath.row];
    [conversationCell setModel:model];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.searchController.searchBar;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChatDetailViewController * chatDetailVC = [[ChatDetailViewController alloc]init];
    chatDetailVC.conversationModel = _dataArr[indexPath.row];
    [self.navigationController pushViewController:chatDetailVC animated:YES];
}

- (void)changeTitle {
    int totalUnreadCount = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    if (totalUnreadCount > 0) {
        self.navigationItem.title = [NSString stringWithFormat:@"微信(%d)",totalUnreadCount];
    } else {
        self.navigationItem.title = @"微信";
    }
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            
            UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 44) style:UITableViewStyleGrouped];
            tableview.delegate = self;
            tableview.dataSource = self;
            tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableview.rowHeight = 65;
            [tableview registerClass:[ConversationCell class] forCellReuseIdentifier:@"conversationCell"];
            tableview;
        });
    }
    return _tableView;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        //self.searchController.searchResultsUpdater = self;
        //    self.searchController.delegate = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        [_searchController.searchBar sizeToFit];
        _searchController.searchBar.backgroundImage = [[UIImage alloc]init];
        _searchController.searchBar.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1];
        _searchController.searchBar.tintColor = BASE_COLOR;
        _searchController.searchBar.placeholder = @"搜索";
    }
    return _searchController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
