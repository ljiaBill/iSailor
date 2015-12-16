//
//  UserInfoTableViewCell.h
//  iLazy
//
//  Created by Administrator on 15/10/15.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoTableViewCell : UITableViewCell

//底部View
@property (strong, nonatomic)UIView * showView;

//数据展示
@property (strong, nonatomic)UILabel * showLable;

//字段名字
@property (strong, nonatomic)UILabel * nameLabel;

//尾部按钮
@property (strong, nonatomic)UIView * butView;
@property (strong, nonatomic)UIButton * button;

//初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
