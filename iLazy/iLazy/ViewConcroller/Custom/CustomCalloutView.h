//
//  CustomCalloutView.h
//  iLazy
//
//  Created by administrator on 15/9/22.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView

//气泡背景
@property (strong, nonatomic) UIImageView *backgroundImg;
//用户头像
@property (strong, nonatomic) UIImageView *userImg;
//用户名
@property (strong, nonatomic) UILabel *usernameLabel;

//选择按钮
@property (strong, nonatomic) UIButton *chooseBut;


@property (strong, nonatomic) NSString *usernick;
@property (strong, nonatomic) NSString *userimage;

//信用度
@property (strong, nonatomic) UILabel *userLevelLabel;


//信用度小星星
@property (strong, nonatomic)UIImageView * starOne;
@property (strong, nonatomic)UIImageView * starTwo;
@property (strong, nonatomic)UIImageView * starThere;
@property (strong, nonatomic)UIImageView * starFour;
@property (strong, nonatomic)UIImageView * starFive;

//信用度
@property (strong, nonatomic)UIView * creditView;
@property (strong, nonatomic)UILabel * creditLabel;



@end

