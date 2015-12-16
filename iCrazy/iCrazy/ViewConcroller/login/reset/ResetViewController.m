//
//  ResetViewController.m
//  iLazy
//
//  Created by Administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "ResetViewController.h"
#import "Macro.h"
#import "LoginViewController.h"
#import "WelcomeViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/SMSSDKCountryAndAreaCode.h>
#import "Request.h"
#import "AESCrypt.h"
#import "SaveLogin.h"

@interface ResetViewController ()

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

@property (assign, nonatomic)BOOL isClack;

@end

@implementation ResetViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.isClack = YES;
    
    self.userdic = [NSDictionary dictionary];
    
    self.navigationController.navigationBarHidden = YES;
    //背景图片
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    imageview.image = [UIImage imageNamed:@"sabiBack"];
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
    UISwipeGestureRecognizer *downgesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(togoback)];
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
    self.captchaBtn.backgroundColor = COLORMAMP(75,194,210,1);
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
    self.ensureBtn.backgroundColor = COLORMAMP(75,194,210,1);
    [self.ensureBtn setShowsTouchWhenHighlighted:YES];
    [self.ensureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ensureBtn addTarget:self action:@selector(toEnsure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ensureBtn];
}
- (void)captchago:(UIButton *)sender
{
    //初始化加载圈圈
    if(self.isClack)
    {
        self.isClack = NO;
        
        
        if (_phoneText.text.length == 11) {
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setValue:self.phoneText.text forKey:@"username"];
            
            Request *request = [[Request alloc]init];
            [request orregiste:dic and:^(NSDictionary *dataDic) {
                
                NSLog(@"%@",dataDic);
                
                NSString *str = [dataDic objectForKey:@"code"];
                if ([str isEqualToString:@"succeed"]) {
                    
                    NSLog(@"找到该用户，可以修改密码！");
                    
                    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneText.text zone:@"+86" customIdentifier:nil result:^(NSError *error)  //发送验证码
                     {
                         if (!error){
                             self.second = 30;
                             self.captchaBtn.enabled = NO;
                             self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCounter) userInfo:nil repeats:YES];  //倒计时
                             
                             [self.codeText becomeFirstResponder];      //获取焦点
                             self.isClack = YES;
                         }
                         
                         else{
                             
                             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"发送验证码失败，请检查手机号码" preferredStyle:UIAlertControllerStyleAlert];
                             UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                             [alert addAction:okAction];
                             [self presentViewController:alert animated:YES completion:nil];
                             self.isClack = YES;
                         }
                     }];
                }
                
                else{
                    
                    NSLog(@"没有该用户！");
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有该用户，请注册用户！" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:okAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    self.isClack = YES;
                }
            }];
        }
        
        else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入11位电话号码" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            self.isClack = YES;
        }
    }
}

//倒计时，计时器
- (void)timerCounter {
    
    self.second = self.second - 1;
    
    if (_second == 0) {
        self.captchaBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        self.captchaBtn.backgroundColor = COLORMAMP(75,194,210,1);
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


//滴水效果动画
-(void)animation{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
}

//右滑
-(void)togoback{
    
    [self animation];
    [self.navigationController popViewControllerAnimated:YES];
}

//注册成功跳转事件
-(void)toEnsure{
    
    if(self.isClack)
    {
        self.isClack = NO;

        if (self.phoneText.text.length !=11) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写11位手机号码！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            self.isClack = YES;
        }
        
        else{
            
            if (self.codeText.text.length !=4 ) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的四位数验证码" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
                self.isClack = YES;
            }
            
            else{
                
                [SMSSDK commitVerificationCode:self.codeText.text phoneNumber:self.phoneText.text zone:@"+86" result:^(NSError *error) {
                    
                    if (!error) {
                        
                        if (self.passwordtext.text.length >=6) {
                            
                            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                            
                            [dic setValue:self.phoneText.text  forKey:@"username"];
                            [dic setValue:[AESCrypt encrypt:self.passwordtext.text password:USER_KEY] forKey:@"password"];
                            
                            Request *request = [[Request alloc]init];
                            
                            [request afterpassword:dic and:^(NSDictionary *dataDic) {
                                
                                NSString *str = [dataDic objectForKey:@"code"];
                                
                                if ([str isEqualToString:@"succeed"]) {
                                    
                                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改成功，请登录！" preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                        
                                        LoginViewController *loginView = [[LoginViewController alloc]init];
                                        [self animation];
                                        [self.navigationController pushViewController:loginView animated:YES];
                                        
                                    }];
                                    
                                    [alert addAction:okAction];
                                    [self presentViewController:alert animated:YES completion:nil];
                                    self.isClack = YES;
                                }
                                
                                else{
                                    
                                    NSLog(@"修改失败！");
                                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改失败，请查看网络是否出错!" preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                                    [alert addAction:okAction];
                                    [self presentViewController:alert animated:YES completion:nil];
                                    self.isClack = YES;
                                }
                            }];
                        }
                        
                        else{
                            
                            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入由字母和数字组成六位数以上的密码" preferredStyle:UIAlertControllerStyleAlert];
                            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                            [alert addAction:okAction];
                            [self presentViewController:alert animated:YES completion:nil];
                            self.isClack = YES;
                        }
                    }
                    
                    else {
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的验证码" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                        [alert addAction:okAction];
                        [self presentViewController:alert animated:YES completion:nil];
                        self.isClack = YES;
                    }
                }];
            }
        }
    }
}

#pragma mark -----点击空白处关闭键盘

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end