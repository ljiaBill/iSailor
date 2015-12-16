//
//  MyMessageTableViewCell.m
//  iLazy
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MyMessageTableViewCell.h"
#import "Macro.h"

#define HEAD_HEIGHT self.view.frame.size.height


@implementation MyMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)str{
    
    self = [super initWithStyle:style reuseIdentifier:str];
    if (self) {
        
        //cell的view
        self.view = [[UIView alloc]init];
        self.view.backgroundColor = [UIColor whiteColor];
        
        //横线
        self.line = [[UILabel alloc]init];
        self.line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        //类别
        self.nameLabel = [[UILabel alloc]init];
        self.nameLabel.backgroundColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        self.nameLabel.textColor = [UIColor grayColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        
        self.messageLabel = [[UILabel alloc]init];
        self.messageLabel.backgroundColor = [UIColor whiteColor];
        self.messageLabel.font = [UIFont systemFontOfSize:15];
        self.messageLabel.textColor = [UIColor grayColor];

        //图标
        self.Img = [[UIImageView alloc]init];
        
        //向右图标
        self.noultLabel = [[UILabel alloc]init];
        self.noultLabel.backgroundColor = [UIColor whiteColor];
        self.noultLabel.font = [UIFont systemFontOfSize:15];
        self.noultLabel.textAlignment = NSTextAlignmentRight;
        self.noultLabel.textColor = [UIColor grayColor];
        
        [self.view addSubview:self.nameLabel];
        [self.view addSubview:self.messageLabel];
        [self.view addSubview:self.line];
        [self.view addSubview:self.Img];
        [self.view addSubview:self.noultLabel];
        
        [self.contentView addSubview:self.view];
    }
    
    return self;
}

#pragma mark - 设置大小和位置
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.view.frame = CGRectMake(0, 0, UISCREEN_WIDTH, 65);
    
    self.line.frame = CGRectMake(self.view.frame.size.width/5, 64, UISCREEN_WIDTH-20, 1);         //方位是基于cell的
    
    self.noultLabel.frame = CGRectMake(UISCREEN_WIDTH-27.5-12, 65/2-7.5, 15, 15);
    
    self.nameLabel.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.height);

    self.messageLabel.frame = CGRectMake(self.nameLabel.frame.size.width+30, 65/2-15, UISCREEN_WIDTH/2, 30);
}

@end
