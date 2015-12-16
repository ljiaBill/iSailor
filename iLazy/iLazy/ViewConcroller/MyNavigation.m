//
//  MyNavigation.m
//  iLazy
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MyNavigation.h"
#import "Macro.h"

@implementation MyNavigation

- (instancetype)initWithNavBgImg:(NSString *)navBg leftBtnBgImg:(NSString *)leftBg middleBtnBgImg:(NSString *)middleBg rightBtnImg:(NSString *)rightBg titleStr:(NSString *)titleStr{
    
    self = [super initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH,74)];
    if (self) {
        
        self.background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, UISCREEN_WIDTH, 44)];

        self.background.backgroundColor = COLORNAVIGATION;
            
        [self addSubview:self.background];
        
        if (leftBg) {
            
            self.leftBut = [[UIButton alloc]initWithFrame:CGRectMake(20, 25, 30, 30)];
            [self.leftBut.imageView.layer setCornerRadius:15];
            [self.leftBut setImage:[UIImage imageNamed:leftBg]forState:UIControlStateNormal];
            [self addSubview:self.leftBut];
        }
        
        if (middleBg) {
            
            self.middleBut = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2+10, 33, 20, 15)];
            [self.middleBut setImage:[UIImage imageNamed:middleBg]forState:UIControlStateNormal];
            [self addSubview:self.middleBut];
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-70, 20, 100, 40)];
        }
        else
        {
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-50, 20, 100, 40)];
        }
        
        if (rightBg) {
            
            self.rightBut = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH-54, 23, 34, 34)];
            [self.rightBut setImage:[UIImage imageNamed:rightBg]forState:UIControlStateNormal];
            [self.rightBut setTitle:rightBg forState:UIControlStateNormal];
            self.rightBut.titleLabel.font = [UIFont systemFontOfSize:15];
            [self addSubview:self.rightBut];
        }
        if (titleStr) {

            self.titleLabel.text = titleStr;
            self.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.titleLabel setTextColor:[UIColor whiteColor]];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.titleLabel];
            
        }else{
            self.titleLabel.text = @"";
            self.middleBut.frame = CGRectMake(UISCREEN_WIDTH/2-10, 33, 20, 15);
            [self.middleBut setImage:[UIImage imageNamed:middleBg]forState:UIControlStateNormal];
            [self addSubview:self.middleBut];
        }
    }
    return self;
}


@end
