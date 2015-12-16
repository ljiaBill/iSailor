//
//  MyMessage.h
//  iLazy
//
//  Created by administrator on 15/9/28.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessage : UIView

@property (strong, nonatomic) UIImageView *headBackgroundView;
@property (strong, nonatomic) UIImageView *bodyBackgroundView;

@property (strong, nonatomic) UIImageView *headImg;
@property (strong, nonatomic) UITextField *headNameText;
@property (strong, nonatomic) UILabel *headCreditLineLabel;
@property (strong, nonatomic) UILabel *headCredit;


//详细信息
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *sex;
@property (strong, nonatomic) UILabel *IDcard;
@property (strong, nonatomic) UILabel *phone;
//可编辑的信息
@property (strong, nonatomic) UITextField *trueNameText;
@property (strong, nonatomic) UITextField *sexText;
@property (strong, nonatomic) UITextField *IDcardText;
@property (strong, nonatomic) UITextField *phoneText;
//线
@property (strong, nonatomic) UILabel *nameLine;
@property (strong, nonatomic) UILabel *sexLine;
@property (strong, nonatomic) UILabel *IDcardLine;
@property (strong, nonatomic) UILabel *phoneLine;

- (instancetype)initWithHeadImg:(NSString *)headImg WithHeadName:(NSString *)headName WithHeadCreditLine:(NSString *)headCreditLine WithTrueName:(NSString *)trueName WithSex:(NSString *)sex WithIDcard:(NSString *)IDcard WithPhone:(NSString *)phone;

@end
