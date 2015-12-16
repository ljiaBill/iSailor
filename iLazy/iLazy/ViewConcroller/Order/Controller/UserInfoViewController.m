//
//  UserInfoViewController.m
//  iLazy
//
//  Created by Administrator on 15/10/13.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "dataRequest.h"
#import "Macro.h"

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

//信用度
@property (strong, nonatomic)UIView * creditView;
@property (strong, nonatomic)UILabel * creditLabel;

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

//信用度小星星
@property (strong, nonatomic)UIImageView * starOne;
@property (strong, nonatomic)UIImageView * starTwo;
@property (strong, nonatomic)UIImageView * starThere;
@property (strong, nonatomic)UIImageView * starFour;
@property (strong, nonatomic)UIImageView * starFive;

@property (strong, nonatomic)NSDictionary * fractionDic;

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
    
    self.navigation = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"" titleStr:@"个人信息"];
    
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
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 74, UISCREEN_WIDTH, UISCREEN_HEIGHT/5)];
    self.showView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.showView];
    
    //头像
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.showView.bounds.size.height/2-UISCREEN_WIDTH/8, UISCREEN_WIDTH/4, UISCREEN_WIDTH/4)];
    [self.imgView.layer setCornerRadius:5];
    //同步获取网络图片
    NSString * url = [NSString stringWithFormat:@"%@%@",CRAZY_IMAGE_PATH,[self.userDic objectForKey:@"userimage"]];
//    UIImage * internetImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
//    self.imgView.image = internetImage;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:url]];
    self.imgView.clipsToBounds = YES;
    [self.showView addSubview:self.imgView];
    
    //昵称
    self.nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(20+UISCREEN_WIDTH/4+UISCREEN_WIDTH/12, self.showView.bounds.size.height/2-UISCREEN_WIDTH/8, 200, UISCREEN_WIDTH/4/2)];
    self.nickLabel.text = self.usernick;
    self.nickLabel.font = [UIFont systemFontOfSize:15];
    self.nickLabel.textColor = COLORMAMP(91,83,91,1);
    [self.showView addSubview:self.nickLabel];
    
    //信用度
    [self creditShow];                             //点亮星星
    
    //tableView展示信息
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.showView.bounds.size.height+74+10, UISCREEN_WIDTH, 180) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;                 //去线
    self.table.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.table];
}

#pragma mark - 展示信用度
- (void)creditShow
{
    //底层
    self.creditView = [[UIView alloc]initWithFrame:CGRectMake(20+UISCREEN_WIDTH/4+UISCREEN_WIDTH/12, self.showView.bounds.size.height/2-UISCREEN_WIDTH/8+UISCREEN_WIDTH/4/2-self.nickLabel.bounds.size.height/3, 200, UISCREEN_WIDTH/4/2)];
    [self.showView addSubview:self.creditView];
    //文字说明
    self.creditLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.creditView.bounds.size.width/4, UISCREEN_WIDTH/8)];
    self.creditLabel.text = [NSString stringWithFormat:@"信用度:"];
    self.creditLabel.font = [UIFont systemFontOfSize:12];
    self.creditLabel.textColor = COLORMAMP(91,83,91,1);
    [self.creditView addSubview:self.creditLabel];
    //星星
    self.starOne = [[UIImageView alloc]initWithFrame:CGRectMake(self.creditLabel.bounds.size.width, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
    
    self.starTwo = [[UIImageView alloc]initWithFrame:CGRectMake(self.creditLabel.bounds.size.width+self.starOne.bounds.size.width+4, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
    
    self.starThere = [[UIImageView alloc]initWithFrame:CGRectMake(self.creditLabel.bounds.size.width+self.starOne.bounds.size.width*2+8, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
    
    self.starFour = [[UIImageView alloc]initWithFrame:CGRectMake(self.creditLabel.bounds.size.width+self.starOne.bounds.size.width*3+12, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
    
    self.starFive = [[UIImageView alloc]initWithFrame:CGRectMake(self.creditLabel.bounds.size.width+self.starOne.bounds.size.width*4+16, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
    
    [self.creditView addSubview:self.starOne];
    [self.creditView addSubview:self.starTwo];
    [self.creditView addSubview:self.starThere];
    [self.creditView addSubview:self.starFour];
    [self.creditView addSubview:self.starFive];
    
    NSInteger fraction = [[self.fractionDic objectForKey:@"creditinfo"] integerValue];
    [self starIllume:fraction];
}

#pragma mark - 点亮星星
- (void)starIllume:(NSInteger)fraction
{
    if (fraction > 500)
    {
        //五颗星
        self.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starThere.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starFour.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starFive.image = [UIImage imageNamed:@"creditStarTwo"];
    }
    else if (fraction > 400)
    {
        //四颗半星
        self.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starThere.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starFour.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starFive.image = [UIImage imageNamed:@"creditStarThere"];
    }
    else if (fraction > 300)
    {
        //四颗星
        self.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starThere.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starFour.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starFive.image = [UIImage imageNamed:@"creditStarOne"];
    }
    else if (fraction > 200)
    {
        //三颗半星
        self.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starThere.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starFour.image = [UIImage imageNamed:@"creditStarThere"];
        self.starFive.image = [UIImage imageNamed:@"creditStarOne"];
    }
    else if (fraction > 100)
    {
        //三颗星
        self.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starThere.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starFour.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFive.image = [UIImage imageNamed:@"creditStarOne"];
    }
    
    else if (fraction > 70)
    {
        //两颗半星
        self.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starThere.image = [UIImage imageNamed:@"creditStarThere"];
        self.starFour.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFive.image = [UIImage imageNamed:@"creditStarOne"];
    }
    else if (fraction > 40)
    {
        //两颗星
        self.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starThere.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFour.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFive.image = [UIImage imageNamed:@"creditStarOne"];
    }
    else if (fraction > 20)
    {
        //一颗半星
        self.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarThere"];
        self.starThere.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFour.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFive.image = [UIImage imageNamed:@"creditStarOne"];
    }
    else if (fraction > 8)
    {
        //一颗星
        self.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarOne"];
        self.starThere.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFour.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFive.image = [UIImage imageNamed:@"creditStarOne"];
    }
    else if (fraction > 2)
    {
        //半颗星
        self.starOne.image = [UIImage imageNamed:@"creditStarThere"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarOne"];
        self.starThere.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFour.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFive.image = [UIImage imageNamed:@"creditStarOne"];
    }
    else
    {
        //无星
        self.starOne.image = [UIImage imageNamed:@"creditStarOne"];
        self.starTwo.image = [UIImage imageNamed:@"creditStarOne"];
        self.starThere.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFour.image = [UIImage imageNamed:@"creditStarOne"];
        self.starFive.image = [UIImage imageNamed:@"creditStarOne"];
    }
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
