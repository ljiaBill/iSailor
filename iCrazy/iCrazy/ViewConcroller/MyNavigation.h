//
//  MyNavigation.h
//  iLazy
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
@interface MyNavigation : UIView

@property (strong, nonatomic) UIImageView *background;

@property (strong, nonatomic) UIButton *leftBut;
@property (strong, nonatomic) UIButton *middleBut;
@property (strong, nonatomic) UIButton *rightBut;
@property (strong, nonatomic) UILabel *titleLabel;

- (instancetype)initWithNavBgImg:(NSString *)navBg leftBtnBgImg:(NSString *)leftBg middleBtnBgImg:(NSString *)middleBg rightBtnImg:(NSString *)rightBg titleStr:(NSString *)titleStr;

@end
