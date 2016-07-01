//
//  ChatViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/1/28.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatCell.h"

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate>
@end

@implementation ChatViewController {
    UITableView    * _tableView;
    NSArray        * _dataArr;
    UISearchController * _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)preData {
    [self getConversationData];
}

//获取会话列表
- (void)getConversationData {
    
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
    ChatCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScaleHeight(65);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatCell * chatCell = (ChatCell *)cell;
    
    ChatModel * model = _dataArr[indexPath.row];
    
    [chatCell setModel:model];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.searchController.searchBar;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   return ScaleHeight(44);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            
            [tableview registerNib:[UINib nibWithNibName:@"ChatCell" bundle:nil] forCellReuseIdentifier:@"ChatCell"];
            
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
