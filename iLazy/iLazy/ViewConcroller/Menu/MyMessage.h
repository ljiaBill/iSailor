//
//  MyMessage.h
//  iLazy
//
//  Created by administrator on 15/9/28.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyMessageTableViewCell.h"
@interface MyMessage : UIView<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) MyMessageTableViewCell *cell;
@property (strong, nonatomic) UIPickerView *pickerView;

//判断是否可编辑
@property (assign, nonatomic) BOOL editClick;

@property (strong, nonatomic) NSArray *sexArrList;

@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) UIView *bodyView;

@property (strong, nonatomic) UITableView *table;

//详细信息
@property (strong, nonatomic) UIImageView *Img; //头像
@property (strong, nonatomic) UITextField *NickText; //昵称
@property (strong, nonatomic) UILabel *CreditLineLabel; //信用度
@property (strong, nonatomic) UILabel *Credit; //信用度

@property (strong, nonatomic) UILabel *sex; //性别
@property (strong, nonatomic) UILabel *email;  //邮箱
@property (strong, nonatomic) UILabel *phone; //手机号码
@property (strong, nonatomic) UILabel *changePassword;  //修改密码

@property (strong, nonatomic) NSMutableDictionary *UserInfoDic;

- (instancetype)initWithHeadImg:(NSString *)headimg WithNick:(NSString *)nick WithSex:(NSString *)sex WithEmail:(NSString *)email WithPhone:(NSString *)phone WithChangePassword:(NSString *)changepassword WithCertification:(NSString *)certification;

@end
