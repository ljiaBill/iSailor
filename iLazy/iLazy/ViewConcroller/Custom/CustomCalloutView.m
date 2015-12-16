//
//  CustomCalloutView.m
//  iLazy
//
//  Created by administrator on 15/9/22.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "CustomCalloutView.h"
#import "Macro.h"
#import "PersonalViewController.h"
#import "AppDelegate.h"
#import "MapService.h"

@interface CustomCalloutView ()

@end

@implementation CustomCalloutView

- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.usernameLabel.text = self.usernick;
        
        self.backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 100)];
        self.userImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
        self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 18, 100, 20)];
       
        self.creditView = [[UIView alloc]initWithFrame:CGRectMake(73, 52, 100, 20)];
        self.creditLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 38, 50, 20)];
        self.starOne = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
        self.starTwo = [[UIImageView alloc]initWithFrame:CGRectMake(0+self.starOne.bounds.size.width+2, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
        self.starThere = [[UIImageView alloc]initWithFrame:CGRectMake(0+self.starOne.bounds.size.width*2+3, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
        self.starFour = [[UIImageView alloc]initWithFrame:CGRectMake(0+self.starOne.bounds.size.width*3+4, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
        self.starFive = [[UIImageView alloc]initWithFrame:CGRectMake(0+self.starOne.bounds.size.width*4+5, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
        
        //初始化气泡
        [self initSubViews];
        
    }
    
    return self;
}



//初始化气泡
- (void)initSubViews
{
    
    // 气泡背景图
    self.backgroundImg.image = [UIImage imageNamed:@"qipao_tt"];
    
    [self addSubview:self.backgroundImg];
    
    
    //用户头像
    self.userImg.clipsToBounds = YES;
    [self.userImg.layer setCornerRadius:25];
    
    UITapGestureRecognizer *userImgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToPersonal)];
    self.userImg.userInteractionEnabled = YES;
    [self.userImg addGestureRecognizer:userImgTap];
    
    [self addSubview:self.userImg];
    
    
    // 用户名
    self.usernameLabel.font = [UIFont boldSystemFontOfSize:12];
    self.usernameLabel.textColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *usernameLabelTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToPersonal)];
    self.usernameLabel.userInteractionEnabled = YES;
    [self.usernameLabel addGestureRecognizer:usernameLabelTap];
    [self addSubview:self.usernameLabel];

    [self creditShow];
}

- (void)ToPersonal{
    
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    [app.rootNav pushViewController:personal animated:YES];
}

#pragma mark - 展示信用度
- (void)creditShow
{
    //底层
    [self.backgroundImg addSubview:self.creditView];
    
    //文字说明
    self.creditLabel.text = [NSString stringWithFormat:@"信用度:"];
    self.creditLabel.font = [UIFont systemFontOfSize:12];
    self.creditLabel.textColor = [UIColor whiteColor];
    [self.backgroundImg addSubview:self.creditLabel];
    
    self.starFive = [[UIImageView alloc]initWithFrame:CGRectMake(0+self.starOne.bounds.size.width*4+5, self.creditView.bounds.size.height*2.5/8, self.creditLabel.bounds.size.width/4, self.creditLabel.bounds.size.width/4)];
 
    [self.creditView addSubview:self.starOne];
    [self.creditView addSubview:self.starTwo];
    [self.creditView addSubview:self.starThere];
    [self.creditView addSubview:self.starFour];
    [self.creditView addSubview:self.starFive];
    
}

@end
