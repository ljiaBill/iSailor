//
//  CustomCalloutView.m
//  iLazy
//
//  Created by administrator on 15/9/22.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "CustomCalloutView.h"
#import "Macro.h"
#import "AppDelegate.h"
#import "MapService.h"
#import "PersonalViewController.h"

@interface CustomCalloutView ()

@end


@implementation CustomCalloutView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {

        self.backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 160, 100)];
        self.userImg = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 50, 50)];
        self.usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 35, 100, 20)];

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
    
    [self addSubview:self.userImg];
    
    
    // 用户名
    self.usernameLabel.font = [UIFont boldSystemFontOfSize:12];
    self.usernameLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:self.usernameLabel];
}



@end
