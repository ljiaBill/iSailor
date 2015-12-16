//
//  LoginViewController.m
//  iLazy
//
//  Created by Administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "LoginViewController.h"
#import "Macro.h"
#import "ResetViewController.h"
#import "RegisterViewController.h"
#import "MapViewController.h"
#import "WelcomeViewController.h"
#import "Request.h"
#import "SaveLogin.h"
#import "AESCrypt.h"


@interface LoginViewController ()

@property (strong, nonatomic)UITextField *usernameText;  //用户名
@property (strong, nonatomic)UITextField *passwordText;  //密码
@property (strong, nonatomic)UILabel *usernamelabel;     //用户名标签
@property (strong, nonatomic)UILabel *passwdlabel;       //密码标签
@property (strong, nonatomic)UIButton *loginBTN;         //成功登录
@property (strong, nonatomic)UILabel *registLabel;       //注册标签
@property (strong, nonatomic)UILabel *resetLabel;        //找回密码标签
@property (strong, nonatomic)UILabel *divisionLabel;     //竖直划分线
@property (strong, nonatomic)UILabel *usernameLabel;     //用户名下划线
@property (strong, nonatomic)UILabel *passwdLabel;       //密码下划线  键盘高度220
@property (strong, nonatomic)NSString *username;

@property (assign, nonatomic)BOOL isClack;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.isClack = YES;
    
    self.navigationController.navigationBarHidden = YES;
    
    //背景图片
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH+2, UISCREEN_HEIGHT)];
    imageview.image = [UIImage imageNamed:@"sabiBack"];
    [self.view addSubview:imageview];
    
    [self usernametext]; //文本框
    
    [self passwdtext];  //密码文本框
    
    [self downline];  //下划线
    
    [self button];   //点击按钮
    
    [self label];    //标签
    
    [self toplabel];
    
    [self statusBar];
    
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

//用户名
//密码
-(void)usernametext{
    
    //用户名
    self.usernameText = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.20, UISCREEN_WIDTH*0.625, UISCREEN_HEIGHT*0.07)];
    self.usernameText.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.usernameText.delegate = self;
    self.usernameText.tag = 100;
    
    self.usernameText.font = [UIFont systemFontOfSize:15];
    
    
    self.usernameText.textColor = [UIColor whiteColor];
    self.usernameText.keyboardType = UIKeyboardTypeNumberPad;
    self.usernameText.clearButtonMode =UITextFieldViewModeAlways;    //清零
    
//    让text输入内容不顶格
    UIView *usernameview = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    self.usernameText.leftView = usernameview;
    self.usernameText.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.usernameText];
}

-(void)passwdtext{
    
    //密码
    self.passwordText = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.32, UISCREEN_WIDTH*0.625, UISCREEN_HEIGHT*0.07)];
    
    self.passwordText.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.passwordText.delegate = self;
    self.passwordText.tag = 101;
    self.passwordText.font = [UIFont systemFontOfSize:15];
    
    [self.passwordText setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.passwordText setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    
    self.passwordText.textColor = [UIColor whiteColor];
    self.passwordText.secureTextEntry = YES;  //隐藏密码
    self.passwordText.clearButtonMode =UITextFieldViewModeAlways;//清零
    
    UIView *passwdview = [[UIView alloc] initWithFrame:CGRectMake(0,0,10,10)];
    self.passwordText.leftView = passwdview;
    self.passwordText.leftViewMode = UITextFieldViewModeAlways;
    
    [self.view addSubview:self.passwordText];
    
}

-(void)toplabel{
    
    self.usernamelabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875+10, UISCREEN_HEIGHT*0.22, UISCREEN_WIDTH*0.14, UISCREEN_HEIGHT*0.03)];
    self.usernamelabel.text = @"账  号:";
    self.usernamelabel.backgroundColor = [UIColor clearColor];
    self.usernamelabel.textColor = [UIColor whiteColor];
    self.usernamelabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.usernamelabel];
    
    self.passwdlabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875+10, UISCREEN_HEIGHT*0.34, UISCREEN_WIDTH*0.14, UISCREEN_HEIGHT*0.03)];
    self.passwdlabel.text = @"密  码:";
    self.passwdlabel.backgroundColor = [UIColor clearColor];
    self.passwdlabel.textColor = [UIColor whiteColor];
    self.passwdlabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.passwdlabel];
    
}

//用户名下划线
//密码下滑线
//注册与忘记密码的分割线
-(void)downline{
    
    //用户
    self.usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.26, UISCREEN_WIDTH*0.625, 1)];
    self.usernameLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.usernameLabel];
    
    //密码
    self.passwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.38, UISCREEN_WIDTH*0.625, 1)];
    self.passwdLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.passwdLabel];
    
}


//成功登录按钮

-(void)button{
    
    self.loginBTN = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.1875, UISCREEN_HEIGHT*0.46, UISCREEN_WIDTH*0.625, 30)];
    
    [self.loginBTN setTitle:@"确定" forState:UIControlStateNormal];
    self.loginBTN.layer.cornerRadius = 5;
    [self.loginBTN setShowsTouchWhenHighlighted:YES];
    self.loginBTN.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.loginBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginBTN.backgroundColor = COLORMAMP(75,194,210,1);
    [self.loginBTN addTarget:self action:@selector(toSuccesslogin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.loginBTN];
    
}

//注册标签
//忘记密码标签
-(void)label{
    
    //注册标签
    self.registLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.20, UISCREEN_HEIGHT*0.46+self.loginBTN.frame.size.height+10, UISCREEN_WIDTH*0.12, 20)];
    
    self.registLabel.text = @"注册";
    //    self.registLabel.layer.borderWidth= 1;
    self.registLabel.textColor = [UIColor whiteColor];
    self.registLabel.font = [UIFont systemFontOfSize:15];
    
    UITapGestureRecognizer *registgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toRegOnclick)];//注册的点击事件
    self.registLabel.userInteractionEnabled = YES;
    [self.registLabel addGestureRecognizer:registgesture];
    
    [self.view addSubview: self.registLabel];
    
    //忘记密码标签
    self.resetLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.344, UISCREEN_HEIGHT*0.46+self.loginBTN.frame.size.height+10, UISCREEN_WIDTH*0.19, 20)];
    self.resetLabel.text = @"忘记密码";
    
    //    self.resetLabel.layer.borderWidth= 1;
    
    self.resetLabel.textColor = [UIColor whiteColor];
    self.resetLabel.font = [UIFont systemFontOfSize:15];
    UITapGestureRecognizer *resetgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toResetOnclick)];//注册的点击事件
    
    self.resetLabel.userInteractionEnabled = YES;
    [self.resetLabel addGestureRecognizer:resetgesture];
    
    [self.view addSubview: self.resetLabel];
    
    //注册与忘记密码的分割线
    self.divisionLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.308, UISCREEN_HEIGHT*0.46+self.loginBTN.frame.size.height+12, 1, 15)];
    self.divisionLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.divisionLabel];
    
}

#pragma mark - 登录成功判断数据请求的操作

//登录成功点击事件
-(void)toSuccesslogin{
    
    if(self.isClack)
    {
        self.isClack = NO;
        
        
        if([self.usernameText.text isEqualToString:@"" ]|| [self.passwordText.text isEqualToString:@""])
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查用户名或密码是否已填写" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            self.isClack = YES;
        }
        else  {
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            
            [dic setObject:self.usernameText.text forKey:@"username"];
            [dic setObject:[AESCrypt encrypt:self.passwordText.text password:USER_KEY] forKey:@"password"];
            
            Request *request = [[Request alloc]init];
            [request requestUserInfo:dic andSuccess:^(NSDictionary *postDic) {
                NSLog(@"%@",postDic);
                
                NSString *str = [postDic objectForKey:@"code"];
                
                if ([str isEqualToString:@"succeed"]) {
                    
                    NSArray *arr = [postDic objectForKey:@"value"];
                    
                    NSString *userstr = [arr[0] objectForKey:@"userid"];
                    NSString *userstatus = [arr[0] objectForKey:@"status"];
                    
                    if ([userstatus isEqual:@"0"]) {
                        
                        //写入用户plist
                        SaveLogin *save = [[SaveLogin alloc]init];
                        
                        NSMutableDictionary *loginDic = [[NSMutableDictionary alloc]init];
                        
                        [loginDic setValue:self.usernameText.text forKey:@"username"];
                        [loginDic setValue:[AESCrypt encrypt:self.passwordText.text password:USER_KEY] forKey:@"password"];
                        [loginDic setValue:userstr                forKey:@"userid"];
                        
                        [save saveInfo:loginDic andSuccess:^(NSString *str) {
                            
                        }];
                        
                        MapViewController *MapView = [[MapViewController alloc]init];
                        
                        //将勤人端登录的userid发送给 地图主页 ，接受c_userid
                        [MapView setValue:userstr forKey:@"c_userid"];
                        
                        [self.navigationController pushViewController:MapView animated:YES];
                        self.isClack = YES;
                        
                    }
                    else{
                        
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"由于您的行为记录，您已被限制登录五天，请诚信使用。" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                        [alert addAction:okAction];
                        [self presentViewController:alert animated:YES completion:nil];
                        self.isClack = YES;
                    }
                }
                else{
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请检查用户名或密码是否正确填写" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:okAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    self.isClack = YES;
                }
            }];
        }
    }
}

//滴水动画效果
-(void)animation{

    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
}


//注册标签点击事件

-(void)toRegOnclick{
    
    RegisterViewController *registerView = [[RegisterViewController alloc]init];
    [self animation];
    [self.navigationController pushViewController:registerView animated:YES];
    
}


//找回密码标签点击事件

-(void)toResetOnclick{
    
    ResetViewController *resetview = [[ResetViewController alloc]init];
    [self animation];
    [self.navigationController pushViewController:resetview animated:YES];
}


//下滑手势点击事件
-(void)toWelcome{
    
    WelcomeViewController *welcomeview = [[WelcomeViewController alloc]init];
    [self animation];
    [self.navigationController pushViewController:welcomeview animated:YES];
    
}

#pragma mark =====纵向移动===========
//移动动画
-(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.toValue = y;
    animation.duration = time;
    animation.removedOnCompletion = NO;//yes的话，又返回原位置了。
    animation.repeatCount = 0;
    animation.fillMode = kCAFillModeForwards;
    return animation;
}

#pragma mark =====缩放-=============
//缩放动画
-(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repertTimes{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = Multiple;
    animation.toValue = orginMultiple;
    animation.autoreverses = YES;
    animation.repeatCount = repertTimes;
    animation.repeatCount = 1;
    animation.duration = 0.01;//不设置时候的话，有一个默认的缩放时间.
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    return  animation;
}



#pragma mark ---- UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField.tag == 101){
        [self.passwdlabel.layer addAnimation:[self moveY:0.01 Y:[NSNumber numberWithFloat:-25]] forKey:nil];
        
        
        CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        shake.fromValue = [NSNumber numberWithFloat:-M_PI/32];
        shake.toValue = [NSNumber numberWithFloat:+M_PI/32];
        shake.duration = 0.05;
        shake.autoreverses = YES; //是否重复
        shake.repeatCount = 5;
        [self.passwdlabel.layer addAnimation:shake forKey:@"shakeAnimation"];
        self.passwdlabel.alpha = 1.0;
        [UILabel animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{ self.passwdlabel.alpha = 1.0;} completion:nil];
        
    }
    else if(textField.tag ==100){
        
        CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        shake.fromValue = [NSNumber numberWithFloat:-M_PI/32];
        shake.toValue = [NSNumber numberWithFloat:+M_PI/32];
        shake.duration = 0.05;
        shake.autoreverses = YES; //是否重复
        shake.repeatCount = 5;
        
        [self.usernamelabel.layer addAnimation:shake forKey:@"shakeAnimation"];
        self.usernamelabel.alpha = 1.0;
        [UILabel animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{ self.usernamelabel.alpha = 1.0;} completion:nil];
        
        [self.usernamelabel.layer addAnimation:[self moveY:0.01 Y:[NSNumber numberWithFloat:-25]] forKey:nil];
    }
    
    return YES;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag ==100){
        
        if ([self.usernameText.text isEqualToString:@""] ){
            
            [self.usernamelabel.layer addAnimation:[self moveY:0.05 Y:[NSNumber numberWithFloat:0]] forKey:nil];
            
        }
    }
    
    
    else if(textField.tag == 101){
        
        if ([self.passwordText.text isEqualToString:@""])
        {
            [self.passwdlabel.layer addAnimation:[self moveY:0.05 Y:[NSNumber numberWithFloat:0]] forKey:nil];
        }
        
    }

    else
    {
        NSLog(@"有内容！！");
    }
    
}


#pragma mark -----点击空白处关闭键盘

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.username = [[NSString alloc]init];
    
    SaveLogin *userlogin = [[SaveLogin alloc]init];
    
    [userlogin getInfo:^(NSMutableDictionary *dic) {
        
        NSLog(@"***-**-*-**----**-**%@",dic);
        
        self.username = [dic objectForKey:@"username"];
        
        if (![self.username isEqualToString:@""]) {
            
            self.usernameText.text = self.username;
            [self.usernameText becomeFirstResponder];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
@end
