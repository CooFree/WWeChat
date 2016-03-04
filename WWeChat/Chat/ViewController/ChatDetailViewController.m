//
//  ChatDetailViewController.m
//  WWeChat
//
//  Created by wordoor－z on 16/3/3.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChatDetailViewController.h"
#import "MessageCell.h"
#import "WWeChatApi.h"

#import "KeyboardView.h"
@interface ChatDetailViewController()<RCIMClientReceiveMessageDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)KeyboardView * keyView ;


@property(nonatomic,strong)UITableView * tableView ;
@end
@implementation ChatDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self preData];
    // 设置消息接收监听
    [[RCIMClient sharedRCIMClient] setReceiveMessageDelegate:self object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = _name;
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [self createUI];
}

- (void)showMessage
{
   
}

- (void)preData
{
    if (_tableView)
    {
        [_tableView reloadData];
    }
    else
    {
        [self createTableView];
    }
}

- (void)createTableView
{
    _tableView = ({
    
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSceenWidth, kSceenHeight - 64 - 50) style:UITableViewStylePlain];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [tableView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMessageField)]];
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

- (void)hideMessageField
{
    [_keyView.messageField resignFirstResponder];
}

- (void)createUI
{
    _keyView = ({
    
        KeyboardView * keyView = [[KeyboardView alloc]initWithFrame:CGRectMake(0, kSceenHeight - 50, kSceenWidth, 50)];
        
        __weak typeof(KeyboardView) * weakKeyView = keyView;
        
        [keyView setShowBlock:^(NSInteger anType, CGFloat duration, CGSize kSize) {
            
            [UIView animateKeyframesWithDuration:duration delay:0 options:anType animations:^{
            
                    CGRect rect = weakKeyView.frame;
            
                    rect.origin.y -= kSize.height;
            
                    weakKeyView.frame = rect;
                
                CGRect tableRect = _tableView.frame;
                
                tableRect.size.height -= kSize.height;
                
                _tableView.frame = tableRect;
                
                } completion:^(BOOL finished) {
                    
                }];
            
        } andHideBlock:^(NSInteger anType, CGFloat duration, CGSize kSize) {
            
            [UIView animateKeyframesWithDuration:duration delay:0 options:anType animations:^{
                
                CGRect rect = weakKeyView.frame;
                
                rect.origin.y += kSize.height;
                
                weakKeyView.frame = rect;
                
                CGRect tableRect = _tableView.frame;
                
                tableRect.size.height += kSize.height;
                
                _tableView.frame = tableRect;
                
            } completion:^(BOOL finished) {
                
            }];
            
        }];
        
        keyView.sentBlock = ^(id response,MessageType type)
        {
            if (type == MessageTypeText)
            {
                NSString * message = (NSString *)response;
                [[WWeChatApi giveMeApi]sentTextMessageToTargetId:_converseID andConversationType:_conversationType andMessage:message andSuccess:^(id response) {
                    
                } andFailure:^{
                    
                } andError:^(NSError *error) {
                    
                }];
            }
            else if(type == MessageTypeImg)
            {
            
            }
            else if(type == MessageTypeWav)
            {
                
            }
        };
        
        keyView;
    });
    [self.view addSubview:_keyView];
}

#pragma mark -- tableView --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    if (cell == nil)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"MessageCell" owner:self options:nil][0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
