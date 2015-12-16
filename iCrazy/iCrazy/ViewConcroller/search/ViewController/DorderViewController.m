//
//  DorderViewController.m
//  iCrazy
//
//  Created by Administrator on 15/10/25.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "DorderViewController.h"
#import "Macro.h"
#import "MyNavigation.h"
#import "Request.h"
#import "UIButton+WebCache.h"
#import "MyAlert.h"
#import "MBProgressHUD.h"

@interface DorderViewController ()<MBProgressHUDDelegate>

//接受数据
@property (strong, nonatomic)NSDictionary * orderDic;
@property (strong, nonatomic)NSDictionary * userDic;

//顶部导航
@property (strong, nonatomic)MyNavigation * navigation;

//代替导航栏的view
@property (strong, nonatomic)UIView * barView;
@property (strong, nonatomic)UIImageView * backView;
//展示信息的view
@property (strong, nonatomic)UIView * showView;
@property (strong, nonatomic)UIView * imgView;            //头像
@property (strong, nonatomic)UIButton * imgButton;        //头像
@property (strong, nonatomic)UILabel * nickLabel;         //昵称
@property (strong, nonatomic)UILabel * detailLabel;       //订单详情
@property (strong, nonatomic)UILabel * phoneLabel;        //电话号码
@property (strong, nonatomic)UILabel * priceLabel;        //金额
@property (strong, nonatomic)UILabel * insuranceLabel;    //保险
@property (strong, nonatomic)UILabel * remarkLabel;       //备注
@property (strong, nonatomic)UIButton * operateBut;       //按钮

@property (strong, nonatomic)NSString * c_userid;

//抢单成功提示框
@property (strong, nonatomic) MyAlert *rushSucceed;
//抢单失败提示框
@property (strong, nonatomic) MyAlert *rushFail;

//加载圈圈
@property (strong, nonatomic) MBProgressHUD * hubView;

@property (assign, nonatomic) BOOL isHUD;

@end

@implementation DorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isHUD = YES;
    
    //背景
    self.backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.backView];
    
    [self initShowView];
    
    [self myNavigation];
    
    [self statusBar];
    
    NSLog(@".......%@",self.userDic);
    
    //抢单成功提示
    self.rushSucceed = [[MyAlert alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-75, UISCREEN_HEIGHT/2-22.5, 150, 45) WithNameStr:@"被你抢到啦≧▽≦"];
    
    //抢单成功提示
    self.rushFail = [[MyAlert alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-75, UISCREEN_HEIGHT/2-22.5, 150, 45) WithNameStr:@"抢不到啦>_<"];
}

#pragma mark - 改变状态栏的颜色
- (void)statusBar
{
    self.barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 20)];
    self.barView.backgroundColor = COLORNAVIGATION;
    [self.view addSubview:self.barView];
}

#pragma mark - 状态栏字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - 自定义顶部导航
- (void)myNavigation
{
    self.navigation = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:nil titleStr:@"我的订单"];
    
    self.navigation.rightBut.frame = CGRectMake(UISCREEN_WIDTH-36, 31, 19, 19);
    
    
    [self.navigation.leftBut addTarget:self action:@selector(goBeackClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.navigation];
}

#pragma mark - 初始化展示信息view
- (void)initShowView
{
    //展示信息的view
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(10, 74, UISCREEN_WIDTH-20, UISCREEN_HEIGHT/2)];
    self.showView.backgroundColor = [UIColor whiteColor];
    [self.showView.layer setCornerRadius:6];
    [self.view addSubview:self.showView];
    
    //头像
    self.imgView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, self.showView.frame.size.width/5, self.showView.frame.size.width/5)];
    [self.imgView.layer setCornerRadius:5];
    self.imgView.clipsToBounds = YES;
    [self.showView addSubview:self.imgView];
    
    self.imgButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.imgView.frame.size.width, self.imgView.frame.size.height)];
    
    //同步获取网络图片
    NSString * url = [NSString stringWithFormat:@"%@%@",LAZY_IMAGE_PATH,[self.userDic objectForKey:@"userimage"]];
//    UIImage * internetImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
//    
//    [self.imgButton setImage:internetImage forState:UIControlStateNormal];
    [self.imgButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
    [self.imgView addSubview:self.imgButton];
    
    //昵称
    self.nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imgButton.frame.size.width+25, 5, self.showView.frame.size.width-10-self.imgButton.frame.size.width-20, self.imgButton.bounds.size.height)];
    
    NSString * nick = [self.userDic objectForKey:@"usernick"];
   
    
    self.nickLabel.text = [NSString stringWithFormat:@"%@",nick];
    self.nickLabel.font = [UIFont systemFontOfSize:15];
    self.nickLabel.textColor = COLORMAMP(91,83,91,1);
    [self.showView addSubview:self.nickLabel];
    
    //订单详情
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.imgButton.frame.size.height+15, self.showView.frame.size.width-10, self.imgButton.frame.size.height)];
    
    NSString * detail = [self.orderDic objectForKey:@"orderdetail"];

    self.detailLabel.text = detail;
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.textColor = COLORMAMP(135,135,135,1);
    [self.showView addSubview:self.detailLabel];
    
    NSString  *touchPhone = [self.orderDic objectForKey:@"orderphone"];
    
    //联系电话
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.imgButton.frame.size.height*2+15+5, self.showView.frame.size.width-10, 25)];
    self.phoneLabel.font = [UIFont systemFontOfSize:13];
    self.phoneLabel.textColor = COLORMAMP(135,135,135,1);
    self.phoneLabel.text = [NSString stringWithFormat:@"联系电话: %@",touchPhone];
    [self.showView addSubview:self.phoneLabel];
    
    //酬金
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.imgButton.frame.size.height*2+15+5+20+5, self.showView.frame.size.width-10, 25)];
    self.priceLabel.font = [UIFont systemFontOfSize:13];
    self.priceLabel.textColor = COLORMAMP(135,135,135,1);
    
    NSString * price = [self.orderDic objectForKey:@"orderprice"];
    
    self.priceLabel.text = [NSString stringWithFormat:@"酬       劳: %@%@",price,@"元"];
    [self.showView addSubview:self.priceLabel];
    
    //保险
    self.insuranceLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.imgButton.frame.size.height*2+15+5+20+5+5+20, self.showView.frame.size.width-10, 25)];
    self.insuranceLabel.font = [UIFont systemFontOfSize:13];
    self.insuranceLabel.textColor = COLORMAMP(135,135,135,1);
    
    NSString * insurance = [self.orderDic objectForKey:@"orderinsurance"];
    
    if([insurance isEqualToString:@"0"])
    {
        self.insuranceLabel.text = [NSString stringWithFormat:@"保险类型: %@",@"无"];
    }
    else if ([insurance isEqualToString:@"1"])
    {
        self.insuranceLabel.text = [NSString stringWithFormat:@"保险类型: %@",@"1元统保"];
    }
    [self.showView addSubview:self.insuranceLabel];
    
    //备注
    self.remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.imgButton.frame.size.height*2+15+5+20+5+5+20+5+20, self.showView.frame.size.width-10, 25)];
    self.remarkLabel.font = [UIFont systemFontOfSize:13];
    self.remarkLabel.textColor = COLORMAMP(135,135,135,1);
    
    NSString * remark = [self.orderDic objectForKey:@"orderremark"];
    
    self.remarkLabel.text = [NSString stringWithFormat:@"备       注: %@",remark];
    [self.showView addSubview:self.remarkLabel];
    
    //相应按钮
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(5, self.showView.frame.size.height-5-30, self.showView.frame.size.width-10, 30)];
    [self.showView addSubview:view];
    
    self.operateBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    self.operateBut.backgroundColor = COLORNAVIGATION;
    self.operateBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.operateBut.layer setCornerRadius:6];
    [self.operateBut setTitle:@"抢单" forState:UIControlStateNormal];
    self.operateBut.titleLabel.textColor = [UIColor whiteColor];
    [self.operateBut setShowsTouchWhenHighlighted:YES];      //点击高亮
    [self.operateBut addTarget:self action:@selector(grap) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.operateBut];
}

#pragma mark - 无订单提示框
- (void)MyAlert:(MyAlert *)alert{

    [UIView animateWithDuration:1 animations:^{
        
        alert.alpha = 0.3;
        
        [self.view addSubview:alert];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            
            alert.alpha = 0;
        }];
    }];
}

#pragma mark - 加载圈圈
- (void)upLoad
{
    NSString *l_userid  = [self.orderDic objectForKey:@"l_user_userid"];
    NSString *orderid   = [self.orderDic objectForKey:@"orderid"];
    NSString *title     = [self.orderDic objectForKey:@"ordertitle"];
    NSString *price     = [self.orderDic objectForKey:@"orderprice"];
    NSString *insurance = [self.orderDic objectForKey:@"orderinsurance"];
    NSString *detail    = [self.orderDic objectForKey:@"orderdetail"];
    NSString *Remark    = [self.orderDic objectForKey:@"orderremark"];
    NSString *phone     = [self.orderDic objectForKey:@"orderphone"];
    
    NSDictionary *orderDica = [NSDictionary dictionaryWithObject:orderid forKey:@"orderid"];
    
    Request *request = [[Request alloc]init];
    
    [request queryorderid:orderDica and:^(NSDictionary *dataOrderDic) {
        
        NSString * strw = [dataOrderDic objectForKey:@"code"];
        
        NSArray * digArray = [dataOrderDic objectForKey:@"value"];
        
        NSDictionary * dig = [digArray firstObject];
        
        if ([strw isEqualToString:@"succeed"]) {
            
            if ([[dig objectForKey:@"orderstatus"] isEqualToString:@"2"])
            {
                
                NSMutableDictionary *status = [[NSMutableDictionary alloc]init];
                [status setObject:l_userid forKey:@"userid"];
                [status setObject:orderid forKey:@"orderid"];
                [status setObject:@"-1" forKey:@"status"];
                
                [request alfterorder:status and:^(NSDictionary *dataDic)
                 {
                     NSString *statusstr = [dataDic objectForKey:@"code"];
                     if ([statusstr isEqualToString:@"succeed"])
                     {
                         
                         NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
                         [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                         NSString *currentTime = [formatter stringFromDate:[NSDate date]];
                         
                         NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                         [dict setValue:orderid forKey:@"orderid"];
                         [dict setValue:self.c_userid forKey:@"userid"];
                         [dict setValue:title forKey:@"title"];
                         [dict setValue:@"-1" forKey:@"status"];
                         [dict setValue:price forKey:@"price"];
                         [dict setValue:currentTime forKey:@"time"];
                         [dict setValue:insurance forKey:@"insurance"];
                         [dict setValue:detail forKey:@"detail"];
                         [dict setValue:Remark forKey:@"remark"];
                         [dict setValue:phone forKey:@"phone"];
                         
                         [request insertorder:dict and:^(NSDictionary *dataDic)
                          {
                              NSString *insert = [dataDic objectForKey:@"code"];
                              
                              if ([insert isEqualToString:@"succeed"])
                              {
                                  NSLog(@"！！！！插入成功！！");
                                  
                                  self.isHUD = NO;
                                  
                                  //发通知
                                  NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
                                  [center postNotificationName:@"searchOrder" object:self.orderDic];
                                  [center postNotificationName:@"graporder" object:nil];
                                  
                                  [self.navigationController popViewControllerAnimated:YES];
                                  
                              }
                              else
                              {
                                  //抢单失败提示
                                  [self MyAlert:self.rushFail];
                                  self.isHUD = NO;
                              }
                          }];
                     }
                     else
                     {
                         //抢单失败提示
                         [self MyAlert:self.rushFail];
                         self.isHUD = NO;
                         NSLog(@"失败");
                     }
                 }];
            }
            else
            {
                //抢单失败提示
                [self MyAlert:self.rushFail];
                self.isHUD = NO;
            }
        }
        else
        {
            //抢单失败提示
            [self MyAlert:self.rushFail];
            self.isHUD = NO;
        }
    }];
    while (self.isHUD) {}
}

#pragma mark - 按钮点击事件
- (void)grap
{
    //初始化加载圈圈
    self.isHUD = YES;
    
    self.hubView = [[MBProgressHUD alloc]initWithView:self.view];
    self.hubView.delegate = self;
    self.hubView.labelText = @"正在抢...";
    [self.view addSubview:self.hubView];
    
    [self.hubView showWhileExecuting:@selector(upLoad) onTarget:self withObject:nil animated:YES];
}

#pragma mark - 回退按钮的点击事件
- (void)goBeackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
