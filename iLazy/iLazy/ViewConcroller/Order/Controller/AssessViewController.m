//
//  AssessViewController.m
//  iLazy
//
//  Created by Administrator on 15/9/24.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "AssessViewController.h"
#import "MBProgressHUD.h"
#import "OrderViewController.h"
#import "UserInfoViewController.h"
#import "UIButton+WebCache.h"

@interface AssessViewController ()<MBProgressHUDDelegate>

//顶部导航
@property (strong, nonatomic)MyNavigation * navigation;

//代替导航栏的view
@property (strong, nonatomic)UIView * barView;

//背景图片
@property (strong, nonatomic)UIImageView * backView;

@property (strong, nonatomic)NSString * touchPhone;

//展示信息的view
@property (strong, nonatomic)UIView * showView;
@property (strong, nonatomic)UIView * imgView;          //头像
@property (strong, nonatomic)UIButton * imgButton;      //头像
@property (strong, nonatomic)UILabel * nickLabel;       //昵称
@property (strong, nonatomic)UILabel * detailLabel;     //内容
@property (strong, nonatomic)UILabel * lineLabel;       //评星
@property (strong, nonatomic)UILabel * rankLabel;

@property (strong, nonatomic)UIView * rankView;
@property (strong, nonatomic)UIButton * rankOneBut;
@property (strong, nonatomic)UIButton * rankTwoBut;
@property (strong, nonatomic)UIButton * rankThreeBut;
@property (strong, nonatomic)UIButton * rankFourBut;
@property (strong, nonatomic)UIButton * rankFiveBut;
@property (assign, nonatomic)BOOL isOne;        //yes为已点击，no为未点击
@property (assign, nonatomic)BOOL isTwo;
@property (assign, nonatomic)BOOL isThree;
@property (assign, nonatomic)BOOL isFour;
@property (assign, nonatomic)BOOL isFive;

//写评价的TextView
@property (strong, nonatomic)UITextView * writeView;
@property (strong, nonatomic)UIButton * proBut;

//提交按钮
@property (strong, nonatomic)UIButton * putInBut;

//接收参数
@property (strong, nonatomic)NSDictionary * orderDic;
@property (strong, nonatomic)NSDictionary * userDic;

//加载缓冲
@property (strong, nonatomic)MBProgressHUD * commentHUD;

//星星个数
@property (assign, nonatomic)int num;

@property (assign, nonatomic)BOOL isClick;

@property (strong, nonatomic)UIView * sview;

//假定由主页传过来的用户信息(这里假定l_user为2的用户)
@property (strong, nonatomic)NSString * l_userid;

//回传值
@property (strong, nonatomic)NSString * str;

@end

@implementation AssessViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.backView.alpha = 0.8;
    [self.view addSubview:self.backView];
    
    self.isClick = YES;
    
    NSLog(@"%@",self.l_userid);
    
    //初始化展示信息view
    [self initShowView];
    
    //自定义顶部导航
    [self myNavigation];
    
    //改变状态栏颜色
    [self statusBar];
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
    
    self.navigation = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"" titleStr:@"评价"];
    
    [self.navigation.leftBut addTarget:self action:@selector(goBeackClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.navigation];
}

#pragma mark - 初始化展示信息view
- (void)initShowView
{
    //展示信息的view
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(10, 74, UISCREEN_WIDTH-20, UISCREEN_HEIGHT/4)];
    self.showView.backgroundColor = [UIColor whiteColor];
    [self.showView.layer setCornerRadius:6];
    
    //头像
    self.imgView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, self.showView.frame.size.width/4, self.showView.frame.size.height/2)];
    [self.imgView.layer setCornerRadius:5];
    self.imgView.clipsToBounds = YES;
    [self.showView addSubview:self.imgView];

    self.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.imgView.frame.size.width, self.imgView.frame.size.height)];
    
    //同步获取网络图片
    NSString * url = [NSString stringWithFormat:@"%@%@",CRAZY_IMAGE_PATH,[self.userDic objectForKey:@"userimage"]];
//    UIImage * internetImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
//    
//    [self.imgButton setImage:internetImage forState:UIControlStateNormal];
    [self.imgButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
    [self.imgButton addTarget:self action:@selector(personalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.imgView addSubview:self.imgButton];
    
    //昵称
    self.nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imgButton.frame.size.width+25, 10, self.showView.frame.size.width-10-self.imgButton.frame.size.width-20, 20)];
    
    NSString * nick = [self.userDic objectForKey:@"usernick"];
    
    self.nickLabel.text = nick;
    self.nickLabel.font = [UIFont systemFontOfSize:15];
    self.nickLabel.textColor = COLORMAMP(91,83,91,1);
    [self.showView addSubview:self.nickLabel];
    
    //详情
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imgButton.frame.size.width+25,self.nickLabel.frame.size.height+10, self.showView.frame.size.width-10-self.imgButton.frame.size.width-20, self.imgButton.frame.size.height-self.nickLabel.frame.size.height-10)];
    
    NSString * detail = [self.orderDic objectForKey:@"orderdetail"];
    
//    self.detailLabel.text = @"10月1号下午两点到三点到文星广场的圆通速递帮忙取快递包裹,物品贵重请小心!";
    self.detailLabel.text = detail;
    self.detailLabel.numberOfLines = 0;                         //多行编辑
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.textColor = COLORMAMP(148,135,135,1);
    [self.showView addSubview:self.detailLabel];
    
    //分割线
    self.lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.imgButton.frame.size.height+10, self.showView.frame.size.width-10, 1)];
    self.lineLabel.backgroundColor = COLORNAVIGATION;
    self.lineLabel.alpha = 0.5;
    [self.showView addSubview:self.lineLabel];
    
    //等级
    self.rankLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.imgButton.frame.size.height+16, self.imgButton.frame.size.width, 20)];
    self.rankLabel.text = @"给他评星";
    self.rankLabel.textColor = COLORMAMP(91,83,91,1);
    self.rankLabel.textAlignment = NSTextAlignmentCenter;
    self.rankLabel.font = [UIFont systemFontOfSize:14];
    [self.showView addSubview:self.rankLabel];
    
    //五颗星
    //self.showView.frame.size.width-self.imgButton.frame.size.height-16-20-5
    self.rankView = [[UIView alloc]initWithFrame:CGRectMake(self.imgButton.frame.size.width+15, self.imgButton.frame.size.height+20+10, self.showView.frame.size.width*2/3, 40)];
//    self.rankView.backgroundColor = [UIColor purpleColor];
    [self.showView addSubview:self.rankView];
    
    self.rankOneBut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, self.rankView.frame.size.height-15, self.rankView.frame.size.height-15)];
    [self.rankOneBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
    self.isOne = NO;
    [self.rankOneBut addTarget:self action:@selector(rankOneButClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.rankTwoBut = [[UIButton alloc]initWithFrame:CGRectMake(10+self.rankOneBut.frame.size.width+10, 10, self.rankView.frame.size.height-15, self.rankView.frame.size.height-15)];
    [self.rankTwoBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
    self.isTwo = NO;
    [self.rankTwoBut addTarget:self action:@selector(rankTwoButClick) forControlEvents:UIControlEventTouchUpInside];

    self.rankThreeBut = [[UIButton alloc]initWithFrame:CGRectMake(10+self.rankOneBut.frame.size.width+10+self.rankTwoBut.frame.size.width+10, 10, self.rankView.frame.size.height-15, self.rankView.frame.size.height-15)];
    [self.rankThreeBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
    self.isThree = NO;
    [self.rankThreeBut addTarget:self action:@selector(rankThreeButClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.rankFourBut = [[UIButton alloc]initWithFrame:CGRectMake(10+self.rankOneBut.frame.size.width+10+self.rankTwoBut.frame.size.width+10+self.rankThreeBut.frame.size.width+10, 10, self.rankView.frame.size.height-15, self.rankView.frame.size.height-15)];
    [self.rankFourBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
    self.isFour = NO;
    [self.rankFourBut addTarget:self action:@selector(rankFourButClick) forControlEvents:UIControlEventTouchUpInside];

    self.rankFiveBut = [[UIButton alloc]initWithFrame:CGRectMake(10+self.rankOneBut.frame.size.width+10+self.rankTwoBut.frame.size.width+10+self.rankThreeBut.frame.size.width+10+self.rankFourBut.frame.size.width+10, 10, self.rankView.frame.size.height-15, self.rankView.frame.size.height-15)];
    [self.rankFiveBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
    self.isFive = NO;
    [self.rankFiveBut addTarget:self action:@selector(rankFiveButClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.rankView addSubview:self.rankOneBut];
    [self.rankView addSubview:self.rankTwoBut];
    [self.rankView addSubview:self.rankThreeBut];
    [self.rankView addSubview:self.rankFourBut];
    [self.rankView addSubview:self.rankFiveBut];
    
    //写评价的TextView
    self.writeView = [[UITextView alloc]initWithFrame:CGRectMake(10, UISCREEN_HEIGHT/4+74+15, UISCREEN_WIDTH-20, self.showView.frame.size.height*2/3)];
    self.writeView.backgroundColor = [UIColor whiteColor];
    [self.writeView.layer setCornerRadius:6];
    self.writeView.font = [UIFont systemFontOfSize:15];
    self.writeView.textColor = [UIColor grayColor];
    
    self.proBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.writeView.frame.size.width, self.writeView.frame.size.height)];
    self.proBut.backgroundColor = [UIColor clearColor];
    [self.proBut setTitle:@"请写下对他的评价吧!" forState: UIControlStateNormal];
    [self.putInBut.layer setCornerRadius:6];
    [self.proBut setTitleColor:COLORMAMP(193,192,200,1) forState:UIControlStateNormal];
    self.proBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.proBut addTarget:self action:@selector(proButClick) forControlEvents:UIControlEventTouchUpInside];
    
    //提交按钮
    self.putInBut = [[UIButton alloc]initWithFrame:CGRectMake(10, UISCREEN_HEIGHT/4+74+15+self.writeView.frame.size.height+15, UISCREEN_WIDTH-20, 30)];
    self.putInBut.backgroundColor = COLORNAVIGATION;
    self.putInBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.putInBut setTitle:@"确定" forState:UIControlStateNormal];
    [self.putInBut.layer setCornerRadius:6];
    [self.putInBut setShowsTouchWhenHighlighted:YES];      //点击高亮
    [self.putInBut addTarget:self action:@selector(putInButClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.writeView addSubview:self.proBut];
    [self.view addSubview:self.showView];
    [self.view addSubview:self.writeView];
    [self.view addSubview:self.putInBut];
    
}

#pragma mark - 点击头像跳到个人资料界面
- (void)personalClick
{
    NSLog(@"跳到个人界面...");
    NSLog(@"%@",self.userDic);
    UserInfoViewController * user = [[UserInfoViewController alloc]init];
    
    [user setValue:self.userDic forKey:@"userDic"];
    
    [self.navigationController pushViewController:user animated:YES];
}

#pragma mark - 五个按钮的点击事件
- (void)rankOneButClick
{
    if(self.isOne == NO)
    {
        self.isOne = YES;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.rankOneBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            
        }];
    }
    else if (self.isOne == YES && self.isTwo == NO)
    {
        self.isOne = NO;
        [UIView animateWithDuration:0.5 animations:^{
            
             [self.rankOneBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            
        }];
    }
    else if (self.isOne == YES && self.isTwo == YES)
    {
        self.isOne = YES;
        self.isTwo = NO;
        self.isThree = NO;
        self.isFour = NO;
        self.isFive = NO;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.rankOneBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankThreeBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankFourBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankFiveBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            
        }];
    }

}
- (void)rankTwoButClick
{
    if (self.isTwo == NO)
    {
        self.isOne = YES;
        self.isTwo = YES;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.rankOneBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
             [self.rankTwoBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            
        }];
    }
    else if (self.isTwo == YES && self.isThree == NO)
    {
        self.isOne = NO;
        self.isTwo = NO;
        [UIView animateWithDuration:0.5 animations:^{

            [self.rankOneBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            
        }];
    }
    else if (self.isTwo == YES && self.isThree == YES)
    {
        self.isOne = YES;
        self.isTwo = YES;
        self.isThree = NO;
        self.isFour = NO;
        self.isFive = NO;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.rankOneBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankThreeBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankFourBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankFiveBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            
        }];
    }
}

- (void)rankThreeButClick
{
    if (self.isThree == NO)
    {
        self.isOne = YES;
        self.isTwo = YES;
        self.isThree = YES;
        [UIView animateWithDuration:0.5 animations:^{

            [self.rankOneBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankThreeBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            
        }];
    }
    else if (self.isThree == YES && self.isFour == NO)
    {
        self.isOne = NO;
        self.isTwo = NO;
        self.isThree = NO;
        [UIView animateWithDuration:0.5 animations:^{

            [self.rankOneBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankThreeBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            
        }];
    }
    else if (self.isThree == YES && self.isFour == YES)
    {
        self.isOne = YES;
        self.isTwo = YES;
        self.isThree = YES;
        self.isFour = NO;
        self.isFive = NO;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.rankOneBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankThreeBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankFourBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankFiveBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            
        }];
    }
}

- (void)rankFourButClick
{
    if (self.isFour == NO)
    {
        self.isOne = YES;
        self.isTwo = YES;
        self.isThree = YES;
        self.isFour = YES;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.rankOneBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankThreeBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankFourBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            
        }];
    }
    else if (self.isFour == YES && self.isFive == NO)
    {
        self.isOne = NO;
        self.isTwo = NO;
        self.isThree = NO;
        self.isFour = NO;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.rankOneBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankThreeBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankFourBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            
        }];
    }
    else if (self.isFour == YES && self.isFive == YES)
    {
        self.isOne = YES;
        self.isTwo = YES;
        self.isThree = YES;
        self.isFour = YES;
        self.isFive = NO;
        [UIView animateWithDuration:0.5 animations:^{

            [self.rankOneBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankThreeBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankFourBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankFiveBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            
        }];
    }
}

- (void)rankFiveButClick
{
    if (self.isFive == NO)
    {
        self.isOne = YES;
        self.isTwo = YES;
        self.isThree = YES;
        self.isFour = YES;
        self.isFive = YES;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.rankOneBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankThreeBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankFourBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            [self.rankFiveBut setImage:[UIImage imageNamed:@"lightStar"] forState:UIControlStateNormal];
            
        }];
    }
    else if (self.isFive == YES)
    {
        self.isOne = NO;
        self.isTwo = NO;
        self.isThree = NO;
        self.isFour = NO;
        self.isFive = NO;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self.rankOneBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankTwoBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankThreeBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankFourBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            [self.rankFiveBut setImage:[UIImage imageNamed:@"darkStar"] forState:UIControlStateNormal];
            
        }];
    }
}

#pragma mark - 提交按钮的点击事件
- (void)putInButClick
{
    int num = 0;
    
    if(self.isOne == YES){num++;}
    if(self.isTwo == YES){num++;}
    if(self.isThree == YES){num++;}
    if(self.isFour == YES){num++;}
    if(self.isFive == YES){num++;}
    
    self.num = num;
    if( num == 0)
    {                     //没有评价
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有评论哦!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else                              //有评价
    {
        self.commentHUD = [[MBProgressHUD alloc]initWithView:self.view];
        self.sview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        self.sview.backgroundColor = [UIColor blackColor];
        self.sview.alpha = 0.3;
        [self.view addSubview:self.sview];
        [self.sview addSubview:self.commentHUD];
        self.isClick = YES;
        self.commentHUD.delegate = self;
        self.commentHUD.labelText = @"提交中...";
        [self.commentHUD showWhileExecuting:@selector(commentData) onTarget:self withObject:nil animated:YES];
    }
}

#pragma mark - 数据操作
- (void)commentData
{
    //添加评价
    NSString * userid = self.l_userid;
    NSString * orderid = [self.orderDic objectForKey:@"l_order_orderid"];
    NSString * level = [NSString stringWithFormat:@"%d",self.num];
    NSString * matter = self.writeView.text;
    
    NSDictionary * commentInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  userid, @"userid",
                                  orderid, @"orderid",
                                  level, @"level",
                                  matter, @"matter"
                                  , nil];
    
    dataRequest * data = [[dataRequest alloc]init];
    
    [data insertCommentInfo:commentInfo and:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            //修改订单标识信息
            NSString * orderstatus = @"0";
            
            NSDictionary * orderStatus = [NSDictionary dictionaryWithObjectsAndKeys:
                                          orderid, @"orderid",
                                          orderstatus,   @"status"
                                          , nil];
            
            [data alterOrderId:orderStatus and:^(NSDictionary *dataDic) {
                
                [data alterCrazyOrderId:orderStatus and:^(NSDictionary *dataDic) {
                    
                    if([[dataDic objectForKey:@"code"] isEqualToString:@"succeed"])
                    {
                        NSLog(@"评论成功!");
                        self.str = @"评论成功!";
                        //发通知
                        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
                        [center postNotificationName:@"alterComment" object:self.orderDic];
                        
                        self.sview = 0;
                        self.isClick = NO;
                        
                        [self goJump];
                    }
                    else
                    {
                        NSLog(@"评论失败!");
                        self.str = @"评论失败!";
                        self.isClick = NO;
                        
                        [self goJump];
                    }
                    
                }];
            }];
        }
        else
        {
            NSLog(@"评论失败!");
            self.str = @"评论失败!";
            self.isClick = NO;
            
            [self goJump];
        }
        
    }];
    while(self.isClick){}
}

#pragma mark - 回跳（修改用户信用表）
- (void)goJump
{
    //信用表的数据操作
    NSString * userid = [self.userDic objectForKey:@"c_user_userid"];
    NSDictionary * useridDic = [NSDictionary dictionaryWithObjectsAndKeys:userid,   @"userid",   nil];
    dataRequest * data = [[dataRequest alloc]init];
    if(self.num >= 4)
    {
        //先读
        [data selectUserCredit:useridDic and:^(NSDictionary *dataDic) {
            
            //再写
            NSLog(@"*/*/*/*/*/*/*/*/*/*/*/*%@",dataDic);
            NSArray * arr = [dataDic objectForKey:@"value"];
            NSDictionary * dic = [arr firstObject];
            NSInteger fraction = [[dic objectForKey:@"creditinfo"] integerValue];
            fraction += 1;
            NSDictionary * creditDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                        userid,                                          @"userid",
                                        [NSString stringWithFormat:@"%ld",(long)fraction],     @"creditinfo",
                                        nil];
            [data insertUserCredit:creditDic and:^(NSDictionary *dataDic) {
                
                NSLog(@"-+-+-+-+-+-+-+-+--+-+-+-%@",dataDic);
            }];
        }];
    }
    
    //返回
    UIViewController *target = nil;
    for (UIViewController * controller in self.navigationController.viewControllers)
    { //遍历
        if ([controller isKindOfClass:[OrderViewController class]])
        {  //这里判断是否为你想要跳转的页面
            target = controller;
        }
    }
    if (target)
    {
        [self.navigationController popToViewController:target animated:YES]; //跳转
        
        //发通知
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"goValueAssess" object:self.str];
    }
}

#pragma mark - 提示水印的点击事件
- (void)proButClick
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.proBut.alpha = 0;
        [self.writeView becomeFirstResponder];

    }];
}

#pragma mark - 回退按钮的点击事件
- (void)goBeackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - 收起键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    if([self.writeView.text isEqualToString:@""])
    {
        [UIView animateWithDuration:0.5 animations:^{
            
            self.proBut.alpha = 1;
            
        }];
    }
}

@end
