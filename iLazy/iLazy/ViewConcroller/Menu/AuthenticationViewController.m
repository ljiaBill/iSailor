//
//  AuthenticationViewController.m
//  iLazy
//
//  Created by administrator on 15/10/18.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "AuthenticationViewController.h"
#import "MyNavigation.h"
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
    self.okBut.backgroundColor = COLORMAMP(75,195,210,1);
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
        
        //        NSLog(@"%@---%@",self.nameText.text,self.IDcardText.text);
        
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
    
    statusBarView.backgroundColor= COLORMAMP(75,195,210,1);
    
    [self.view addSubview:statusBarView];
    
}

//改变状态栏文字为白色

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - 数据操作

//匹配身份证信息
- (void)requestUserCarIDcar{
    
    NSLog(@"%@---%@",self.nameText.text,self.IDcardText.text);
    
    NSDictionary *l_userCardInfoDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                       [self.nameText.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"name",
                                       self.IDcardText.text,@"cardno",
                                       nil];
    
    PersonalService *personalDate = [[PersonalService alloc]init];
    
    [personalDate requestLazyUserIDcar:l_userCardInfoDic and:^(NSDictionary *dataDic) {
        
        NSString *msg = [dataDic objectForKey:@"msg"];
        
        if([dataDic objectForKey:@"data"])
        {
            
            UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:msg message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
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
