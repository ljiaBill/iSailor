//
//  MyTableViewCell.m
//  iLazy
//
//  Created by Administrator on 15/9/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MyTableViewCell.h"
#import "Macro.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - 自定义cell的初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //底层
        self.showView = [[UIView alloc]init];
        self.showView.backgroundColor = [UIColor whiteColor];
        self.showView.layer.cornerRadius = 8;
        
        //头像
        self.imgView = [[UIView alloc]init];
        [self.imgView.layer setCornerRadius:5];
        self.imgView.clipsToBounds = YES;
        
        self.imgBut = [[UIButton alloc]init];
        [self.imgView addSubview:self.imgBut];
        
        //中间线
        self.line = [[UILabel alloc]init];
        self.line.backgroundColor = COLORNAVIGATION;
        self.line.alpha = 0.5;

        //姓名Lable
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        
        //标题Lable
        self.titleLable = [[UILabel alloc]init];
        self.titleLable.numberOfLines = 0;            //自动换行
        self.titleLable.font = [UIFont systemFontOfSize:12];
        
        //金额Lable
        self.moneyLable = [[UILabel alloc]init];
        self.moneyLable.textAlignment = NSTextAlignmentCenter;
        self.moneyLable.font = [UIFont systemFontOfSize:12];

        //按钮
        self.clickBut = [[UIButton alloc]init];
        self.clickBut.backgroundColor = COLORNAVIGATION;
        [self.clickBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.clickBut setShowsTouchWhenHighlighted:YES];            //点击高亮
        self.clickBut.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.clickBut.layer setCornerRadius:5];
        
        //添加
        [self.showView addSubview:self.imgView];
        [self.showView addSubview:self.line];
        [self.showView addSubview:self.nameLabel];
        [self.showView addSubview:self.titleLable];
        [self.showView addSubview:self.moneyLable];
        [self.showView addSubview:self.clickBut];
        [self.contentView addSubview:self.showView];
        
    }
    return self;
}

#pragma mark - 设置控件的大小和位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.showView.frame = CGRectMake(10, 5, UISCREEN_WIDTH-20, 100);
    
    self.imgView.frame = CGRectMake(8, 8, 50, 50);
    self.imgBut.frame = CGRectMake(0, 0, 50, 50);
    
    self.line.frame = CGRectMake(8, 70, self.showView.bounds.size.width-16, 1);
    
    self.nameLabel.frame = CGRectMake(80, 5, 200, 20);
    
    self.titleLable.frame = CGRectMake(80, 28, 200, 35);
    
    self.moneyLable.frame = CGRectMake(self.showView.bounds.size.width/2-30, 75, 100, 20);
    
    self.clickBut.frame = CGRectMake(self.showView.bounds.size.width-68, 75, 60, 20);
}

@end
