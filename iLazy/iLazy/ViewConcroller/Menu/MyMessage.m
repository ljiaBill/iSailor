//  MyMessage.m
//  iLazy
//
//  Created by administrator on 15/9/28.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MyMessage.h"
#import "Macro.h"
#import "MyMessageTableViewCell.h"
#import "AppDelegate.h"
#import "AuthenticationViewController.h"
#import "MapService.h"

//#define HEAD_WITH self.headView.frame.size.with
#define BODY_WITH self.bodyView.frame.size.with
#define HEAD_HEIGHT self.headView.frame.size.height
#define BODY_HEIGHT self.bodyView.frame.size.height

@implementation MyMessage

- (instancetype)initWithHeadImg:(NSString *)headimg WithNick:(NSString *)nick WithSex:(NSString *)sex WithEmail:(NSString *)email WithPhone:(NSString *)phone WithChangePassword:(NSString *)changepassword WithCertification:(NSString *)certification{
    
    self = [super initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    
    if (self)
    {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //上面的卡片
        self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT/4)];
        self.headView.backgroundColor = COLORMAMP(75,195,210,1);
        self.headView.userInteractionEnabled = YES;
    
    //下面的卡片
        self.bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, UISCREEN_HEIGHT/4, UISCREEN_WIDTH, UISCREEN_HEIGHT-UISCREEN_WIDTH/4/2)];
        self.bodyView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.bodyView.userInteractionEnabled = YES;
    
        [self addSubview:self.headView];
        [self addSubview:self.bodyView];
    
    //tableview
        self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT-UISCREEN_WIDTH/4/2)];
        self.table.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.table.delegate = self;
        self.table.dataSource = self;
        [self.bodyView addSubview:self.table];
        //禁止tableview滚动
        self.table.scrollEnabled = YES;
        //去掉多余的CELL
        self.table.separatorStyle = UITableViewCellSelectionStyleNone;
        
        self.sexArrList = [[NSArray alloc]initWithObjects:@"男",@"女", nil];
        
    //pickView
        self.pickerView = [[UIPickerView alloc]init ];
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(password:) name:@"password" object:nil];
        
        //注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save:) name:@"save" object:nil];
    }
    
    if (headimg) {
        //用户头像
        self.Img = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-UISCREEN_WIDTH/4/2, 3, UISCREEN_WIDTH/4, UISCREEN_WIDTH/4)];
        self.Img.image = [UIImage imageNamed:headimg];
        self.Img.userInteractionEnabled = YES;
        [self.Img.layer setCornerRadius:UISCREEN_WIDTH/8];
        self.Img.clipsToBounds = YES;
        [self addSubview:self.Img];
    }
   
    if (nick) {
        //用户昵称
        self.NickText = [[UITextField alloc]initWithFrame:CGRectMake(0, UISCREEN_WIDTH/4, UISCREEN_WIDTH, UISCREEN_WIDTH/4/2)];
        self.NickText.textColor = [UIColor whiteColor];
        self.NickText.font = [UIFont systemFontOfSize:20];
        self.NickText.placeholder = @"请设置昵称";
        self.NickText.textAlignment = NSTextAlignmentCenter;
        self.NickText.delegate = self;
        [self addSubview:self.NickText];
    }
  
  
        //信用度
        self.Credit = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-UISCREEN_WIDTH/4/2+5, 10+UISCREEN_WIDTH/4+10+5, 50, UISCREEN_WIDTH/4/2)];
        self.Credit.text = @"信用度:";
        self.Credit.textColor = [UIColor whiteColor];
        self.Credit.font = [UIFont systemFontOfSize:12];
        //信用度
        self.CreditLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-UISCREEN_WIDTH/4/2+50, 10+UISCREEN_WIDTH/4+10+5, 50, UISCREEN_WIDTH/4/2)];
        self.CreditLineLabel.text = @"五颗星";
        self.CreditLineLabel.textColor = [UIColor whiteColor];
        self.CreditLineLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:self.Credit];
        [self addSubview:self.CreditLineLabel];
   
   
    if (sex) {
        
        //性别
        self.sex = [[UILabel alloc]init];
        [self addSubview:self.sex];
    }

    if (email) {
        
        //邮箱
        self.email = [[UILabel alloc]init];
        [self addSubview:self.email];
    }
 
    if (phone) {
        
        //手机
        self.phone = [[UILabel alloc]init];
        [self addSubview:self.phone];
    }
   
    if (changepassword) {
        
        //修改密码
        self.changePassword = [[UILabel alloc]init];
        [self addSubview:self.changePassword];
    }
    
    return self;
}

- (void)password:(NSNotification *)text{
    
    if ([text.userInfo[@"edit"] isEqualToString:@"yes"]) {
        
        self.editClick = YES;
    }
    
    //设置第一响应
    [self.NickText becomeFirstResponder];
    NSLog(@"%@",text.userInfo[@"edit"]);
    
}

- (void)save:(NSNotification *)text{

    if ([text.userInfo[@"edit"] isEqualToString:@"save"]) {
        
        self.editClick = NO;
    }
    
    self.UserInfoDic = [NSMutableDictionary dictionary];
    
    
    
    //修改数据库数据
    [self alterLazyUserInfo];
    
    NSLog(@"%@",text.userInfo[@"edit"]);
    
}

#pragma mark - tabel cell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}

- (MyMessageTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.editClick = NO;
    
    static NSString *str = @"table";
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (self.cell == nil) {
        self.cell = [[MyMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    self.cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //cell取消点击效果
//    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.cell.nameLabel.highlighted = YES;
    self.cell.Img.highlighted = YES;
    self.cell.messageText.highlighted = YES;
    
    //设置cell点击颜色
    self.cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *view_bg = [[UIView alloc]initWithFrame:self.cell.frame];
    view_bg.backgroundColor = [UIColor whiteColor];
    self.cell.selectedBackgroundView = view_bg;
    
//    self.cell.messageText.delegate = self;
    
    if (indexPath.row == 0) {
        
        self.cell.messageText.userInteractionEnabled = NO;
        
//        self.cell.nameLabel.text = @"性别";
        self.cell.messageText.text = self.sex.text;
        self.cell.messageText.placeholder = @"请设置性别";
        self.cell.nameLabel.backgroundColor = COLORMAMP(59,152,216,1);
        self.cell.Img.image = [UIImage imageNamed:@"sex"];
     
        self.cell.Img.frame = CGRectMake(65/2-16, 65/2-16, 32, 32);
        
        if (![self.cell.messageText.text isEqualToString:@""]) {
            [self.UserInfoDic setValue:self.cell.messageText.text forKey:@"sex"];
        }
        
    }else if (indexPath.row == 1){
        
    
//        self.cell.nameLabel.text = @"邮箱";
        self.cell.messageText.text = self.email.text;
        self.cell.messageText.placeholder = @"请设置邮箱";
        self.cell.nameLabel.backgroundColor = COLORMAMP(47,136,167,1);
        self.cell.Img.image = [UIImage imageNamed:@"email"];
        self.cell.Img.frame = CGRectMake(65/2-10, 65/2-10, 20, 20);
        
        
        self.cell.messageText.delegate = self;
      
        if (![self.cell.messageText.text isEqualToString:@""]) {
            [self.UserInfoDic setValue:self.cell.messageText.text forKey:@"email"];
        }
        
    }else if (indexPath.row == 2){
        
//        self.cell.nameLabel.text = @"手机号码";
        
        self.cell.messageText.userInteractionEnabled = NO;
        
        self.cell.messageText.text = self.phone.text;
        self.cell.nameLabel.backgroundColor = COLORMAMP(193,108,133,1);
        self.cell.Img.image = [UIImage imageNamed:@"phone"];
        self.cell.Img.frame = CGRectMake(65/2-10, 65/2-10, 20, 20);
        
        
        //设置数字键盘
        self.cell.messageText.keyboardType = UIKeyboardTypePhonePad;
    }else if (indexPath.row == 3){
        
        
//        self.cell.nameLabel.text = @"修改密码";
        self.cell.messageText.text = self.changePassword.text;
        self.cell.messageText.placeholder = @"点击可修改密码";
        self.cell.nameLabel.backgroundColor = COLORMAMP(255,181,149,1);
        self.cell.Img.image = [UIImage imageNamed:@"password"];
        self.cell.Img.frame = CGRectMake(65/2-10, 65/2-10, 20, 20);
       
    }
//    }else if (indexPath.row == 4){
        
//        self.cell.messageText.userInteractionEnabled = NO;
//        
////        self.cell.nameLabel.text = @"实名认证";
//        self.cell.messageText.text = self.certification.text;
//        self.cell.messageText.placeholder = @"请进行身份认证";
//        self.cell.nameLabel.backgroundColor = COLORMAMP(246,115,128,1);
//        self.cell.Img.image = [UIImage imageNamed:@"shimingrenzheng"];
//        self.cell.Img.frame = CGRectMake(65/2-10, 65/2-10, 20, 20);
//        self.cell.goImg.image = [UIImage imageNamed:@"goright_"];
        
//    }
    
    return self.cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        
        if (self.editClick == YES) {
            
            self.pickerView.frame = CGRectMake(0,UISCREEN_HEIGHT-150, UISCREEN_WIDTH, 70);
            self.pickerView.alpha = 1;
            self.pickerView.dataSource = self;
            self.pickerView.delegate = self;
            
            [self addSubview:self.pickerView];
        }
       
    }else if (indexPath.row == 1){
    
        self.pickerView.alpha = 0;
    }else if (indexPath.row == 4){
        
        self.pickerView.alpha = 0;
        
        AppDelegate * app = [UIApplication sharedApplication].delegate;
        AuthenticationViewController *Authentication = [[AuthenticationViewController alloc]init];
        [app.rootNav pushViewController:Authentication animated:YES];
    }
    
}


#pragma mark - textfield
//是否可编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    self.cell.messageText = textField;
    self.NickText = textField;
    
    return self.editClick;
}

#pragma mark - 收键盘
//点编辑区外的地方
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self.NickText isExclusiveTouch]||![self.cell.messageText isExclusiveTouch]) {
        
        [self.NickText resignFirstResponder];
        [self.cell.messageText resignFirstResponder];
    }
}

//点击return
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.NickText resignFirstResponder];
    [self.cell.messageText resignFirstResponder];
    return YES;
}

#pragma mark - pickerview
//列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;
}
//每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.sexArrList.count;
}
//每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{

    return 60;
}
//返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    self.sex.text = [self.sexArrList objectAtIndex:row];
    [self.table reloadData];
}
//返回当前行的内容，此处是将数组中的值添加到滚动的那个显示栏上
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    return [self.sexArrList objectAtIndex:row];
}

//修改Lazy用户信息
- (void)alterLazyUserInfo{
    
    
    [self.UserInfoDic setValue:@"2" forKey:@"userid"];
    
    [self.UserInfoDic setValue:@"user2" forKey:@"image"];
    
    
    if(![self.NickText.text isEqualToString:@""]){
    
        [self.UserInfoDic setValue:self.NickText.text forKey:@"nick"];
    }else{
    
        self.NickText.text = self.NickText.text;
    }
    
    MapService *map = [[MapService alloc]init];
    
    [map alterLazyUserInfo:self.UserInfoDic and:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            
            //更新信息
//            [self.table reloadData];
            
            NSLog(@"-----修改用户信息成功!%@",dataDic);
        }
        else if([str isEqualToString:@"error"])
        {
            NSLog(@"-----修改用户信息失败!");
        }
    }];
}


@end
