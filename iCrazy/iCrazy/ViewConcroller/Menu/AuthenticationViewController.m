//
//  AuthenticationViewController.m
//  iLazy
//
//  Created by administrator on 15/10/18.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "MyNavigation.h"
#import "MenuService.h"
#import "UserInfomation.h"

@interface AuthenticationViewController ()

@end

@implementation AuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //自定义navigation
    [self mynavigation];
    
    //改变状态栏背景色
    [self statusBar];
    
    //页面
    [self viewcon];
    
     NSLog(@"userid ++++++++ %@",self.userid);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewcon{
    
    self.nameText = [[UITextField alloc]initWithFrame:CGRectMake(10, 100, UISCREEN_WIDTH-20, 40)];
    self.nameText.borderStyle = UITextBorderStyleRoundedRect;
    self.nameText.layer.cornerRadius = 8;
    self.nameText.layer.masksToBounds = YES;
    self.nameText.font = [UIFont systemFontOfSize:15];
    self.nameText.textColor = [UIColor blackColor];
    self.nameText.placeholder = @"请输入姓名";
    //输入框中是否有个叉号
    self.nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.nameText becomeFirstResponder];
    
    
    self.IDcardText = [[UITextField alloc]initWithFrame:CGRectMake(10, 170, UISCREEN_WIDTH-20, 40)];
    self.IDcardText.borderStyle = UITextBorderStyleRoundedRect;
    self.IDcardText.layer.cornerRadius = 8;
    self.IDcardText.layer.masksToBounds = YES;
    self.IDcardText.font = [UIFont systemFontOfSize:15];
    self.IDcardText.textColor = [UIColor blackColor];
    self.IDcardText.placeholder = @"请输入身份证号码";
    //输入框中是否有个叉号
    self.IDcardText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.okBut = [[UIButton alloc]initWithFrame:CGRectMake(10, 240, UISCREEN_WIDTH-20, 32)];
    self.okBut.backgroundColor = COLORNAVIGATION;
    self.okBut.layer.masksToBounds = YES;
    self.okBut.layer.cornerRadius = 8;
    [self.okBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.okBut setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.okBut addTarget:self action:@selector(okRequst) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nameText];
    [self.view addSubview:self.IDcardText];
    [self.view addSubview:self.okBut];
}

- (void)okRequst{
    
    if (![self.nameText.text isEqualToString:@""]&&![self.IDcardText.text isEqualToString:@""]) {
        
        //身份认证
        [self requestUserCarIDcar];
        
    }else{
        
        UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"不能为空！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            
        }];
        
        [alertController2 addAction:Action];
        
        [self presentViewController:alertController2 animated:YES completion:nil];
    }
}

#pragma mark - 自定义navigation
- (void)mynavigation{
    
    self.navigationController.navigationBarHidden = YES;      //隐藏默认导航条
    
    MyNavigation *myBar = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:nil titleStr:nil];
    
    myBar.rightBut.frame = CGRectMake(UISCREEN_WIDTH-45, 23, 25, 25);
    
    [myBar.leftBut addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:myBar];
    
}
//返回主页
- (void)goBack{
    
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - 数据操作

//修改身份认证状态
- (void)changeIDCarStatus{

    NSLog(@"userid = ==== %@",self.userid);
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         self.userid,@"userid",
                         @"1",@"status",
                         nil];
    
    MenuService *service = [[MenuService alloc]init];
    
    [service alterCrazyUserIDcarStatus:dic andDic:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {

            NSLog(@"修改身份认证状态成功!");
            
            UserInfomation * user = [[UserInfomation alloc]init];
            
            [user userReadInfo:^(NSDictionary *dic) {
                
                NSDictionary * newDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                         [dic objectForKey:@"c_user_userid"],  @"c_user_userid",
                                         [dic objectForKey:@"registertime"],   @"registertime",
                                         [dic objectForKey:@"useremail"],      @"useremail",
                                         [dic objectForKey:@"userimage"],      @"userimage",
                                         [dic objectForKey:@"usernick"],       @"usernick",
                                         [dic objectForKey:@"userphone"],      @"userphone",
                                         [dic objectForKey:@"usersex"],        @"usersex",
                                         @"1",                                 @"userstatus",
                                         nil];
                
                [user userSaveInfo:newDic andSuccess:^(NSString *str) {
                    
                    if(_delegate != nil && [_delegate respondsToSelector:@selector(personal)])
                    {
                        //回跳
                        [self.navigationController popViewControllerAnimated:YES];
                        [_delegate personal];
                    }
                }];
                
            }];
            
        }else
        {
            NSString *str3 = [dataDic objectForKey:@"message"];
            
            NSLog(@"........%@",str3);
            NSLog(@"修改身认证状态失败!");
        }
    }];
}

//匹配身份证信息
- (void)requestUserCarIDcar{
    
    NSLog(@"%@---%@",self.nameText.text,self.IDcardText.text);
    
    NSDictionary *l_userCardInfoDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                       [self.nameText.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"name",
                                       self.IDcardText.text,@"cardno",
                                       nil];
    
    MenuService * service = [[MenuService alloc]init];
    
    [service requestCrazyUserIDcar:l_userCardInfoDic andDic:^(NSDictionary *dataDic) {
        
        NSLog(@"*-+-*-+-*-+-*-+-*-+-*-+-*-+-*--+-*--+---*-z%@",dataDic);
        
        NSString *msg = [dataDic objectForKey:@"msg"];
        
        if([dataDic objectForKey:@"data"])
        {
            
            UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:msg message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                
                [self changeIDCarStatus];

            }];
            
            [alertController2 addAction:Action];
            
            [self presentViewController:alertController2 animated:YES completion:nil];
            
        }else{
            
            UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:msg message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
            }];
            
            [alertController2 addAction:Action];
            
            [self presentViewController:alertController2 animated:YES completion:nil];
            
        }
    }];
}



/*
 msg 为表示请求成功或失败的信息
 data为返回的数据（只有code为0是才有）
 err:  是否符合身份证号码格式(0为符合，-1为不符合)
 birthday：出生日期（err为-1时无此结果）
 sex ：性别（M为男，F为女）（err为-1时无此结果）
 address: 地址（err为-1时无此结果）
 
 code：
 0    查询成功，姓名和身份证号一致
 101  查询成功，身份证号不存在
 102  查询成功，姓名和身份证号不一致
 103  查询失败，URL参数错误
 104  查询失败，系统正在维护中
 105  查询失败，系统错误
 106  查询失败，其他
 */

@end
