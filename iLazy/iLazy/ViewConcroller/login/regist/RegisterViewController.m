//
//  RegisterViewController.m
//  iLazy
//
//  Created by Administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "RegisterViewController.h"
#import "Macro.h"
#import "WelcomeViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/SMSSDKCountryAndAreaCode.h>
#import "Request.h"
#import "AESCrypt.h"
#import "SaveLogin.h"
#import "MapViewController.h"

@interface RegisterViewController ()

@property (strong, nonatomic)UITextField *phoneText;     //输入电话text
@property (strong, nonatomic)UIButton *ensureBtn;        //注册按钮
@property (strong, nonatomic)UILabel *phoneLabel;        //电话下划线
@property (strong, nonatomic)UILabel *caplabel;          //验证码下划线
@property (strong, nonatomic)UITextField *codeText;      //验证码输入text
@property (strong, nonatomic)UIButton *captchaBtn;       //获取验证码按钮
@property (strong, nonatomic)UITextField *passwordtext;  //密码
@property (strong, nonatomic)UILabel *passwordlabel;     //密码下划线
@property (strong, nonatomic)NSTimer *timer;             //计时器
@property NSInteger second;                              //定义秒数

@property (strong, nonatomic)NSDictionary *userdic;

@property (assign, nonatomic) BOOL isClick;

@end



@implementation RegisterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.isClick = YES;
    
    self.userdic = [NSDictionary dictionary];
    
    self.navigationController.navigationBarHidden = YES;
    //背景图片
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    imageview.image = [UIImage imageNamed:@"baijingtupian"];
    
    [self.view addSubview:imageview];
    
    //手机号
    [self phonetext];
    
    //确认验证码
    [self codetext];
    
    //下划线
    [self downline];
    
    //确定按钮
    [self ensurebtn];
    
    //验证码
    [self captchabtn];
    
    [self statusBar];
    
    [self passwdtext];
    
    //下滑手势
    UISwipeGestureRecognizer *downgesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(toWelcome)];
    downgesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:downgesture];
}

#pragma mark - 改变状态栏
//改变状态栏背景色
- (void)statusBar{
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor= [UIColor clearColor];
    
    [self.view addSubview:statusBarView];
    
}
//改变状态栏文字为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

//输入手机号码
-(void)phonetext{
    
    self.phoneText = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.14, UISCREEN_WIDTH*0.625, UISCREEN_HEIGHT*0.07)];
    self.phoneText.layer.borderColor = [UIColor clearColor].CGColor;
    self.phoneText.font = [UIFont systemFontOfSize:15];
    self.phoneText.textColor = [UIColor whiteColor];
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneText.clearButtonMode =UITextFieldViewModeAlways;//清零
    self.phoneText.placeholder = @"请输入手机号码";
    [self.phoneText setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];  //提示文字的颜色和字体
    [self.phoneText setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    UIView *passwdview = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    self.phoneText.leftView = passwdview;
    self.phoneText.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.phoneText];
}

//输入验证码
-(void)codetext{
    
    self.codeText = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.38, UISCREEN_WIDTH*0.36, UISCREEN_HEIGHT*0.07)];
    
    self.codeText.layer.borderColor = [UIColor clearColor].CGColor;
    self.codeText.keyboardType = UIKeyboardTypeNumberPad;
    self.codeText.font = [UIFont systemFontOfSize:15];
    self.codeText.textColor = [UIColor whiteColor];
    self.codeText.clearButtonMode =UITextFieldViewModeAlways;//清零
    self.codeText.placeholder = @"输入验证码";
    [self.codeText setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.codeText setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    UIView *codeview = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    self.codeText.leftView = codeview;
    self.codeText.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.codeText];
    
}
-(void)captchabtn{
    
    self.captchaBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.codeText.frame.size.width+UISCREEN_WIDTH*0.19,UISCREEN_HEIGHT*0.39,self.phoneLabel.frame.size.width-self.codeText.frame.size.width ,UISCREEN_HEIGHT*0.048)];
    self.captchaBtn.backgroundColor = COLORNAVIGATION;
    self.captchaBtn.layer.cornerRadius = 5;
    self.captchaBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.captchaBtn setShowsTouchWhenHighlighted:YES];
    [self.captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.captchaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.captchaBtn addTarget:self action:@selector(captchago:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.captchaBtn];
}

//输入密码
-(void)passwdtext{
    
    self.passwordtext = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.26, UISCREEN_WIDTH*0.625, UISCREEN_HEIGHT*0.07)];
    
    self.passwordtext.layer.borderColor = [UIColor clearColor].CGColor;
    self.passwordtext.secureTextEntry = YES;  //隐藏密码
    self.passwordtext.font = [UIFont systemFontOfSize:15];
    self.passwordtext.textColor = [UIColor whiteColor];
    self.passwordtext.clearButtonMode =UITextFieldViewModeAlways;//清零
    self.passwordtext.placeholder = @"请输入密码";
    [self.passwordtext setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];  //提示文字的颜色和字体
    [self.passwordtext setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    UIView *passwdview = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    self.passwordtext.leftView = passwdview;
    self.passwordtext.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.passwordtext];
}

//下划线
-(void)downline{
    
    //电话下划线
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.20, UISCREEN_WIDTH*0.625, 1)];
    self.phoneLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.phoneLabel];
    
    //确认验证码下划线
    self.caplabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.44, UISCREEN_WIDTH*0.355, 1)];
    self.caplabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.caplabel];
    
    //密码下划线
    self.passwordlabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.32, UISCREEN_WIDTH*0.625, 1)];
    self.passwordlabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.passwordlabel];
    
}

//确定按钮
-(void)ensurebtn{

    self.ensureBtn = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.5, UISCREEN_WIDTH*0.625, 30)];
    self.ensureBtn.layer.cornerRadius = 5;
    self.ensureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.ensureBtn.backgroundColor = COLORNAVIGATION;
    [self.ensureBtn setShowsTouchWhenHighlighted:YES];
    [self.ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ensureBtn addTarget:self action:@selector(toEnsure:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ensureBtn];
}

- (void)captchago:(UIButton *)sender
{
    
    if(self.isClick)
    {
        self.isClick = NO;
        if (_phoneText.text.length == 11) {
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.phoneText.text,@"username", nil];
            
            Request *request = [[Request alloc]init];
            
            [request orregiste:dic and:^(NSDictionary *dataDic) {
                
                NSLog(@"%@",dataDic);
                
                NSString *str = [dataDic objectForKey:@"code"];
                
                if ([str isEqualToString:@"succeed"]) {
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此手机号已被注册" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:okAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    self.isClick = YES;
                }
                
                else {
                    
                    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneText.text zone:@"+86"customIdentifier:nil result:^(NSError *error){
                        
                        if (!error)
                        {
                            NSLog(@"验证码发送成功");
                            NSLog(@"%@",self.phoneText.text);
                            
                            self.second = 30;
                            self.captchaBtn.enabled = NO;
                            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCounter) userInfo:nil repeats:YES];
                            [self.codeText becomeFirstResponder];      //获取焦点
                            self.isClick = YES;
                        }
                        else{
                            
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"发送验证码失败，请检查手机号码" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                            [alert addAction:okAction];
                            [self presentViewController:alert animated:YES completion:nil];
                            self.isClick = YES;
                        }
                    }];
                }
            }];
        }
        else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入11位手机号码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            self.isClick = YES;
        }
    }
}
- (void)toEnsure:(UIButton *)sender
{
    
    if(self.isClick)
    {
        self.isClick = NO;
        
        if(self.phoneText.text.length !=11){
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入11位手机号码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            self.isClick = YES;
        }
        else{
            
            if (_codeText.text.length != 4) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的四位数验证码" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
                self.isClick = YES;
            }
            else{
                
                [SMSSDK commitVerificationCode:self.codeText.text phoneNumber:self.phoneText.text zone:@"+86" result:^(NSError *error) {
                    
                    if (!error) {
                        
                        NSLog(@"验证成功");
                        
                        if (self.passwordtext.text.length >=6) {
                            
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                            [dic setValue:self.phoneText.text forKey:@"username"];
                            [dic setValue:[AESCrypt encrypt:self.passwordtext.text password:USER_KEY] forKey:@"password"];
                            
                            Request *request = [[Request alloc]init];
                            
                            //请求注册数据处理
                            [request registUser:dic and:^(NSDictionary *dataDic) {
                                
                                NSLog(@"%@",dataDic);
                                
                                NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
                                [formatter setDateFormat:@"yyyy-MM-dd"];
                                NSString *currentTime = [formatter stringFromDate:[NSDate date]];
                                
                                NSDictionary *arr = [dataDic objectForKey:@"userinfo"];
                                
                                NSString *useridd = [arr objectForKey:@"userid"];
                                
                                self.userdic = [NSDictionary dictionaryWithObjectsAndKeys:useridd,@"userid",nil];
                                
                                NSMutableDictionary *mdic = [[NSMutableDictionary alloc]init];
                                [mdic setValue:useridd forKey:@"userid"];
                                [mdic setValue:[arr objectForKey:@"username"] forKey:@"phone"];
                                [mdic setValue:currentTime forKey:@"time"];
                                [mdic setValue:@"" forKey:@"image"];
                                
                                //请求插入用户信息表
                                [request insertUserInfo:mdic and:^(NSDictionary *dataDic) {
                                    NSLog(@"%@",dataDic);
                                    
                                    //写入用户plist
                                    SaveLogin *save = [[SaveLogin alloc]init];
                                    
                                    NSMutableDictionary *loginDic = [[NSMutableDictionary alloc]init];
                                    
                                    [loginDic setValue:self.phoneText.text forKey:@"username"];
                                    [loginDic setValue:[AESCrypt encrypt:self.passwordtext.text password:USER_KEY] forKey:@"password"];
                                    [loginDic setValue:[arr objectForKey:@"userid"]  forKey:@"userid"];
                                    
                                    [save saveInfo:loginDic andSuccess:^(NSString *str) {
                                    }];
                                    
                                    MapViewController *mapView = [[MapViewController alloc]init];
                                    
                                    //将勤人端注册的userid发送给 地图主页 ，接受l_userid
                                    [mapView setValue:[self.userdic objectForKey:@"userid"] forKey:@"l_userid"];
                                    
                                    [self animation];
                                    [self.navigationController pushViewController:mapView animated:YES];
                                    
                                    self.isClick = YES;
                                }];
                                
                            }];
                        }
                        
                        else{
                            
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入由字母和数字组六位数以上的密码" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                            [alert addAction:okAction];
                            [self presentViewController:alert animated:YES completion:nil];
                            self.isClick = YES;
                        }
                    }
                    else{
                        //提示，警告
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的验证码！" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                        [alert addAction:okAction];
                        [self presentViewController:alert animated:YES completion:nil];
                        self.isClick = YES;
                    }
                }];
            }
        }
    }
}

//倒计时操作
- (void)timerCounter {
    
    self.second = self.second - 1;
    if (_second == 0) {
        
        self.captchaBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        self.captchaBtn.backgroundColor = COLORNAVIGATION;
        [self.captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.captchaBtn.enabled = YES;
    }
    else {
        
        self.captchaBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        self.captchaBtn.backgroundColor = COLORMAMP(190,190,190, 1);
        NSString *title = [NSString stringWithFormat:@" 重新获取(%lds)", (long)_second];
        [self.captchaBtn setTitle:title forState:UIControlStateNormal];
    }
}

//滴水动画效果
-(void)animation{
    
    CATransition *animation = [CATransition animation];  //水波动画
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
}

//下滑手势点击事件
-(void)toWelcome{
    
    WelcomeViewController *welcomeview = [[WelcomeViewController alloc]init];
    [self animation]; //动画
    [self.navigationController pushViewController:welcomeview animated:YES];
    
}

#pragma mark -----点击空白处关闭键盘

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

@end

