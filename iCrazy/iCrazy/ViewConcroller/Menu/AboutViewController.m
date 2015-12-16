//
//  AboutViewController.m
//  iLazy
//
//  Created by Vic on 15/9/26.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

//背景
@property (strong, nonatomic) UIImageView * background;

//view
@property (strong, nonatomic) UIView * showView;

//新版本检测
@property (strong, nonatomic) UILabel * releaseLable;

//新版本检测Button
@property (strong, nonatomic) UIButton * releaseBut;

//是否是新版本
@property (strong, nonatomic) UILabel * releaseIsNo;

//线
@property (strong, nonatomic) UILabel * lineOne;

//开发团队
@property (strong, nonatomic) UILabel * teameLable;
@property (strong, nonatomic) UILabel * teameTail;

//开发团队Button
@property (strong, nonatomic) UIButton * teameBut;

//当前版本
@property (strong, nonatomic) UILabel * nonceRelease;

//点击之后
@property (strong, nonatomic) UIView * teameView;
@property (strong, nonatomic) UIButton * button;
@property (assign, nonatomic) BOOL isClick;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.background.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.background];
    
    //改变状态栏
    [self statusBar];
    
    //自定义navigation
    [self mynavigation];
    
    //界面设计
    [self interfaceDesign];
    
    self.teameView.alpha = 0;
    self.isClick = YES;
}

#pragma mark - 改变状态栏
//改变状态栏背景色
- (void)statusBar{
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor= COLORNAVIGATION;
    
    [self.view addSubview:statusBarView];
    
}
//改变状态栏文字为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - 自定义navigation
- (void)mynavigation{
    
    self.navigationController.navigationBarHidden = YES;      //隐藏原始默认导航条
    
    MyNavigation *myBar = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"" titleStr:@"关于懒人"];
    
    [myBar.leftBut addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:myBar];
}

#pragma mark - 界面设计
- (void)interfaceDesign
{
    //view
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(10, 74, UISCREEN_WIDTH-20, 150)];
    self.showView.backgroundColor = [UIColor whiteColor];
    //设置阴影
    [self.showView.layer setShadowColor:COLORNAVIGATION.CGColor];     //设置View的阴影颜色
    [self.showView.layer setShadowOpacity:0.5f];       //设置阴影的透明度
    [self.showView.layer setShadowOffset:CGSizeMake(2.0, 1.0)];      //设置阴影的偏移量
    [self.showView.layer setCornerRadius:8];
    [self.view addSubview:self.showView];
    
    //线
    self.lineOne = [[UILabel alloc]initWithFrame:CGRectMake(5, self.showView.bounds.size.height/2, self.showView.bounds.size.width-10, 1)];
    self.lineOne.backgroundColor = COLORMAMP(75, 195, 210, 1);
    self.lineOne.alpha = 0.3;
    
    [self.showView addSubview:self.lineOne];
    
    //新版本检测
    self.releaseLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.showView.bounds.size.width/2-30, self.showView.bounds.size.height/2)];
    self.releaseLable.text = @"检测新版本";
    self.releaseLable.font = [UIFont systemFontOfSize:15];
    self.releaseLable.textColor = COLORNAVIGATION;
    [self.showView addSubview:self.releaseLable];
    
    //是否是新版本
    self.releaseIsNo = [[UILabel alloc]initWithFrame:CGRectMake(self.showView.bounds.size.width/2, 0, self.showView.bounds.size.width/2-15, self.showView.bounds.size.height/2)];
    self.releaseIsNo.text = @"当前是最新版";
    self.releaseIsNo.font = [UIFont systemFontOfSize:12];
    self.releaseIsNo.textAlignment = NSTextAlignmentRight;
    self.releaseIsNo.textColor = COLORNAVIGATION;
    self.releaseIsNo.alpha = 0.7;
    [self.showView addSubview:self.releaseIsNo];
    
    //开发团队
    self.teameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, self.showView.bounds.size.height/2, self.showView.bounds.size.width/2-30, self.showView.bounds.size.height/2)];
    self.teameLable.text = @"开发团队";
    self.teameLable.font = [UIFont systemFontOfSize:15];
    self.teameLable.textColor = COLORNAVIGATION;
    
    [self.showView addSubview:self.teameLable];
    
    self.teameTail = [[UILabel alloc] initWithFrame:CGRectMake(self.showView.bounds.size.width/2, self.showView.bounds.size.height/2, self.showView.bounds.size.width/2-15, self.showView.bounds.size.height/2)];;
    self.teameTail.textColor = COLORNAVIGATION;
    self.teameTail.font = [UIFont systemFontOfSize:18];
    self.teameTail.textAlignment = NSTextAlignmentRight;
    self.teameTail.text = @">";
    
    [self.showView addSubview:self.teameTail];
    
    //新版本检测Button
    self.releaseBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.showView.bounds.size.width, self.showView.bounds.size.height/2)];
    self.releaseBut.backgroundColor = [UIColor clearColor];
    [self.releaseBut addTarget:self action:@selector(releaseClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showView addSubview:self.releaseBut];
    
    //开发团队Button
    self.teameBut = [[UIButton alloc]initWithFrame:CGRectMake(0, self.showView.bounds.size.height/2, self.showView.bounds.size.width, self.showView.bounds.size.height/2)];
    self.teameBut.backgroundColor = [UIColor clearColor];
    [self.teameBut addTarget:self action:@selector(teameClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showView addSubview: self.teameBut];
    
    //当前版本
    self.nonceRelease = [[UILabel alloc]initWithFrame:CGRectMake(10, 224, UISCREEN_WIDTH-20, 40)];
    self.nonceRelease.text = @"当前版本:V1.1.1";
    self.nonceRelease.font = [UIFont systemFontOfSize:12];
    self.nonceRelease.textAlignment = NSTextAlignmentCenter;
    self.nonceRelease.textColor = COLORNAVIGATION;
    self.nonceRelease.alpha = 0.7;
    
    [self.view addSubview:self.nonceRelease];
    
    //点击之后
    self.teameView = [[UIView alloc]initWithFrame:CGRectMake(10, 74, UISCREEN_WIDTH-20, UISCREEN_HEIGHT*2/3)];
    self.teameView.backgroundColor = [UIColor whiteColor];
    //设置阴影
    [self.teameView.layer setShadowColor:COLORNAVIGATION.CGColor];     //设置View的阴影颜色
    [self.teameView.layer setShadowOpacity:0.7f];       //设置阴影的透明度
    [self.teameView.layer setShadowOffset:CGSizeMake(0, 0)];      //设置阴影的偏移量
    [self.teameView.layer setCornerRadius:4];
    
    [self.view addSubview:self.teameView];
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(self.teameView.bounds.size.width-28, 4, 26, 26)];
    [self.button setImage:[UIImage imageNamed:@"tuichu_1"] forState:UIControlStateNormal];
    [self.button.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.button.layer setShadowOpacity:1.0f];
    [self.button.layer setShadowOffset:CGSizeMake(0, 0)];      //设置阴影的偏移量
    [self.button.layer setCornerRadius:13];
    [self.button addTarget:self action:@selector(hideClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.teameView addSubview:self.button];
    
    UILabel * name1 = [[UILabel alloc]initWithFrame:CGRectMake(10, self.teameView.bounds.size.height/3, self.teameView.bounds.size.width-20, 30)];
    name1.text = @"设计狮:  黄一璐";
    name1.textAlignment = NSTextAlignmentCenter;
    name1.font = [UIFont systemFontOfSize:15];
    name1.textColor = COLORMAMP(75, 195, 210, 1);
    
    UILabel * name1Line = [[UILabel alloc]initWithFrame:CGRectMake(30, self.teameView.bounds.size.height/3+name1.bounds.size.height+10, self.teameView.bounds.size.width-60, 0.5)];
    name1Line.backgroundColor = COLORMAMP(75, 195, 210, 1);
    [self.teameView addSubview:name1Line];
    
    UILabel * name2 = [[UILabel alloc]initWithFrame:CGRectMake(10, self.teameView.bounds.size.height/3+name1.bounds.size.height+10+20, self.teameView.bounds.size.width-20, 30)];
    name2.text = @"技术牛:  熊珍平";
    name2.textAlignment = NSTextAlignmentCenter;
    name2.font = [UIFont systemFontOfSize:15];
    name2.textColor = COLORMAMP(75, 195, 210, 1);
    
    UILabel * name2Line = [[UILabel alloc]initWithFrame:CGRectMake(20, self.teameView.bounds.size.height/3+name2.bounds.size.height+name1.bounds.size.height+40, self.teameView.bounds.size.width-40, 0.5)];
    name2Line.backgroundColor = COLORMAMP(75, 195, 210, 1);
    [self.teameView addSubview:name2Line];
    
    UILabel * name3 = [[UILabel alloc]initWithFrame:CGRectMake(10, self.teameView.bounds.size.height/3+name2.bounds.size.height+name1.bounds.size.height+40+20, self.teameView.bounds.size.width-20, 30)];
    name3.text = @"程序员:  吕   加";
    name3.textAlignment = NSTextAlignmentCenter;
    name3.font = [UIFont systemFontOfSize:15];
    name3.textColor = COLORMAMP(75, 195, 210, 1);
    
    UILabel * name3Line = [[UILabel alloc]initWithFrame:CGRectMake(10, self.teameView.bounds.size.height/3+name2.bounds.size.height+name1.bounds.size.height+40+20+name3.bounds.size.height+10, self.teameView.bounds.size.width-20, 0.5)];
    name3Line.backgroundColor = COLORMAMP(75, 195, 210, 1);
    [self.teameView addSubview:name3Line];
    
    [self.teameView addSubview:name1];
    [self.teameView addSubview:name2];
    [self.teameView addSubview:name3];
    
    //缩小
    [UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.teameView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 点击事件
- (void)releaseClick
{
    NSLog(@"没得更新");
}
- (void)teameClick
{
    if(self.isClick == YES)
    {
        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            self.teameView.alpha = 1;
            self.teameView.transform = CGAffineTransformMakeScale(1, 1);
            self.isClick = NO;
            
        } completion:^(BOOL finished) {
            
            self.showView.alpha = 0;
            self.nonceRelease.alpha = 0;
            
        }];
    }
    
}
- (void)hideClick
{
    if(self.isClick == NO)
    {
        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            self.teameView.alpha = 0;
            self.teameView.transform = CGAffineTransformMakeScale(0.2, 0.2);
            self.isClick = YES;
            self.showView.alpha = 1;
            self.nonceRelease.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma  mark - 返回首页
- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
