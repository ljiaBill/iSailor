//
//  MyRushTableViewCell.m
//  iCrazy
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MyRushTableViewCell.h"
#import "Macro.h"
@implementation MyRushTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)str{
    
    self = [super initWithStyle:style reuseIdentifier:str];
    if (self) {
        
        //cell的view
        self.view = [[UIView alloc]init];
        self.view.backgroundColor = [UIColor whiteColor];
        self.view.layer.cornerRadius = 8;
        self.view.clipsToBounds = YES;
        self.view.alpha = 0.9;
        
        //信息
        self.messageLabel = [[UILabel alloc]init];
        self.messageLabel.backgroundColor = [UIColor whiteColor];
        self.messageLabel.textColor = [UIColor grayColor];
        self.messageLabel.font = [UIFont systemFontOfSize:15];
        
        //头像
        self.userImg = [[UIImageView alloc]init];
        self.userImg.layer.cornerRadius = 30;
        self.userImg.clipsToBounds = YES;
        
        //价钱
        self.moneyLabel = [[UILabel alloc]init];
        self.moneyLabel.backgroundColor = [UIColor whiteColor];
        self.moneyLabel.textColor = [UIColor grayColor];
        self.moneyLabel.textAlignment = NSTextAlignmentCenter;
        self.moneyLabel.text = @"$ 16";
        self.moneyLabel.font = [UIFont systemFontOfSize:15];
        
        //按钮
        self.chooseBut = [[UIButton alloc]init];
        self.chooseBut.backgroundColor = COLORNAVIGATION;
        [self.chooseBut setTitle:@"抢" forState:UIControlStateNormal];
        [self.chooseBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.chooseBut.titleLabel.font = [UIFont systemFontOfSize:15];
        //切圆角
        self.chooseBut.layer.borderWidth = 0;
        self.chooseBut.layer.backgroundColor = COLORNAVIGATION.CGColor;
        self.chooseBut.layer.cornerRadius = 20;
        
        
        [self.view addSubview:self.messageLabel];
        [self.view addSubview:self.userImg];
        [self.view addSubview:self.moneyLabel];
        [self.view addSubview:self.chooseBut];
        
        [self.contentView addSubview:self.view];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.view.frame = CGRectMake(0, 10, UISCREEN_WIDTH, 80);
    
    self.messageLabel.frame = CGRectMake(UISCREEN_WIDTH/5+10, 10, UISCREEN_WIDTH/2+30, 30);
    self.userImg.frame = CGRectMake(10, 10, 60, 60);
    self.moneyLabel.frame = CGRectMake(UISCREEN_WIDTH/5+10, 50, 100, 20);
    self.chooseBut.frame = CGRectMake(UISCREEN_WIDTH-50, 20, 40, 40);
}

@end
