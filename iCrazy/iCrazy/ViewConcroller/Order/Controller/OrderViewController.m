//
//  OrderViewController.m
//  iLazy
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "OrderViewController.h"
#import "SwitchView.h"
#import "MapViewController.h"
@interface OrderViewController ()

//顶部导航
@property (strong, nonatomic)MyNavigation * navigation;

//代替导航栏的view
@property (strong, nonatomic)UIView * barView;

//顶部导航下方按钮view
@property (strong, nonatomic)UIView * butView;

//顶部导航下方按钮view中的view
@property (strong, nonatomic)UIView * showView;

//完成订单按钮
@property (strong ,nonatomic)UIButton * finishBut;

//待完成订单按钮
@property (strong ,nonatomic)UIButton * unFinishBut;

//页面的切换
@property (strong, nonatomic)SwitchView * switchView;

//假定由主页传过来的用户信息(这里假定c_user为1的用户)
@property (strong, nonatomic)NSString * c_userid;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //初始化三个页面
    [self initSwitchView];
    
    //自定义顶部导航
    [self myNavigation];
    
    //改变状态栏颜色
    [self statusBar];
    
    //初始化按钮view
    [self initButView];

    //观察者
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(loseefficacy) name:@"loseEfficacy" object:nil];
    [center addObserver:self selector:@selector(becomeefficacy) name:@"becomeEfficacy" object:nil];
}

#pragma mark - 通知方法
- (void)loseefficacy
{
    self.finishBut.userInteractionEnabled = NO;
    self.unFinishBut.userInteractionEnabled = NO;
    self.navigation.leftBut.userInteractionEnabled = NO;
}

- (void)becomeefficacy
{
    self.finishBut.userInteractionEnabled = YES;
    self.unFinishBut.userInteractionEnabled = YES;
    self.navigation.leftBut.userInteractionEnabled = YES;
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

#pragma mark - 自定义顶部导航栏
- (void)myNavigation
{
    
    self.navigation = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"" titleStr:@"我的订单"];
    
    [self.navigation.leftBut addTarget:self action:@selector(goBeackClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.navigation];
}

#pragma mark - 初始化顶部导航下方按钮view
- (void)initButView
{
    self.butView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, 30)];
    
    self.butView.backgroundColor = COLORNAVIGATION;
    
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, UISCREEN_WIDTH-40, 26)];
    
    self.showView.backgroundColor = [UIColor whiteColor];
    
    self.showView.layer.borderWidth = 0.6;
    
    self.showView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.showView.layer setCornerRadius:6];
    
    self.showView.clipsToBounds = YES;        //适应它的形状
    
    [self.view addSubview:self.butView];
    
    [self.butView addSubview:self.showView];
    
    //初始化按钮
    [self initButton];
}

#pragma mark - 按钮的摆布
- (void)initButton
{
    self.finishBut = [[UIButton alloc]initWithFrame:CGRectMake(1, 1, self.showView.bounds.size.width/2, 24)];
    self.unFinishBut = [[UIButton alloc]initWithFrame:CGRectMake(self.showView.bounds.size.width/2, 1, self.showView.bounds.size.width/2, 24)];
    
    self.finishBut.backgroundColor = COLORNAVIGATION;
    self.unFinishBut.backgroundColor = [UIColor whiteColor];
    
    [self.finishBut setTitle:@"已完成" forState:UIControlStateNormal];
    [self.unFinishBut setTitle:@"待完成" forState:UIControlStateNormal];
    
    [self.finishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.unFinishBut setTitleColor:COLORNAVIGATION forState:UIControlStateNormal];
    
    self.finishBut.titleLabel.font  = [UIFont systemFontOfSize:12];
    self.unFinishBut.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.showView addSubview:self.finishBut];
    [self.showView addSubview:self.unFinishBut];
    
    //点击事件
    [self.finishBut addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    [self.unFinishBut addTarget:self action:@selector(unFinishClick) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 切换按钮的点击事件
//已完成按钮
- (void)finishClick
{
    self.finishBut.backgroundColor = [UIColor whiteColor];
    [self.finishBut setTitleColor:COLORNAVIGATION forState:UIControlStateNormal];
    
    self.unFinishBut.backgroundColor = COLORNAVIGATION;
    [self.unFinishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //展示完成页面
    [self.switchView switchFinishView];
    
}
//待完成按钮
- (void)unFinishClick
{
    self.finishBut.backgroundColor = COLORNAVIGATION;
    [self.finishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.unFinishBut.backgroundColor = [UIColor whiteColor];
    [self.unFinishBut setTitleColor:COLORNAVIGATION forState:UIControlStateNormal];
    
    //展示待完成页面
    [self.switchView switchUnFinishView];

}

#pragma mark - 回退按钮的点击事件
- (void)goBeackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 初始化两个切换页面
- (void)initSwitchView
{
    self.switchView = [[SwitchView alloc] initWithSwitchView:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT) andId:self.c_userid];

    [self.view addSubview:self.switchView];
}

@end
