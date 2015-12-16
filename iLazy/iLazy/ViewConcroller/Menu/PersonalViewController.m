//
//  PersonalViewController.m
//  iLazy
//
//  Created by Vic on 15/9/26.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "PersonalViewController.h"
#import "MyNavigation.h"
#import "MapViewController.h"
#import "MyMessage.h"
#import "MapService.h"
#import "UserInfo.h"
#import "MyMessageTableViewCell.h"
#import "PersonalService.h"
#import "LoginViewController.h"
#import "SaveLogin.h"
#import "AESCrypt.h"
#import "UIImageView+WebCache.h"

@interface PersonalViewController ()

//用户信息
@property (strong, nonatomic) NSString * olduserid;
@property (strong, nonatomic) NSString * oldusernick;
@property (strong, nonatomic) NSString * oldusersex;
@property (strong, nonatomic) NSString * olduseremail;
@property (strong, nonatomic) NSString * olduserphone;
@property (strong, nonatomic) NSString * olduserChangePassword;
@property (strong, nonatomic) NSString * olduserimage;
@property (strong, nonatomic) NSString * oldusertime;

//用户信息(存储新的)
@property (strong, nonatomic) NSString * userid;
@property (strong, nonatomic) NSString *usernick;
@property (strong, nonatomic) NSString *usersex;
@property (strong, nonatomic) NSString *useremail;
@property (strong, nonatomic) NSString *userphone;
@property (strong, nonatomic) NSString *userChangePassword;
@property (strong, nonatomic) NSString *userimage;
@property (strong, nonatomic) NSString *usertime;

@property (strong, nonatomic) NSString *l_userID;

@property (strong, nonatomic) NSDictionary * userinfoDic;

@property (strong, nonatomic) UITableView * table;

@property (assign, nonatomic) BOOL editClick;

@property (strong, nonatomic) UIView * headView;

@property (strong, nonatomic) UIImageView * imageView;

@property (strong, nonatomic) UITextField * nickText;

@property (strong, nonatomic) UILabel * Credit;

@property (strong, nonatomic) UILabel * CreditLineLabel;

@property (strong, nonatomic) UIButton * editBut;

@property (strong, nonatomic) MyMessageTableViewCell * cell;

@property (strong, nonatomic) NSMutableDictionary * userinfoNewDic;

@property (strong, nonatomic) UIImage * imageNew;

@property (strong, nonatomic) UIImage * internetImage;

@property (strong, nonatomic) NSString *oldPasswd;
@property (strong, nonatomic) NSString *PasswdNewOne;
@property (strong, nonatomic) NSString *PasswdNewTwo;

@property (strong, nonatomic) NSString * username;

@property (strong, nonatomic) NSMutableDictionary * plistDic;


@property (strong, nonatomic) UIButton *girlBut;
@property (strong, nonatomic) UIButton *boyBut;
@property (strong, nonatomic) UIButton *ETBut;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //我的信息(数据)
    [self message];
    
    self.editClick = NO;
   
    self.userinfoNewDic = [NSMutableDictionary dictionary];

    //顶部卡界面
    [self initTopView];
    
    //改变状态栏
    [self statusBar];
    
    //自定义navigation
    [self mynavigation];
    
    //控制页用户交互
    [self controllerUser];
    
    //Table
    [self initTable];
    
    //请求用户登录信息
    [self selectUserLogin];
}

#pragma mark - 改变状态栏
//改变状态栏背景色
- (void)statusBar{
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor= COLORNAVIGATION;
    
    [self.view addSubview:statusBarView];
}

// 改变状态栏文字为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - 初始化顶部View
- (void)initTopView
{
    //上面的卡片
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT/4)];
    self.headView.backgroundColor = COLORNAVIGATION;
    self.headView.userInteractionEnabled = YES;
    
    //用户头像
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-UISCREEN_WIDTH/4/2, 3, UISCREEN_WIDTH/4, UISCREEN_WIDTH/4)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView.layer setCornerRadius:UISCREEN_WIDTH/8];
    self.imageView.clipsToBounds = YES;
    
    //同步获取网络图片
    NSString * url = [NSString stringWithFormat:@"%@%@",IMAGE_PATH,self.userimage];
//    self.internetImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    //下载到本地(沙盒)
    [self saveImage:self.imageView.image withName:[NSString stringWithFormat:@"%@",self.userid]];
    //读取沙河中图片
    [self readImage:self.userid];
    
    self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.headView addSubview:self.imageView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openPhoto)];
    [self.imageView addGestureRecognizer:tap];

    //用户昵称
    self.nickText = [[UITextField alloc]initWithFrame:CGRectMake(0, UISCREEN_WIDTH/4, UISCREEN_WIDTH, UISCREEN_WIDTH/4/2)];
    [self.nickText setTextColor:[UIColor whiteColor]];
    self.nickText.font = [UIFont systemFontOfSize:20];
    self.nickText.textAlignment = NSTextAlignmentCenter;
    if([self.usernick isEqualToString:@""])
    {
        self.nickText.placeholder = @"请设置昵称";
    }
    else
    {
        self.nickText.text = self.usernick;
    }
    [self.headView addSubview:self.nickText];
    
    //信用度
    self.Credit = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-UISCREEN_WIDTH/4/2+5, 10+UISCREEN_WIDTH/4+10+5, 50, UISCREEN_WIDTH/4/2)];
//    self.Credit.text = @"信用度:";
    self.Credit.textColor = [UIColor whiteColor];
    self.Credit.font = [UIFont systemFontOfSize:12];
    
    //信用度
    self.CreditLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-UISCREEN_WIDTH/4/2+50, 10+UISCREEN_WIDTH/4+10+5, 50, UISCREEN_WIDTH/4/2)];
//    self.CreditLineLabel.text = @"五颗星";
    self.CreditLineLabel.textColor = [UIColor whiteColor];
    self.CreditLineLabel.font = [UIFont systemFontOfSize:12];
    
    [self.headView addSubview:self.Credit];
    [self.headView addSubview:self.CreditLineLabel];
    
    [self.view addSubview:self.headView];
}


#pragma  mark - 控制控件的编辑
- (void)controllerUser
{
    if(!self.editClick)
    {
        self.imageView.userInteractionEnabled = NO;
        self.nickText.userInteractionEnabled = NO;
        
        self.cell.userInteractionEnabled = NO;
    }
    else if (self.editClick)
    {
        self.imageView.userInteractionEnabled = YES;
        self.nickText.userInteractionEnabled = YES;
        
        self.cell.userInteractionEnabled = YES;
    }
}

#pragma mark - 编辑按钮点击事件
- (void)edit
{
    if(self.editClick == YES)
    {
        self.editClick = NO;
        
        [self.editBut setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
//        [self.nickText becomeFirstResponder];
        //保存数据
        [self saveData];
    }
    else
    {
        self.editClick = YES;

        [self.editBut setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
    }
    [self controllerUser];
}

#pragma mark - 自定义navigation
- (void)mynavigation
{
    self.navigationController.navigationBarHidden = YES;      //隐藏默认导航条
    
    MyNavigation *myBar = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"" titleStr:@""];
    
    myBar.rightBut.frame = CGRectMake(UISCREEN_WIDTH-45, 28, 22, 22);
    
    [myBar.leftBut addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];

    self.editBut = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH-45, 28, 22, 22)];
    
    [self.editBut setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
    
    [self.editBut addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    
    [myBar addSubview:self.editBut];
    
    [self.view addSubview:myBar];
}

#pragma mark - 解析个人信息(数据)
- (void)message
{
    //新信息
    self.userid = [self.userinfoDic objectForKey:@"l_user_userid"];
    self.usersex = [self.userinfoDic objectForKey:@"usersex"];
    self.useremail = [self.userinfoDic objectForKey:@"useremail"];
    self.userphone = [self.userinfoDic objectForKey:@"userphone"];
    self.userimage = [self.userinfoDic objectForKey:@"userimage"];
    self.usernick = [self.userinfoDic objectForKey:@"usernick"];
    self.usertime = [self.userinfoDic objectForKey:@"registertime"];
    
    //旧信息
    self.olduserid = self.userid;
    self.oldusernick = self.usernick;
    self.oldusersex = self.usersex;
    self.olduseremail = self.useremail;
    self.olduserphone = self.userphone;
    self.olduserimage = self.userimage;
    self.oldusertime = self.usertime;
}

#pragma mark - 初始化Table
- (void)initTable
{
    //tableview
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headView.bounds.size.height+64, UISCREEN_WIDTH, UISCREEN_HEIGHT-UISCREEN_WIDTH/4/2)];
    self.table.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    //禁止tableview滚动
    self.table.scrollEnabled = YES;
    //去掉多余的CELL
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - Table代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}

- (MyMessageTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"table";
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (self.cell == nil) {
        self.cell = [[MyMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    self.cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.cell.nameLabel.highlighted = YES;
    self.cell.Img.highlighted = YES;
    self.cell.messageLabel.highlighted = YES;
    
    //设置cell点击颜色
    self.cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *view_bg = [[UIView alloc]initWithFrame:self.cell.frame];
    view_bg.backgroundColor = [UIColor whiteColor];
    self.cell.selectedBackgroundView = view_bg;
    
    if (indexPath.row == 0)
    {
        if([self.usersex isEqualToString:@""])
        {
            self.cell.messageLabel.text = @"请设置性别";
        }
        else
        {
            self.cell.messageLabel.text = self.usersex;
        }
        
        self.cell.nameLabel.backgroundColor = COLORMAMP(75,192,201,1);
        self.cell.Img.image = [UIImage imageNamed:@"sex"];
        self.cell.Img.frame = CGRectMake(65/2-17.5, 65/2-17.5, 35, 35);
        self.cell.noultLabel.text = @">";
    }
    else if (indexPath.row == 1)
    {
        if([self.useremail isEqualToString:@""])
        {
            self.cell.messageLabel.text = @"请设置邮箱";
        }
        else
        {
            self.cell.messageLabel.text = self.useremail;
        }
        self.cell.nameLabel.backgroundColor = COLORMAMP(59,152,216,1);
        self.cell.Img.image = [UIImage imageNamed:@"email_b"];
        self.cell.Img.frame = CGRectMake(65/2-10, 65/2-7.5, 20, 15);
        self.cell.noultLabel.text = @">";
        
    }
    else if (indexPath.row == 2)
    {
        self.cell.messageLabel.text = self.userphone;
        self.cell.nameLabel.backgroundColor = COLORMAMP(193,108,133,1);
        self.cell.Img.image = [UIImage imageNamed:@"phone_b"];
        self.cell.Img.frame = CGRectMake(65/2-9, 65/2-9, 18, 18);
        self.cell.noultLabel.text = @">";
        
    }
    else if (indexPath.row == 3)
    {
        self.cell.messageLabel.text = @"修改密码";
        self.cell.nameLabel.backgroundColor = COLORMAMP(255,181,149,1);
        self.cell.Img.image = [UIImage imageNamed:@"key_b"];
        self.cell.Img.frame = CGRectMake(65/2-10, 65/2-10, 20, 20);
        self.cell.noultLabel.text = @">";
    }
    return self.cell;
}

#pragma mark - cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if (indexPath.row == 0)
    {
        if (self.editClick == YES)
        {
          
            [self AlertSex];
        }
    }
    else if (indexPath.row == 1)
    {
        if (self.editClick == YES)
        {
            
            [self AlertEmail];
        }
    }
    else if(indexPath.row == 2)
    {
        if (self.editClick == YES)
        {
            
            [self AlertPhone];
        }
    }
    else if (indexPath.row == 3)
    {
        if (self.editClick == YES)
        {
             [self AlertChangepasswd];
        }
    }
}

#pragma mark - 换头像
- (void)openPhoto
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *Action = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        }
        
        pickerImage.delegate = self;
        pickerImage.allowsEditing = YES;
        
        [self presentViewController:pickerImage animated:YES completion:^{
        }];
        
    }];
    
    UIAlertAction *Action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
            
            pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
            
            pickerImage.delegate = self;
            pickerImage.allowsEditing = YES;
            
            [self presentViewController:pickerImage animated:YES completion:^{
            }];
        }else{
            
            UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"你没有摄像头！" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alertController2 addAction:action];
            [self presentViewController:alertController2 animated:YES completion:nil];
        }
    }];
    
    
    UIAlertAction *Action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:Action];
    [alertController addAction:Action2];
    [alertController addAction:Action3];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imageNew = info[UIImagePickerControllerOriginalImage];
    
    self.imageView.image = self.imageNew;
    
    //存储图片
    PersonalService * service = [[PersonalService alloc]init];
    [service insertUserImage:self.imageNew and:^(NSDictionary *dataDic) {
        
        NSDictionary * dic = [[dataDic objectForKey:@"message"] objectForKey:@"upload"];
        self.userimage = [dic objectForKey:@"savename"];
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 提示框

#pragma mark - 修改性别
- (void)AlertSex{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
  
    self.girlBut = [[UIButton alloc]initWithFrame:CGRectMake(alertController.view.frame.size.width/6, 10, 32, 32)];
    self.girlBut.tag = 0;
    [self.girlBut addTarget:self action:@selector(sexChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.girlBut setImage:[UIImage imageNamed:@"girl_h"] forState:UIControlStateNormal];
    [alertController.view addSubview:self.girlBut];
    
    self.ETBut = [[UIButton alloc]initWithFrame:CGRectMake(alertController.view.frame.size.width/3, 10, 32, 32)];
    self.ETBut.tag = 2;
    [self.ETBut addTarget:self action:@selector(sexChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.ETBut setImage:[UIImage imageNamed:@"ET_h"] forState:UIControlStateNormal];
    [alertController.view addSubview:self.ETBut];
    
    self.boyBut = [[UIButton alloc]initWithFrame:CGRectMake(alertController.view.frame.size.width/2-2, 10, 32, 32)];
    self.boyBut .tag = 1;
    [self.boyBut  addTarget:self action:@selector(sexChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.boyBut  setImage:[UIImage imageNamed:@"boy_h"] forState:UIControlStateNormal];
    [alertController.view addSubview:self.boyBut ];
    
    if([self.usersex isEqualToString:@"男"])
    {
        [self.boyBut  setImage:[UIImage imageNamed:@"boy_l"] forState:UIControlStateNormal];
    }
    else if(([self.usersex isEqualToString:@"女"]))
    {
        [self.girlBut setImage:[UIImage imageNamed:@"girl_l"] forState:UIControlStateNormal];
    }
    else
    {
        [self.ETBut setImage:[UIImage imageNamed:@"ET_l"] forState:UIControlStateNormal];
    }
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self.table reloadData];
    }];

    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)sexChoose:(UIButton *)sender
{
    if(sender.tag == 0)
    {
        self.usersex = @"女";
        [self.girlBut  setImage:[UIImage imageNamed:@"girl_l"] forState:UIControlStateNormal];
        [self.boyBut  setImage:[UIImage imageNamed:@"boy_h"] forState:UIControlStateNormal];
        [self.ETBut  setImage:[UIImage imageNamed:@"ET_h"] forState:UIControlStateNormal];
    }
    else if (sender.tag == 1)
    {
        self.usersex = @"男";
        [self.boyBut  setImage:[UIImage imageNamed:@"boy_l"] forState:UIControlStateNormal];
        [self.girlBut  setImage:[UIImage imageNamed:@"girl_h"] forState:UIControlStateNormal];
        [self.ETBut  setImage:[UIImage imageNamed:@"ET_h"] forState:UIControlStateNormal];
    }
    else if (sender.tag == 2)
    {
        self.usersex = @"不详";
        [self.girlBut  setImage:[UIImage imageNamed:@"girl_h"] forState:UIControlStateNormal];
        [self.boyBut  setImage:[UIImage imageNamed:@"boy_h"] forState:UIControlStateNormal];
        [self.ETBut  setImage:[UIImage imageNamed:@"ET_l"] forState:UIControlStateNormal];
    }
}

#pragma mark - 修改邮箱
- (void)AlertEmail{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"请输入邮箱" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入邮箱";
        textField.clearButtonMode =UITextFieldViewModeAlways;      //清零
        textField.text = self.useremail;
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UITextField *email = alertController.textFields.firstObject;
        self.useremail = email.text;
        NSLog(@"password = %@", self.useremail);
        
        [self.table reloadData];
    }];
    
    UIAlertAction *cancellAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"取消");
    }];
    
    [alertController addAction:cancellAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - 修改电话号码
- (void)AlertPhone{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"请输入电话" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入电话";
        textField.clearButtonMode =UITextFieldViewModeAlways;
        //数字键盘
        textField.keyboardType = UIKeyboardTypeNumberPad;//清零
        textField.layer.borderWidth = 0;
        textField.text = self.userphone;
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UITextField *phone = alertController.textFields.firstObject;
        self.userphone = phone.text;
        NSLog(@"userphone = %@", self.userphone);
        
        [self.table reloadData];
    }];
    
    UIAlertAction *cancellAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"取消");
    }];
    
    [alertController addAction:cancellAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 修改密码 输入旧密码
- (void)AlertChangepasswd{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"修改密码" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入旧密码";
        textField.clearButtonMode =UITextFieldViewModeAlways;      //清零
        textField.secureTextEntry = YES;          //隐藏密码
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UITextField *password = alertController.textFields.firstObject;
        
        if ([password.text isEqualToString:self.oldPasswd]){
        
            //输入新密码
            [self AlertNEWpasswd];
        }else{
        
            UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"密码错误！" message:@"请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        
            UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                
                [self AlertChangepasswd];
            }];
            
            [alertController2 addAction:Action];
            
            [self presentViewController:alertController2 animated:YES completion:nil];
        }

        NSLog(@"成功");
    }];
    
    UIAlertAction *cancellAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"取消");
    }];
    
    [alertController addAction:cancellAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// 修改密码 输入新密码
- (void)AlertNEWpasswd{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"修改密码" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入新密码";
        textField.clearButtonMode =UITextFieldViewModeAlways;      //清零
        textField.secureTextEntry = YES;

    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.secureTextEntry = YES;
        textField.clearButtonMode =UITextFieldViewModeAlways;      //清零
        textField.placeholder = @"请确认新密码";

    }];
    
    UITextField *password = alertController.textFields[0];
    UITextField *password2 = alertController.textFields[1];
    
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            self.PasswdNewOne = password.text;
            self.PasswdNewTwo = password2.text;
            
            if([self.PasswdNewOne isEqualToString:self.PasswdNewTwo])
            {
                //修改数据库中用户登录信息
                [self changeDBPasswd];
            }
            else
            {
                UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"两次密码不一致！" message:@"请重新输入" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                    
                    [self AlertNEWpasswd];
                }];
                [alertController2 addAction:Action];
                [self presentViewController:alertController2 animated:YES completion:nil];
            }
        }];
        
           [alertController addAction:okAction];

           UIAlertAction *cancellAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
           NSLog(@"取消修改");
        }];
    
    [alertController addAction:cancellAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 数据操作

//获得用户登录信息(数据库查询)
- (void)selectUserLogin{

    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:self.userid,  @"userid", nil];
    
    PersonalService *personal = [[PersonalService alloc]init];
    
    [personal selectUserLoginInfo:dic and:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            NSArray *valueDic = [dataDic objectForKey:@"value"];
            
            self.oldPasswd = [AESCrypt decrypt:[[valueDic firstObject] objectForKey:@"password"] password:USER_KEY];
            
            self.username = [[valueDic firstObject] objectForKey:@"username"];
            
        }else
        {
            NSLog(@"查询Lazy用户登录信息失败!");
        }
    }];
}

// 修改数据库中用户登录信息(密码)
- (void)changeDBPasswd{

    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         [AESCrypt encrypt:self.PasswdNewOne password:USER_KEY],  @"password",
                         self.username,      @"username",
                         nil];
    
    PersonalService *personal = [[PersonalService alloc]init];
    
    [personal alterLazyUserPasswd:dic and:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            NSLog(@"修改数据库成功!");
            
            UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"" message:@"修改成功!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                
                //修改PLIST
                [self changePlistPasswd];
 
            }];
            [alertController2 addAction:Action];
            [self presentViewController:alertController2 animated:YES completion:nil];
 
        }else
        {
            NSLog(@"修改数据库失败!");
            UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"" message:@"修改失败!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *Action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){

            }];
            [alertController2 addAction:Action];
            [self presentViewController:alertController2 animated:YES completion:nil];
        }
    }];
}

#pragma mark -  修改本地用户信息
- (void)changePlistPasswd{

    SaveLogin * save = [[SaveLogin alloc]init];
    
    //读取
    [save getInfo:^(NSMutableDictionary *dic) {
        
        NSLog(@"*--+-*--+-**--+-**-+%@",dic);

        self.plistDic = dic;
        //修改
        [self.plistDic setObject:@"" forKey:@"password"];
        
        //写入
        [save saveInfo:self.plistDic andSuccess:^(NSString *str) {
            
            if([str isEqualToString:@"存入成功"])
            {
                NSLog(@"修改Plist成功!");
                
                //退出登录
                LoginViewController * log = [[LoginViewController alloc]init];
                AppDelegate * app = [UIApplication sharedApplication].delegate;
                [app.rootNav pushViewController:log animated:YES];
            }
            else
            {
                NSLog(@"修改Plist失败!");
            }
        }];
    }];
}

#pragma mark - 保存图片至沙盒
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    NSLog(@"-+-+-+-+-+-+-+-+-%@",fullPath);
    
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - 读取沙盒中的图片
- (void)readImage:(NSString *)imageName
{
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    UIImage * image = [[UIImage alloc]initWithContentsOfFile:fullPath];
    if(image)
    {
        self.imageView.image = image;
    }
    else
    {
        self.imageView.image = [UIImage imageNamed:@"x_userimg"];
    }
}

#pragma mark - 保存数据
- (void)saveData
{
    if([self.oldusernick isEqualToString:self.nickText.text] && [self.oldusersex isEqualToString:self.usersex] && [self.olduserphone isEqualToString:self.userphone] && [self.olduseremail isEqualToString:self.useremail] && [self.olduserimage isEqualToString:self.userimage])
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"您没有做任何修改" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        PersonalService * service = [[PersonalService alloc]init];
        
        [self.userinfoNewDic setValue:self.userid forKey:@"userid"];
        [self.userinfoNewDic setValue:self.nickText.text forKey:@"nick"];
        [self.userinfoNewDic setValue:self.usersex forKey:@"sex"];
        [self.userinfoNewDic setValue:self.userphone forKey:@"phone"];
        [self.userinfoNewDic setValue:self.useremail forKey:@"email"];
        [self.userinfoNewDic setValue:self.userimage forKey:@"image"];
        
        //旧信息
        self.olduserid = self.userid;
        self.oldusernick = self.nickText.text;
        self.oldusersex = self.usersex;
        self.olduseremail = self.useremail;
        self.olduserphone = self.userphone;
        self.olduserimage = self.userimage;
        self.oldusertime = self.usertime;
        
        //修改本地数据
        NSDictionary * dicNew = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.userid,        @"l_user_userid",
                                 self.usertime,      @"registertime",
                                 self.useremail,     @"useremail",
                                 self.userimage,      @"userimage",
                                 self.nickText.text, @"usernick",
                                 self.userphone,     @"userphone",
                                 self.usersex,       @"usersex",
                                 nil];
        
        //修改后台数据库
        [service alterLazyUserInfo:self.userinfoNewDic and:^(NSDictionary *dataDic) {
            
            if([[dataDic objectForKey:@"code"] isEqualToString:@"succeed"])
            {
                UserInfo * user = [[UserInfo alloc]init];
                [user userSaveInfo:dicNew andSuccess:^(NSString *str) {
                    
                    if([str isEqualToString:@"存入成功"])
                    {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"修改成功!" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                    else
                    {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"修改失败!" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                        [alertController addAction:okAction];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                }];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"修改失败!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
}

#pragma mark - 页面跳转
- (void)loginOut{
    
    //返回首页
    UIViewController *target = nil;
    for (UIViewController * controller in self.navigationController.viewControllers)
    { //遍历
        if ([controller isKindOfClass:[LoginViewController class]])
        {  //这里判断是否为你想要跳转的页面
            target = controller;
        }
    }
    if (target)
    {
        [self.navigationController popToViewController:target animated:YES];              //跳转
    }
}

#pragma mark - 回退
- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
