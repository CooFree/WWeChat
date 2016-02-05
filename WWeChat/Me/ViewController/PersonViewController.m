//
//  PersonViewController.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/3.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "PersonViewController.h"

#import "UserInfoManager.h"

#import "UIImageView+WebCache.h"

#import "ChangeAvaterView.h"

#import "WWeChatApi.h"

#import "MBProgressHUD.h"
@interface PersonViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,copy)NSArray * titleArr;

@property(nonatomic,copy)NSArray * valueArr;

@property(nonatomic,strong)ChangeAvaterView * changeView;

@end

@implementation PersonViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self preData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    [self preData];
}

- (void)preData
{
    _titleArr = @[
                  @[
                      @"头像",
                      @"名字",
                      @"微信号",
                      @"我的二维码",
                      @"我的地址"
                      ]
                      ,
                  @[
                      @"性别",
                      @"地区",
                      @"个性签名"
                      ]

                  ];
    
    _valueArr = @[
                  @[
                      [[UserInfoManager manager]avaterUrl],
                      [[UserInfoManager manager]userName],
                      [[UserInfoManager manager]wxID],
                      @"me_wm",
                      @""
                      ]
                  ,
                  @[
                      [[UserInfoManager manager]sex]==YES?@"男":@"女",
                      @"上海 杨浦",
                      @"iOS Coder.GitHub:Wzxhaha"
                      ]
                  
                  ];
    
    if (_tableView)
    {
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else
    {
        [self createTableView];
    }
}

- (void)createTableView
{
    _tableView = ({
        UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height -64) style:UITableViewStyleGrouped];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);;
        
        tableView;
    });
    [self.view addSubview:_tableView];
}

#pragma mark -- tableView --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = _titleArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"PersonCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = _titleArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(220), (cell.frame.size.height - WGiveHeight(64))/2.0, WGiveHeight(64), WGiveHeight(64))];
        
        [imageView setImageWithURL:[NSURL URLWithString:_valueArr[indexPath.section][indexPath.row]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            
        }];
        
        imageView.layer.cornerRadius = 5;
        imageView.clipsToBounds = YES;
        
        [cell.contentView addSubview:imageView];
    }
    else if(indexPath.section == 0 && indexPath.row == 3)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }

        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(270), (cell.frame.size.height - WGiveHeight(18))/2.0, WGiveHeight(18), WGiveHeight(18))];
        
        imageView.image = [UIImage imageNamed:@"me_wm"];
        
        [cell.contentView addSubview:imageView];
    }
    else
    {
        cell.detailTextLabel.text = _valueArr[indexPath.section][indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return WGiveHeight(80);
    }
    else
    {
        return WGiveHeight(44);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return WGiveHeight(15);
    }
    else
    {
        return WGiveHeight(20);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //修改头像
        if (indexPath.row == 0)
        {
            if (!_changeView)
            {
                _changeView = [[ChangeAvaterView alloc]initWithFrame:self.view.bounds];
                [[UIApplication sharedApplication].keyWindow addSubview:_changeView];
                [_changeView.cameraBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [_changeView.photoBtn addTarget:self action:@selector(photoClick:) forControlEvents:UIControlEventTouchUpInside];
                [_changeView show];
            }
            else
            {
                [[UIApplication sharedApplication].keyWindow addSubview:_changeView];
                [_changeView show];
            }
        }
        //修改用户名
        else if(indexPath.row == 1)
        {
            
        }
        //微信号（不能修改）
        else if(indexPath.row == 2)
        {
            
        }
        //二维码
        else if(indexPath.row == 3)
        {
            
        }
        //地址
        else if(indexPath.row == 4)
        {
            
        }
    }
    else
    {
        //性别
        if (indexPath.row == 0)
        {
            
        }
        //地区
        else if(indexPath.row == 1)
        {
            
        }
        //个性签名
        else if(indexPath.row == 2)
        {
            
        }
    }
}

- (void)cameraBtnClick:(UIButton *)sender
{
    [_changeView hide];
    NSLog(@"拍照");
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void)photoClick:(UIButton *)sender
{
    [_changeView hide];
    NSLog(@"相册");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
//        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage * smallImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(128, 128)];
//        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.label.text = @"正在上传头像";
            [[WWeChatApi giveMeApi]updataAvaterWithImg:smallImage andSuccess:^(id response) {
            
                NSDictionary * dic = [[NSUserDefaults standardUserDefaults]objectForKey:wUserInfo];
                NSMutableDictionary * muDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
                [muDic setObject:response forKey:@"avaterUrl"];
                [[NSUserDefaults standardUserDefaults]setObject:[muDic copy] forKey:wUserInfo];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                [self preData];
                
            } andFailure:^(NSError *error) {
                
                NSLog(@"error:%@",error.localizedDescription);
                
            }];
            
        }];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//压缩图片方法
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
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
