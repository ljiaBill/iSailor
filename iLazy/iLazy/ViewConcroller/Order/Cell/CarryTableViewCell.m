//
//  CarryTableViewCell.m
//  iLazy
//
//  Created by Administrator on 15/10/19.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "CarryTableViewCell.h"

@implementation CarryTableViewCell

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
        //底层卡片
        _showView = [[UIView alloc]init];
        _showView.backgroundColor = [UIColor whiteColor];
        _showView.layer.cornerRadius = 8;
        
        //标题
        _titleLable = [[UILabel alloc]init];
//        _titleLable.backgroundColor = [UIColor orangeColor];
        _titleLable.font = [UIFont systemFontOfSize:13];
        _titleLable.textColor = COLORMAMP(99, 99, 99, 1);
        
        //时间
        _timeLable = [[UILabel alloc]init];
//        _timeLable.backgroundColor = [UIColor blueColor];
        _timeLable.font = [UIFont systemFontOfSize:10];
        _timeLable.textColor = [UIColor grayColor];
        
        //详情
        _detailLable = [[UILabel alloc]init];
//        _detailLable.backgroundColor = [UIColor purpleColor];
        _detailLable.font = [UIFont systemFontOfSize:12];
        _detailLable.numberOfLines = 0;
        _detailLable.textColor = COLORMAMP(99, 99, 99, 1);
        
        //线
        _lineLable = [[UILabel alloc]init];
        _lineLable.backgroundColor = COLORNAVIGATION;
        _lineLable.alpha = 0.6;
        
        //删除按钮
        _alterBut = [[UIButton alloc]init];
        _alterBut.backgroundColor = COLORNAVIGATION;
        [_alterBut.layer setCornerRadius:5];
        _alterBut.titleLabel.font = [UIFont systemFontOfSize:12];
        [_alterBut setTitle:@"修改" forState:UIControlStateNormal];
        [_alterBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //修改按钮
        _clickBut = [[UIButton alloc]init];
        _clickBut.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_clickBut.layer setCornerRadius:5];
        _clickBut.titleLabel.font = [UIFont systemFontOfSize:12];
        [_clickBut setTitle:@"删除" forState:UIControlStateNormal];
        [_clickBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        //添加
        [self.contentView addSubview:_showView];
        [_showView addSubview:_titleLable];
        [_showView addSubview:_detailLable];
        [_showView addSubview:_lineLable];
        [_showView addSubview:_timeLable];
        [_showView addSubview:_alterBut];
        [_showView addSubview:_clickBut];
    }
    
    return self;
}

#pragma mark - 设置控件的大小和位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _showView.frame = CGRectMake(10, 5, UISCREEN_WIDTH-20, 100);
    
    _titleLable.frame = CGRectMake(5, 4, _showView.bounds.size.width-30, 20);
    
    _timeLable.frame = CGRectMake(5, 4+_titleLable.bounds.size.height+2, _showView.bounds.size.width-30, 10);
    
    _detailLable.frame = CGRectMake(5, 4+_titleLable.bounds.size.height+2+_timeLable.bounds.size.height, _showView.bounds.size.width-10, 37);
    
    _lineLable.frame = CGRectMake(3, 4+_detailLable.bounds.size.height+_timeLable.bounds.size.height+_titleLable.bounds.size.height+2, _showView.bounds.size.width-6, 1);
    
    _alterBut.frame = CGRectMake(_showView.bounds.size.width-68, 2+_detailLable.bounds.size.height+_timeLable.bounds.size.height+_titleLable.bounds.size.height+7.5, 60, 20);
    
    _clickBut.frame = CGRectMake(_showView.bounds.size.width-140,2+_detailLable.bounds.size.height+_timeLable.bounds.size.height+_titleLable.bounds.size.height+7.5, 60, 20);
}

@end
