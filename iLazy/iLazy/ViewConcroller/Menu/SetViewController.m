//
//  SettingViewController.m
//  iLazy
//
//  Created by Vic on 15/9/26.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "SetViewController.h"
#import "MyNavigation.h"
#import "MapViewController.h"
#import "LoginViewController.h"
#import "SaveLogin.h"
#import "UIImageView+WebCache.h"

@interface SetViewController ()

//view
@property (strong, nonatomic) UIView * showView;

//清除缓存
@property (strong, nonatomic) UILabel * cacheLable;
//清除缓存Button
@property (strong, nonatomic) UIButton * cacheBut;
//缓存提示
@property (strong, nonatomic) UILabel * cacheIsNo;

//线
@property (strong, nonatomic) UILabel * lineOne;

//退出按钮
@property (strong, nonatomic) UILabel * exitLable;
@property (strong, nonatomic) UIButton * exitBut;

//缓存文件个数
@property (assign, nonatomic) NSInteger fileCount;

//缓存问价大小
@property (assign, nonatomic) double totalSize;

//提示信息
@property (strong, nonatomic) NSString * point;

@end

@implementation SetViewController

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
}

#pragma mark - 改变状态栏
//改变状态栏背景色
- (void)statusBar
{
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor= COLORNAVIGATION;
    
    [self.view addSubview:statusBarView];
    
}
//改变状态栏文字为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
}


#pragma mark - 自定义navigation
- (void)mynavigation
{
    
    self.navigationController.navigationBarHidden = YES;      //隐藏默认导航条
    
    MyNavigation *myBar = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"" titleStr:@"设置"];
    
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
    
    //线One
    self.lineOne = [[UILabel alloc]initWithFrame:CGRectMake(5, self.showView.bounds.size.height/2, self.showView.bounds.size.width-10, 1)];
    self.lineOne.backgroundColor = COLORMAMP(75, 195, 210, 1);
    self.lineOne.alpha = 0.3;
    
    [self.showView addSubview:self.lineOne];
    
    //清除缓存
    self.cacheLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.showView.bounds.size.width/2-30, self.showView.bounds.size.height/2)];
    self.cacheLable.text = @"清除缓存";
    self.cacheLable.font = [UIFont systemFontOfSize:15];
    self.cacheLable.textColor = COLORNAVIGATION;
    [self.showView addSubview:self.cacheLable];
    
    //缓存提示
    self.cacheIsNo = [[UILabel alloc]initWithFrame:CGRectMake(self.showView.bounds.size.width/2, 0, self.showView.bounds.size.width/2-15, self.showView.bounds.size.height/2)];
    [self cacheClick];
//    self.cacheIsNo.text = @"包括: 图片、数据等";
    self.cacheIsNo.font = [UIFont systemFontOfSize:14];
    self.cacheIsNo.textAlignment = NSTextAlignmentRight;
    self.cacheIsNo.textColor = COLORNAVIGATION;
    self.cacheIsNo.alpha = 0.7;
    
    [self.showView addSubview:self.cacheIsNo];
    
    //清除缓存Button
    self.cacheBut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.showView.bounds.size.width, self.showView.bounds.size.height/2)];
    self.cacheBut.backgroundColor = [UIColor clearColor];
    [self.cacheBut addTarget:self action:@selector(cacheClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showView addSubview:self.cacheBut];
 
    //退出登录
    self.exitLable = [[UILabel alloc]initWithFrame:CGRectMake(15, self.showView.bounds.size.height/2, self.showView.bounds.size.width/2-30, self.showView.bounds.size.height/2)];
    self.exitLable.text = @"退出登录";
    self.exitLable.font = [UIFont systemFontOfSize:15];
    self.exitLable.textColor = COLORNAVIGATION;
    
    [self.showView addSubview:self.exitLable];
    
    //退出登录按钮
    self.exitBut = [[UIButton alloc]initWithFrame:CGRectMake(0, self.showView.bounds.size.height/2, self.showView.bounds.size.width, self.showView.bounds.size.height/2)];
    self.exitBut.backgroundColor = [UIColor clearColor];

    [self.exitBut addTarget:self action:@selector(exitButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.showView addSubview:self.exitBut];
}

#pragma mark - 点击事件
- (void)cacheClick: (UIButton *)sender
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"清除缓存" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
                //清除缓存
        [[[SDWebImageManager sharedManager] imageCache] clearDisk];       //磁盘
        [[[SDWebImageManager sharedManager] imageCache] clearMemory];     //内存
        [[NSURLCache sharedURLCache] removeAllCachedResponses];           //iOS7中使用（缓存机制做了修改）
            
        //刷新页面
        [self cacheClick];
                
    }];
    UIAlertAction * canAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:canAction];
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 计算缓存
- (void)cacheClick
{
    //输出沙盒地址
    NSLog(@"-+-+-+-+-+-+%@",NSHomeDirectory());
    
    //计算缓存大小
    [SDWebImageManager.sharedManager.imageCache calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {

        self.fileCount = fileCount;
        self.totalSize = totalSize/1000.0;

        //提示信息
        if (self.totalSize < 1024)
        {
//            self.point = [NSString stringWithFormat:@"缓存大小为%.2fK.确定要清理缓存吗?",self.totalSize];
            self.cacheIsNo.text = [NSString stringWithFormat:@"%.2fK",self.totalSize]; //显示
        }
        else if (self.totalSize >= 1024 && self.totalSize < 1024*1024)
        {
//            self.point = [NSString stringWithFormat:@"缓存大小为%.2fM.确定要清理缓存吗?",self.totalSize/1024.0];
            self.cacheIsNo.text = [NSString stringWithFormat:@"%.2fM",self.totalSize/1024.0];         //显示
        }
        else if (self.totalSize >= 1024*1024)
        {
//            self.point = [NSString stringWithFormat:@"缓存大小为%.2fG.确定要清理缓存吗?",self.totalSize/1024/1024.0];
            self.cacheIsNo.text = [NSString stringWithFormat:@"%.2fG",self.totalSize/1024/1024.0];       //显示
        }
     }];
}

#pragma mark - 退出登录事件
- (void)exitButClick
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
    {
        //(取出)操作本地plist
        SaveLogin *userlogin = [[SaveLogin alloc]init];
        
        [userlogin getInfo:^(NSMutableDictionary *dic) {

            self.plistDic = dic;
            
            //(写入)操作本地plist
            [self.plistDic setObject:@"" forKey:@"password"];
            
            [userlogin saveInfo:self.plistDic andSuccess:^(NSString *str) {
                
                if([str isEqualToString:@"存入成功"])
                {
                    //返回
//                    for (UIViewController * controller in self.navigationController.viewControllers)
//                    { //遍历
//                        if ([controller isKindOfClass:[LoginViewController class]])
//                        {  //这里判断是否为你想要跳转的页面
//                            [self.navigationController popToViewController:controller animated:YES];              //跳转
//                        }
//                    }
                    LoginViewController * log = [[LoginViewController alloc]init];
                    AppDelegate * app = [UIApplication sharedApplication].delegate;
                    [app.rootNav pushViewController:log animated:YES];
                }
                
            }];
        }];

     }];
    
    UIAlertAction *canserAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        NSLog(@"点击了取消!");
    }];
    
    [alert addAction:okAction];
    [alert addAction:canserAction];

    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 退出
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
//    MapViewController *mapview = [[MapViewController alloc]init];
//    [self.navigationController pushViewController:mapview animated:YES];
}

@end
