//
//  MyMessage.m
//  iLazy
//
//  Created by administrator on 15/9/28.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MyMessage.h"
#import "Macro.h"

//#define HEAD_WITH self.headBackgroundView.frame.size.with
#define BODY_WITH self.bodyBackgroundView.frame.size.with
#define HEAD_HEIGHT self.headBackgroundView.frame.size.height
#define BODY_HEIGHT self.bodyBackgroundView.frame.size.height

@implementation MyMessage

- (instancetype)initWithHeadImg:(NSString *)headImg WithHeadName:(NSString *)headName WithHeadCreditLine:(NSString *)headCreditLine WithTrueName:(NSString *)trueName WithSex:(NSString *)sex WithIDcard:(NSString *)IDcard WithPhone:(NSString *)phone{
    
    self = [super initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    
    if (self) {
        
        self.headBackgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT/4)];
//        self.headBackgroundView.backgroundColor = [UIColor grayColor];
        self.headBackgroundView.image = [UIImage imageNamed:@"messageBaground"];
      
        self.bodyBackgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, HEAD_HEIGHT+10, UISCREEN_WIDTH, UISCREEN_HEIGHT-UISCREEN_HEIGHT/4)];
//        self.bodyBackgroundView.backgroundColor = [UIColor grayColor];
        self.bodyBackgroundView.image = [UIImage imageNamed:@"messageBaground"];
        
        [self addSubview:self.headBackgroundView];
        [self addSubview:self.bodyBackgroundView];
    }
    
    if (headImg) {
        
        self.headImg = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/5, HEAD_HEIGHT/4, HEAD_HEIGHT/2, HEAD_HEIGHT/2)];
        
//        self.headImg.image = [UIImage imageNamed:headImg];
        
        self.headImg.image = [UIImage imageNamed:@"textHead"];
        [self.headImg.layer setCornerRadius:HEAD_HEIGHT/4];
        
        self.headImg.clipsToBounds = YES;
        [self.headBackgroundView addSubview:self.headImg];
    }
    
    if (headName) {
        
        self.headNameText = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/5+HEAD_HEIGHT/2+20, HEAD_HEIGHT/4, 200, HEAD_HEIGHT/4)];

        self.headNameText.text = headName;
        self.headNameText.textColor = [UIColor grayColor];
        self.headNameText.font = [UIFont systemFontOfSize:20];
        
        [self addSubview:self.headNameText];
    }
    
    if (headCreditLine) {
        
        self.headCredit = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/5+HEAD_HEIGHT/2+20, HEAD_HEIGHT/2, 50, HEAD_HEIGHT/4)];
        self.headCredit.text = @"信用度:";
        self.headCredit.textColor = [UIColor grayColor];
        self.headCredit.font = [UIFont systemFontOfSize:12];
        
        self.headCreditLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/5+HEAD_HEIGHT/2+20+HEAD_HEIGHT/4+10, HEAD_HEIGHT/2, 200, HEAD_HEIGHT/4)];

        self.headCreditLineLabel.text = headCreditLine;
        self.headCreditLineLabel.textColor = [UIColor grayColor];
        self.headCreditLineLabel.font = [UIFont systemFontOfSize:12];
        
        [self.headBackgroundView addSubview:self.headCredit];
        [self.headBackgroundView addSubview:self.headCreditLineLabel];
    }
    
    //姓名
    if (trueName) {
        
        //线
        self.nameLine = [[UILabel alloc]initWithFrame:CGRectMake(20, 55, UISCREEN_WIDTH-40, 0.2)];
        self.nameLine.backgroundColor = [UIColor grayColor];
        
        self.name = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, UISCREEN_WIDTH/4, 25)];
        self.name.text = @"姓名";
        self.name.textColor = [UIColor grayColor];
        self.name.font = [UIFont systemFontOfSize:15];
        
        
        self.trueNameText = [[UITextField alloc]initWithFrame:CGRectMake(20+HEAD_HEIGHT/2, 30+HEAD_HEIGHT, UISCREEN_WIDTH/2, 25)];
        self.trueNameText.backgroundColor = [UIColor whiteColor];
        self.trueNameText.text = trueName;
        self.trueNameText.font = [UIFont systemFontOfSize:15];
        self.trueNameText.textColor = [UIColor grayColor];
        self.trueNameText.borderStyle = UITextBorderStyleRoundedRect;
        
        //水印
//        self.trueNameText.placeholder = @"姓名";
        //输入框中是否有个叉号
        self.trueNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        
        [self addSubview:self.trueNameText];
        [self.bodyBackgroundView addSubview:self.nameLine];
        [self.bodyBackgroundView addSubview:self.name];
      
    }
    
    //性别
    if (sex) {
        
        self.sexLine = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, UISCREEN_WIDTH-40, 0.2)];
        self.sexLine.backgroundColor = [UIColor grayColor];
        
        self.sex = [[UILabel alloc]initWithFrame:CGRectMake(20, 65, UISCREEN_WIDTH/4, 25)];
        self.sex.text = @"性别";
        self.sex.textColor = [UIColor grayColor];
        self.sex.font = [UIFont systemFontOfSize:15];
        
        self.sexText = [[UITextField alloc]initWithFrame:CGRectMake(20+HEAD_HEIGHT/2, 65+10+HEAD_HEIGHT, UISCREEN_WIDTH/2, 25)];
        self.sexText.text = sex;
        self.sexText.font = [UIFont systemFontOfSize:15];
        self.sexText.borderStyle = UITextBorderStyleRoundedRect;
        
        [self.bodyBackgroundView addSubview:self.sexLine];
        [self.bodyBackgroundView addSubview:self.sex];
        [self addSubview:self.sexText];
        
    }
    
    if (IDcard) {
        
        self.IDcardLine = [[UILabel alloc]initWithFrame:CGRectMake(20, 145, UISCREEN_WIDTH-40, 0.2)];
        self.IDcardLine.backgroundColor = [UIColor grayColor];
        
        self.IDcard = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, UISCREEN_WIDTH/4, 25)];
        self.IDcard.text = @"身份证号码";
        self.IDcard.textColor = [UIColor grayColor];
        self.IDcard.font = [UIFont systemFontOfSize:15];
        
        
        self.IDcardText = [[UITextField alloc]initWithFrame:CGRectMake(20+HEAD_HEIGHT/2, 110+10+HEAD_HEIGHT, UISCREEN_WIDTH/2, 25)];
        self.IDcardText.text = sex;
        self.IDcardText.font = [UIFont systemFontOfSize:15];
        self.IDcardText.textColor = [UIColor grayColor];
        self.IDcardText.borderStyle = UITextBorderStyleRoundedRect;
        
        [self.bodyBackgroundView addSubview:self.IDcardLine];
        [self.bodyBackgroundView addSubview:self.IDcard];
        [self addSubview:self.IDcardText];
        
    }
    
    if (phone) {
        
        self.phoneLine = [[UILabel alloc]initWithFrame:CGRectMake(20, 190, UISCREEN_WIDTH-40, 0.2)];
        self.phoneLine.backgroundColor = [UIColor grayColor];
        
        self.phone = [[UILabel alloc]initWithFrame:CGRectMake(20, 155, UISCREEN_WIDTH/4, 25)];
        self.phone.text = @"手机号码";
        self.phone.textColor = [UIColor grayColor];
        self.phone.font = [UIFont systemFontOfSize:15];
        
        self.phoneText = [[UITextField alloc]initWithFrame:CGRectMake(20+HEAD_HEIGHT/2, 155+10+HEAD_HEIGHT, UISCREEN_WIDTH/2, 25)];
        self.phoneText.text = sex;
        self.phoneText.font = [UIFont systemFontOfSize:15];
        self.phoneText.borderStyle = UITextBorderStyleRoundedRect;
        
        //设置数字键盘
        self.phoneText.keyboardType = UIKeyboardTypePhonePad;
        
        [self.bodyBackgroundView addSubview:self.phoneLine];
        [self.bodyBackgroundView addSubview:self.phone];
        [self addSubview:self.phoneText];
    }
    

    
    
    
    
    
    
    
    return self;
}

@end
