//
//  searchTableViewCell.m
//  iCrazy
//
//  Created by Administrator on 15/10/16.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "searchTableViewCell.h"
#import "Macro.h"
#import "Request.h"

@implementation searchTableViewCell


//自定义cell的初始化方法

- (void)awakeFromNib {
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)str{
    
    self = [super initWithStyle:style reuseIdentifier:str];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //cell的view
        self.view = [[UIView alloc]init];
        self.view.backgroundColor = [UIColor clearColor];
        self.view.layer.cornerRadius = 8;
        self.view.clipsToBounds = YES;
        
        //信息title
        self.messageLabel = [[UILabel alloc]init];
        self.messageLabel.textColor = [UIColor grayColor];
        self.messageLabel.font = [UIFont systemFontOfSize:15];
        
        //头像
        self.userImg = [[UIImageView alloc]init];
        self.userImg.layer.cornerRadius = 30;
        self.userImg.clipsToBounds = YES;
        
        //价钱
        self.moneyLabel = [[UILabel alloc]init];
        self.moneyLabel.textColor = [UIColor grayColor];
        self.moneyLabel.textAlignment = NSTextAlignmentCenter;
        self.moneyLabel.font = [UIFont systemFontOfSize:15];
        
        //按钮
        self.chooseBut = [[UIButton alloc]init];
        self.chooseBut.backgroundColor = COLORNAVIGATION;
        [self.chooseBut setTitle:@"抢" forState:UIControlStateNormal];
        [self.chooseBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.chooseBut.showsTouchWhenHighlighted = YES;
        self.chooseBut.titleLabel.font = [UIFont systemFontOfSize:15];
        //切圆角
        self.chooseBut.layer.borderWidth = 0;
        self.chooseBut.layer.backgroundColor = COLORNAVIGATION.CGColor;
        self.chooseBut.layer.cornerRadius = 20;
        
        self.imgBtn  = [[UIButton alloc]init];
        self.imgBtn.backgroundColor = [UIColor clearColor];
        self.imgBtn.shouldGroupAccessibilityChildren = YES;
        
        self.line = [[UILabel alloc]init];
        self.line.backgroundColor = [UIColor grayColor];
        self.line.alpha = 0.3;
        
        [self.view addSubview:self.messageLabel];
        [self.view addSubview:self.userImg];
        [self.view addSubview:self.moneyLabel];
        [self.view addSubview:self.chooseBut];
        [self.view addSubview:self.line];
        [self.view addSubview:self.imgBtn];
        
        [self.contentView addSubview:self.view];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.view.frame = CGRectMake(0, 0, UISCREEN_WIDTH, 80);
    
    self.messageLabel.frame = CGRectMake(UISCREEN_WIDTH/5+10, 10, UISCREEN_WIDTH/2+30, 30);
    self.userImg.frame = CGRectMake(10, 10, 60, 60);
    self.imgBtn.frame = CGRectMake(10, 10, 60, 60);
    self.moneyLabel.frame = CGRectMake(UISCREEN_WIDTH/5+10, 50, 50, 20);
    self.chooseBut.frame = CGRectMake(UISCREEN_WIDTH-50, 20, 40, 40);
    self.line.frame = CGRectMake(10, 79, UISCREEN_WIDTH-20, 1);
    [self.chooseBut setShowsTouchWhenHighlighted:YES];
    
};

@end
