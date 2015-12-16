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

//评价按钮
@property (strong, nonatomic)UIButton * assessBut;

//未接订单的按钮
@property (strong, nonatomic)UIButton * unCarryBut;

//页面的切换
@property (strong, nonatomic)SwitchView * switchView;

//假定由主页传过来的用户信息(这里假定l_user为2的用户)
@property (strong, nonatomic)NSString * l_userid;

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

    //返回时
    [center addObserver:self selector:@selector(goValue:) name:@"goValueAssess" object:nil];
    
    self.prompt = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-50, UISCREEN_HEIGHT*4/6, 100, 42)];
    self.prompt.backgroundColor = [UIColor clearColor];
    self.prompt.alpha = 0.5;
    self.prompt.textColor = COLORNAVIGATION;
    self.prompt.textAlignment = NSTextAlignmentCenter;
    self.prompt.font = [UIFont systemFontOfSize:15];
    [self.prompt.layer setCornerRadius:5];
    self.prompt.alpha = 0;
    [self.view addSubview:self.prompt];
}

#pragma mark - 通知方法
- (void)loseefficacy
{
    self.unCarryBut.userInteractionEnabled = NO;
    self.finishBut.userInteractionEnabled = NO;
    self.unFinishBut.userInteractionEnabled = NO;
    self.assessBut.userInteractionEnabled = NO;
    self.navigation.leftBut.userInteractionEnabled = NO;
}

- (void)becomeefficacy
{
    self.unCarryBut.userInteractionEnabled = YES;
    self.finishBut.userInteractionEnabled = YES;
    self.unFinishBut.userInteractionEnabled = YES;
    self.assessBut.userInteractionEnabled = YES;
    self.navigation.leftBut.userInteractionEnabled = YES;
}

- (void)goValue:(NSNotification *)cation
{
    self.prompt.text = cation.object;
    [UIView animateWithDuration:3 animations:^{
        self.prompt.alpha = 1;
    }];

    [UIView animateWithDuration:2.5 animations:^{
        
        self.prompt.transform = CGAffineTransformMakeScale(5, 5);
        self.prompt.alpha = 0;
    } completion:^(BOOL finished) {
        
        self.prompt.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

#pragma mark - 加载时调用
- (void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:YES];

    self.prompt.alpha = 0;
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
    
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, UISCREEN_WIDTH-20, 26)];
    
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
    self.finishBut = [[UIButton alloc]initWithFrame:CGRectMake(1, 1, self.showView.bounds.size.width/4, 24)];
    self.unFinishBut = [[UIButton alloc]initWithFrame:CGRectMake(self.showView.bounds.size.width/4, 1, self.showView.bounds.size.width/4, 24)];
    self.assessBut = [[UIButton alloc]initWithFrame:CGRectMake(self.showView.bounds.size.width*2/4, 1, self.showView.bounds.size.width/4, 24)];
    self.unCarryBut = [[UIButton alloc]initWithFrame:CGRectMake(self.showView.bounds.size.width*3/4, 1, self.showView.bounds.size.width/4, 24)];
    
    self.finishBut.backgroundColor = COLORNAVIGATION;
    self.unFinishBut.backgroundColor = [UIColor whiteColor];
    self.assessBut.backgroundColor = COLORNAVIGATION;
    self.unCarryBut.backgroundColor = COLORNAVIGATION;
    
    [self.finishBut setTitle:@"已完成" forState:UIControlStateNormal];
    [self.unFinishBut setTitle:@"待完成" forState:UIControlStateNormal];
    [self.assessBut setTitle:@"未评价" forState:UIControlStateNormal];
    [self.unCarryBut setTitle:@"待接单" forState:UIControlStateNormal];
    
    [self.finishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.unFinishBut setTitleColor:COLORNAVIGATION forState:UIControlStateNormal];
    [self.assessBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.unCarryBut setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
    
    self.finishBut.titleLabel.font  = [UIFont systemFontOfSize:12];
    self.unFinishBut.titleLabel.font = [UIFont systemFontOfSize:12];
    self.assessBut.titleLabel.font = [UIFont systemFontOfSize:12];
    self.unCarryBut.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.showView addSubview:self.finishBut];
    [self.showView addSubview:self.unFinishBut];
    [self.showView addSubview:self.assessBut];
    [self.showView addSubview:self.unCarryBut];
    
    //点击事件
    [self.finishBut addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    [self.unFinishBut addTarget:self action:@selector(unFinishClick) forControlEvents:UIControlEventTouchUpInside];
    [self.assessBut addTarget:self action:@selector(assessClick) forControlEvents:UIControlEventTouchUpInside];
    [self.unCarryBut addTarget:self action:@selector(unCarryClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 切换按钮的点击事件
//已完成按钮
- (void)finishClick
{
    self.finishBut.backgroundColor = [UIColor whiteColor];
    [self.finishBut setTitleColor:COLORNAVIGATION forState:UIControlStateNormal];
    
    self.unFinishBut.backgroundColor = COLORNAVIGATION;
    [self.unFinishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.assessBut.backgroundColor = COLORNAVIGATION;
    [self.assessBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.unCarryBut.backgroundColor = COLORNAVIGATION;
    [self.unCarryBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
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
    
    self.assessBut.backgroundColor = COLORNAVIGATION;
    [self.assessBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.unCarryBut.backgroundColor = COLORNAVIGATION;
    [self.unCarryBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //展示待完成页面
    [self.switchView switchUnFinishView];

}
//待评价按钮
- (void)assessClick
{
    self.finishBut.backgroundColor = COLORNAVIGATION;
    [self.finishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.unFinishBut.backgroundColor = COLORNAVIGATION;
    [self.unFinishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.assessBut.backgroundColor = [UIColor whiteColor];
    [self.assessBut setTitleColor:COLORNAVIGATION forState:UIControlStateNormal];
    
    self.unCarryBut.backgroundColor = COLORNAVIGATION;
    [self.unCarryBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //展示待评价页面
    [self.switchView switchAssessView];
}
//未被接单的按钮点击事件
- (void)unCarryClick
{
    self.finishBut.backgroundColor = COLORNAVIGATION;
    [self.finishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.unFinishBut.backgroundColor = COLORNAVIGATION;
    [self.unFinishBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.assessBut.backgroundColor = COLORNAVIGATION;
    [self.assessBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.unCarryBut.backgroundColor = [UIColor whiteColor];
    [self.unCarryBut setTitleColor:COLORNAVIGATION forState:UIControlStateNormal];
    
    //展示带接单页面
    [self.switchView switchUnCarryView];
}

#pragma mark - 回退按钮的点击事件
- (void)goBeackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 初始化三个切换页面
- (void)initSwitchView
{
    self.switchView = [[SwitchView alloc]initWithSwitchView:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT) andId:self.l_userid];
    [self.view addSubview:self.switchView];
}

@end
