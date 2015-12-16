//
//  ServiceViewController.m
//  iLazy
//
//  Created by Vic on 15/9/26.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "ServiceViewController.h"
#import "MyNavigation.h"
#import "MapViewController.h"


@interface ServiceViewController ()<UIWebViewDelegate>


@property (strong, nonatomic) UIImageView *background;

//view
@property (strong, nonatomic) UIView * showView;

//帮助中心
@property (strong, nonatomic) UILabel * helpLable;
@property (strong, nonatomic) UILabel * helpTail;

//帮助中心Button
@property (strong, nonatomic) UIButton * helpBut;
@property (strong, nonatomic) UITextView * infoShow;

//线
@property (strong, nonatomic) UILabel * lineOne;

//意见反馈
@property (strong, nonatomic) UILabel * ideaLable;

//意见反馈Button
@property (strong, nonatomic) UIButton * ideaBut;
@property (strong, nonatomic) UILabel * iderTail;

//点击之后
@property (strong, nonatomic) UIView * minuteView;
@property (strong, nonatomic) UIButton * button;
@property (assign, nonatomic) BOOL isClick;

//展现正文
@property (strong, nonatomic) UIWebView * webView;


@end

@implementation ServiceViewController

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
    
    self.minuteView.alpha = 0;
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
    
    self.navigationController.navigationBarHidden = YES;      //隐藏默认导航条
    
    MyNavigation *myBar = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"" titleStr:@"服务"];
    
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
    
    //帮助中心
    self.helpLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.showView.bounds.size.width/2-30, self.showView.bounds.size.height/2)];
    self.helpLable.text = @"帮助中心";
    self.helpLable.font = [UIFont systemFontOfSize:15];
    self.helpLable.textColor = COLORNAVIGATION;
    
    [self.showView addSubview:self.helpLable];
    
    self.helpTail = [[UILabel alloc] initWithFrame:CGRectMake(self.showView.bounds.size.width/2, 0, self.showView.bounds.size.width/2-15, self.showView.bounds.size.height/2)];;
    self.helpTail.textColor = COLORNAVIGATION;
    self.helpTail.font = [UIFont systemFontOfSize:18];
    self.helpTail.textAlignment = NSTextAlignmentRight;
    self.helpTail.text = @">";
    
    [self.showView addSubview:self.helpTail];
    
    //意见反馈
    self.ideaLable = [[UILabel alloc]initWithFrame:CGRectMake(15, self.showView.bounds.size.height/2, self.showView.bounds.size.width/2-30, self.showView.bounds.size.height/2)];
    self.ideaLable.text = @"意见反馈";
    self.ideaLable.font = [UIFont systemFontOfSize:15];
    self.ideaLable.textColor = COLORNAVIGATION;
    
    [self.showView addSubview:self.ideaLable];
    
    self.iderTail = [[UILabel alloc] initWithFrame:CGRectMake(self.showView.bounds.size.width/2, self.showView.bounds.size.height/2, self.showView.bounds.size.width/2-15, self.showView.bounds.size.height/2)];;
    self.iderTail.textColor = COLORNAVIGATION;
    self.iderTail.font = [UIFont systemFontOfSize:18];
    self.iderTail.textAlignment = NSTextAlignmentRight;
    self.iderTail.text = @">";
    
    [self.showView addSubview:self.iderTail];
    
    //帮助中心Button
    self.helpBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.showView.bounds.size.width, self.showView.bounds.size.height/2)];
    self.helpBut.backgroundColor = [UIColor clearColor];
    [self.helpBut addTarget:self action:@selector(helpClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showView addSubview:self.helpBut];
    
    //意见反馈Button
    self.ideaBut = [[UIButton alloc]initWithFrame:CGRectMake(0, self.showView.bounds.size.height/2, self.showView.bounds.size.width, self.showView.bounds.size.height/2)];
    self.ideaBut.backgroundColor = [UIColor clearColor];
    [self.ideaBut addTarget:self action:@selector(ideaClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showView addSubview: self.ideaBut];
    
    //点击之后
    self.minuteView = [[UIView alloc]initWithFrame:CGRectMake(10, 74, UISCREEN_WIDTH-20, UISCREEN_HEIGHT*2/3)];
    self.minuteView.backgroundColor = [UIColor whiteColor];
    //设置阴影
    [self.minuteView.layer setShadowColor:COLORNAVIGATION.CGColor];     //设置View的阴影颜色
    [self.minuteView.layer setShadowOpacity:0.7f];       //设置阴影的透明度
    [self.minuteView.layer setShadowOffset:CGSizeMake(0, 0)];      //设置阴影的偏移量
    [self.minuteView.layer setCornerRadius:4];
    
    [self.view addSubview:self.minuteView];
    
    self.button = [[UIButton alloc]initWithFrame:CGRectMake(self.minuteView.bounds.size.width-28, 4, 26, 26)];
    [self.button setImage:[UIImage imageNamed:@"tuichu_1"] forState:UIControlStateNormal];
    [self.button.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.button.layer setShadowOpacity:1.0f];
    [self.button.layer setShadowOffset:CGSizeMake(0, 0)];      //设置阴影的偏移量
    [self.button.layer setCornerRadius:13];
    [self.button addTarget:self action:@selector(hideClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.minuteView addSubview:self.button];
    
    //展示帮助信息(正文)
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(10, 26, self.minuteView.bounds.size.width-20, self.minuteView.bounds.size.height-30)];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.minuteView addSubview:self.webView];
    
    NSString * filePath = [[NSBundle mainBundle]pathForResource:@"iSailor" ofType:@"html"];
    NSString * htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    //缩小
    [UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.minuteView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 点击事件
- (void)ideaClick
{
    NSLog(@"跳转页面");
    FeedbackViewController * feedBack = [[FeedbackViewController alloc]init];
    [self.navigationController pushViewController:feedBack animated:YES];
}
- (void)helpClick
{
    if(self.isClick == YES)
    {
        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            self.minuteView.alpha = 1;
            self.minuteView.transform = CGAffineTransformMakeScale(1, 1);
            self.isClick = NO;
            
        } completion:^(BOOL finished) {
            
            self.showView.alpha = 0;
            
        }];
    }
    
}
- (void)hideClick
{
    if(self.isClick == NO)
    {
        [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
            
            self.minuteView.alpha = 0;
            self.minuteView.transform = CGAffineTransformMakeScale(0.2, 0.2);
            self.isClick = YES;
            self.showView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

#pragma  mark - 返回首页
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
