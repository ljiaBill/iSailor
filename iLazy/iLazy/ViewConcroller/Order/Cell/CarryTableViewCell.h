//
//  CarryTableViewCell.h
//  iLazy
//
//  Created by Administrator on 15/10/19.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

@interface CarryTableViewCell : UITableViewCell

//底层卡片
@property (strong, nonatomic)UIView * showView;

//标题
@property (strong, nonatomic)UILabel * titleLable;

//详情
@property (strong, nonatomic)UILabel * detailLable;

//线
@property (strong, nonatomic)UILabel * lineLable;

//时间
@property (strong, nonatomic)UILabel * timeLable;

//删除按钮
@property (strong, nonatomic)UIButton * clickBut;

//修改按钮
@property (strong, nonatomic)UIButton * alterBut;

//初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
