//
//  DetailViewController.m
//  iLazy
//
//  Created by Administrator on 15/9/27.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "DetailViewController.h"
#import "MyNavigation.h"
#import "Macro.h"
#import "AlartViewController.h"
#import "dataRequest.h"
#import "OrderViewController.h"
#import "UserInfoViewController.h"
#import "UIButton+WebCache.h"

@interface DetailViewController ()<MyAlartViewDelegate>

//接收参数
@property (assign, nonatomic)NSString * isButSta;
@property (strong, nonatomic)NSDictionary * orderDic;
@property (strong, nonatomic)NSDictionary * userDic;

//顶部导航
@property (strong, nonatomic)MyNavigation * navigation;

//代替导航栏的view
@property (strong, nonatomic)UIView * barView;

//背景图片
@property (strong, nonatomic)UIImageView * backView;

@property (strong, nonatomic)NSString * touchPhone;

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

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //背景
    self.backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.backView.alpha = 0.8;
    [self.view addSubview:self.backView];
    
    //初始化展示信息view
    [self initShowView];
    
    //改变状态栏的颜色和字体颜色
    [self statusBar];
    
    //自定义顶部导航
    [self myNavigation];
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
    
    self.navigation = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"phone_b" titleStr:@"我的订单"];
    
    self.navigation.rightBut.frame = CGRectMake(UISCREEN_WIDTH-36, 31, 19, 19);
    
    [self.navigation.rightBut addTarget:self action:@selector(touchUser) forControlEvents:UIControlEventTouchUpInside];
    
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
    [self.imgButton sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState: UIControlStateNormal];
    
    [self.imgButton addTarget:self action:@selector(personalClick) forControlEvents:UIControlEventTouchUpInside];
    [self.imgView addSubview:self.imgButton];
    
    //昵称
    self.nickLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imgButton.frame.size.width+25, 5, self.showView.frame.size.width-10-self.imgButton.frame.size.width-20, self.imgButton.bounds.size.height)];
    
    NSString * nick = [self.userDic objectForKey:@"usernick"];
    NSString * phone = [self.userDic objectForKey:@"userphone"];
    
    self.nickLabel.text = [NSString stringWithFormat:@"%@(%@)",nick,phone];
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
    
    self.touchPhone = [self.orderDic objectForKey:@"orderphone"];
    
    //联系电话
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.imgButton.frame.size.height*2+15+5, self.showView.frame.size.width-10, 25)];
    self.phoneLabel.font = [UIFont systemFontOfSize:13];
    self.phoneLabel.textColor = COLORMAMP(135,135,135,1);
    self.phoneLabel.text = [NSString stringWithFormat:@"联系电话: %@",self.touchPhone];
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
    self.operateBut.titleLabel.textColor = [UIColor whiteColor];
    [self.operateBut setTitle:[NSString stringWithFormat:@"%@",self.isButSta] forState:UIControlStateNormal];
    [self.operateBut addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    [self.operateBut setShowsTouchWhenHighlighted:YES];      //点击高亮
    [view addSubview:self.operateBut];
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

#pragma mark - 按钮点击事件
- (void)butClick
{
    if([self.isButSta isEqualToString:@"删除"])
    {
        AlartViewController * alartViewController = [[AlartViewController alloc]init];
        [alartViewController deliverInfoLelf:@"取消" andRight:@"确定" andTitle:@"确定要删除吗?" andPoint:@"成功删除" andStatus:NO];
        alartViewController.delegate = self;
        [alartViewController showView:self.view];
    }
    
    else if ([self.isButSta isEqualToString:@"确定"])
    {
        AlartViewController * alartViewController = [[AlartViewController alloc]init];
        [alartViewController deliverInfoLelf:@"取消" andRight:@"确定" andTitle:@"确定完成订单吗?" andPoint:@"订单提交成功!" andStatus:NO];
        alartViewController.delegate = self;
        [alartViewController showView:self.view];
    }

}

#pragma mark - 提示框的代理方法
- (void)positiveButtonAction
{
    if([self.isButSta isEqualToString:@"删除"])
    {
        NSLog(@"删除订单");
        NSString * orderid = [self.orderDic objectForKey:@"orderid"];
        NSDictionary * orderDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                   orderid, @"orderid"
                                   , nil];
        //操作数据库
        dataRequest * data = [[dataRequest alloc]init];
        //删除数据库中的订单数据
        [data deleteCrazyOrderId:orderDic and:^(NSDictionary *dataDic) {
            
            [data deleteLazyOrderId:orderDic and:^(NSDictionary *dataDic) {
                
                NSString * code = [dataDic objectForKey:@"code"];
                if([code isEqualToString:@"succeed"])
                {
                    NSLog(@"成功删除第%@号订单",[self.orderDic objectForKey:@"orderid"]);
                    //发通知
                    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:@"deleOrder" object:self.orderDic];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    NSLog(@"删除失败!");
                }
                
            }];
            
        }];
    }
    
    else if ([self.isButSta isEqualToString:@"确定"])
    {
        NSLog(@"完成订单");
        NSString * orderid = [self.orderDic objectForKey:@"orderid"];
        NSString * status = [self.orderDic objectForKey:@"orderstatus"];
        
        dataRequest * data = [[dataRequest alloc]init];
        
        if([status isEqualToString:@"-1"])      //如果是待完成
        {
            NSString * orderstatus = @"1";         //变成已完成（另一个端的待评价）
            
            NSDictionary * orderStatus = [NSDictionary dictionaryWithObjectsAndKeys:
                                          orderid, @"orderid",
                                          orderstatus,   @"status"
                                          , nil];
            
            [data alterOrderId:orderStatus and:^(NSDictionary *dataDic) {
                
                [data alterCrazyOrderId:orderStatus and:^(NSDictionary *dataDic) {
                    
                    NSString * code = [dataDic objectForKey:@"code"];
                    if([code isEqualToString:@"succeed"])
                    {
                        NSLog(@"成功完成第%@号订单",[dataDic objectForKey:@"orderid"]);
                        //发通知
                        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
                        [center postNotificationName:@"alterStatus" object:self.orderDic];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else
                    {
                        NSLog(@"操作失败!");
                    }
                    
                }];
            }];

        }
    }
}

- (void)negativeButtonAction
{
    NSLog(@"你点击了取消!");
}

#pragma mark - 联系电话的点击事件
- (void)touchUser
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"确定要联系该用户吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        NSLog(@"拨号,打电话...%@",self.touchPhone);
        if([self.touchPhone isEqualToString:@""])
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"资料不完善!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            NSString * phone = [NSString stringWithFormat:@"tel://%@",self.touchPhone];
            UIApplication * app = [UIApplication sharedApplication];
            [app openURL:[NSURL URLWithString:phone]];
        }
    }];
    UIAlertAction * Action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:Action];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - 回退按钮的点击事件
- (void)goBeackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
