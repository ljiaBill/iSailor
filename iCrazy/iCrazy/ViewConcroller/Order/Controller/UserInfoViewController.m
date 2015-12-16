//
//  UserInfoViewController.m
//  iLazy
//
//  Created by Administrator on 15/10/13.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIImageView+WebCache.h"

@interface UserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

//顶部导航
@property (strong, nonatomic)MyNavigation * navigation;

//代替导航栏的view
@property (strong, nonatomic)UIView * barView;

//背景图片
@property (strong, nonatomic)UIImageView * backView;

//底部View
@property (strong, nonatomic)UIView * showView;

//头像
@property (strong, nonatomic)UIImageView * imgView;

//昵称
@property (strong, nonatomic)UILabel * nickLabel;

//Table
@property (strong, nonatomic)UITableView * table;

//用户信息
@property (strong, nonatomic)NSDictionary * userDic;

//用户头像
@property (strong, nonatomic)NSString * userimage;
//用户昵称
@property (strong, nonatomic)NSString * usernick;
//用户性别
@property (strong, nonatomic)NSString * usersex;
//用户邮箱
@property (strong, nonatomic)NSString * useremail;
//用户手机号码
@property (strong, nonatomic)NSString * userphone;

@property (strong, nonatomic)UITapGestureRecognizer * tap;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.backView.alpha = 0.8;
    [self.view addSubview:self.backView];
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellButClick)];
    
    //自定义顶部导航
    [self myNavigation];
    
    //改变状态栏颜色
    [self statusBar];
    
    //获取用户信息
    [self gainUserInfo];
    
    //展示信息
    [self initMyMessage];
}

#pragma mark - 改变状态栏的颜色和字体颜色
- (void)statusBar
{
    self.barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 20)];
    
    self.barView.backgroundColor = COLORNAVIGATION;
    
    [self.view addSubview:self.barView];
}

//改变状态栏文字为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - 顶部导航
- (void)myNavigation
{
    
    self.navigation = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"" titleStr:@""];
    
    [self.navigation.leftBut addTarget:self action:@selector(goBeackClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.navigation];
}

#pragma mark - 获取用户信息
- (void)gainUserInfo
{
    if(![self.userDic objectForKey:@"userimage"])
    {
        self.userimage = @"";
    }
    else
    {
        self.userimage = [self.userDic objectForKey:@"userimage"];
    }

    if(![self.userDic objectForKey:@"usernick"])
    {
        self.usernick = @"";
    }
    else
    {
        self.usernick = [self.userDic objectForKey:@"usernick"];
    }

    if(![self.userDic objectForKey:@"usersex"])
    {
        self.usersex = @"";
    }
    else
    {
        self.usersex = [self.userDic objectForKey:@"usersex"];
    }
    
    if(![self.userDic objectForKey:@"useremail"])
    {
        self.useremail = @"";
    }
    else
    {
        self.useremail = [self.userDic objectForKey:@"useremail"];
    }
    
    if(![self.userDic objectForKey:@"userphone"])
    {
        self.userphone = @"";
    }
    else
    {
        self.userphone = [self.userDic objectForKey:@"userphone"];
    }
}

#pragma mark - 初始化MyMessage展示信息
- (void)initMyMessage
{
    //展示信息的view
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT/4)];
    self.showView.backgroundColor = COLORNAVIGATION;
    [self.view addSubview:self.showView];

    //头像
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-UISCREEN_WIDTH/4/2, 3, UISCREEN_WIDTH/4, UISCREEN_WIDTH/4)];
    [self.imgView.layer setCornerRadius:UISCREEN_WIDTH/8];
    //同步获取网络图片
    NSString * url = [NSString stringWithFormat:@"%@%@",LAZY_IMAGE_PATH,[self.userDic objectForKey:@"userimage"]];
//    UIImage * internetImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
//    self.imgView.image = internetImage;
    self.imgView.clipsToBounds = YES;
    [self.showView addSubview:self.imgView];
    
    if([[self.userDic objectForKey:@"userimage"] isEqualToString:@""])
    {
        self.imgView.image = [UIImage imageNamed:@"x_userimg"];
    }
    else
    {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:url]];
    }
    
    //昵称
    self.nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, UISCREEN_WIDTH/4+15, UISCREEN_WIDTH, UISCREEN_WIDTH/4/2-20)];
    self.nickLabel.text = self.usernick;
    self.nickLabel.textAlignment = NSTextAlignmentCenter;
    self.nickLabel.font = [UIFont systemFontOfSize:20];
    self.nickLabel.textColor = [UIColor whiteColor];
    [self.showView addSubview:self.nickLabel];
    
    //tableView展示信息
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.showView.bounds.size.height+64+1, UISCREEN_WIDTH, 180) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;                 //去线
    self.table.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.table];
}

#pragma mark - TableView代理操作
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * str = @"cell";
    UserInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell == nil)
    {
        cell = [[UserInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if(indexPath.row == 0)
    {
        cell.nameLabel.text = @"性别";
        
        cell.showLable.text = self.usersex;
    }
    else if (indexPath.row == 1)
    {
        cell.nameLabel.text = @"邮箱";
        cell.showLable.text = self.useremail;
    }
    else if (indexPath.row == 2)
    {
        cell.nameLabel.text = @"手机号码";
        cell.showLable.text = self.userphone;
        [cell.button setImage:[UIImage imageNamed:@"phone_1"] forState:UIControlStateNormal];
        [cell.button addTarget:self action:@selector(cellButClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.butView addGestureRecognizer:self.tap];
        cell.button.hidden = NO;
    }
    
    //关闭拖动
    tableView.scrollEnabled = NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)cellButClick
{
    NSLog(@"拨号,打电话...%@",self.userphone);
    if([self.userphone isEqualToString:@""])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"资料不完善!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        NSString * phone = [NSString stringWithFormat:@"tel://%@",self.userphone];
        UIApplication * app = [UIApplication sharedApplication];
        [app openURL:[NSURL URLWithString:phone]];
    }
}

#pragma mark - 回退按钮的点击事件
- (void)goBeackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
