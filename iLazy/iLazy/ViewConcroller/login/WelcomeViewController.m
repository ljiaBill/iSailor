//
//  WelcomeViewController.m
//  iLazy
//
//  Created by Administrator on 15/9/22.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "WelcomeViewController.h"
#import "Macro.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SaveLogin.h"
#import "Request.h"
#import "MapViewController.h"

@interface WelcomeViewController ()

@property (strong, nonatomic)UIButton *loginBtn;
@property (strong, nonatomic)UIButton *registerBtn;
@property (strong, nonatomic)NSString *username;
@property (strong, nonatomic)NSString *password;
@property (strong, nonatomic)NSString *userid;
@property (strong, nonatomic)NSMutableDictionary *userloginDic;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
   

    //背景图片
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    
    imageview.image = [UIImage imageNamed:@"lazylogin"];
    
    [self.view addSubview:imageview];
    
    
    //登录按钮
    [self loginbtn];
    
    //注册按钮
    [self registerbtn];

}

//登录按钮
-(void)loginbtn{
    
    self.loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.53, UISCREEN_HEIGHT-73, UISCREEN_WIDTH*0.4, 30)];
    
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.loginBtn.backgroundColor = COLORMAMP(255, 255, 255, 1);
    
    self.loginBtn.layer.cornerRadius = 5;
    
    [self.loginBtn setShowsTouchWhenHighlighted:YES];
    
    [self.loginBtn setTitleColor:COLORNAVIGATION forState:UIControlStateNormal];
    
    [self.loginBtn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.loginBtn];
}


//注册按钮
-(void)registerbtn{
    
    self.registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.075, UISCREEN_HEIGHT-73, UISCREEN_WIDTH*0.4, 30)];
    
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.registerBtn.backgroundColor = COLORMAMP(75,195,210,1);
    
    self.registerBtn.layer.cornerRadius = 5;
    
    [self.registerBtn setShowsTouchWhenHighlighted:YES];
    
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.registerBtn addTarget:self action:@selector(toRegist) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.registerBtn];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


// 跳转到登录界面 

-(void)toLogin{
    
    LoginViewController *loginvc = [[LoginViewController alloc]init];
    
    CATransition *animation = [CATransition animation];
    
    animation.duration = 1.0;
    
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromLeft;
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:loginvc animated:YES];

}

//跳转到注册界面

-(void)toRegist{
    
    RegisterViewController *registvc = [[RegisterViewController alloc]init];
    
    CATransition *animation = [CATransition animation];
    
    animation.duration = 1.0;
    
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    
    animation.type = @"rippleEffect";
    
    animation.subtype = kCATransitionFromLeft;
    
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self.navigationController pushViewController:registvc animated:YES];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.userloginDic = [[NSMutableDictionary alloc]init];
    SaveLogin *userlogin = [[SaveLogin alloc]init];
    
    [userlogin getInfo:^(NSMutableDictionary *dic) {
        
        NSLog(@"***-**-*-**----**-**%@",dic);

        self.userloginDic = dic;

        self.username = [self.userloginDic objectForKey:@"username"];
        self.password = [self.userloginDic objectForKey:@"password"];
        self.userid   = [self.userloginDic objectForKey:@"userid"];
        
        if ([self.username isEqualToString:@""] || [self.password isEqualToString:@""] || [self.userid isEqualToString:@""]) {
            
            NSLog(@"*******没有Plist！！！");
        }
        else
        {

            MapViewController *map = [[MapViewController alloc]init];
            
            [map  setValue:self.userid forKey:@"l_userid"];
            
            [self.navigationController pushViewController:map animated:NO];
        }
    }];
}

@end
