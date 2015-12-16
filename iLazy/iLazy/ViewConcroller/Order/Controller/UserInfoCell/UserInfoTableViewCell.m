//
//  UserInfoTableViewCell.m
//  iLazy
//
//  Created by Administrator on 15/10/15.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UserInfoTableViewCell.h"

@implementation UserInfoTableViewCell

- (void)awakeFromNib {

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        //背景
        _showView = [[UIView alloc] init];
        _showView.backgroundColor = [UIColor whiteColor];
//        [_showView.layer setCornerRadius:5];
        [self.contentView addSubview:_showView];
        
        //名字字段
        _nameLabel = [[UILabel alloc]init];
//        _nameLabel.backgroundColor = [UIColor purpleColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor grayColor];
        [_showView addSubview:_nameLabel];
        
        //数据展示
        _showLable = [[UILabel alloc]init];
//        _showLable.backgroundColor = [UIColor blueColor];
        _showLable.textAlignment = NSTextAlignmentCenter;
        _showLable.font = [UIFont systemFontOfSize:15];
        _showLable.textColor = [UIColor grayColor];
        [_showView addSubview:_showLable];
        
        //按钮
        _butView = [[UIView alloc]init];
//        _butView.backgroundColor = [UIColor grayColor];
        [_showView addSubview:_butView];
        
        _button = [[UIButton alloc]init];
//        _button.backgroundColor = [UIColor purpleColor];
        _button.hidden = YES;
        [_butView addSubview:_button];
    }
    
    return self;
}

#pragma mark - 设置大小和位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    //背景
    _showView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-1);
    
    //名字字段
    _nameLabel.frame = CGRectMake(20, 0, self.bounds.size.width/4, self.bounds.size.height-5);
    
    //数据展示
    _showLable.frame = CGRectMake(_showView.bounds.size.width/2-self.bounds.size.width/3.6, 0, self.bounds.size.width/1.8, self.bounds.size.height-5);
    
    //按钮
    _butView.frame = CGRectMake(_showView.bounds.size.width/2-self.bounds.size.width/4+_showLable.bounds.size.width, 0, _showView.bounds.size.width-(_showView.bounds.size.width/2-self.bounds.size.width/4)-_showLable.bounds.size.width-20, self.bounds.size.height-5);
    
    _button.frame = CGRectMake(_butView.bounds.size.width/2 ,15 ,_showView.bounds.size.height-30, _showView.bounds.size.height-30);
}

@end
