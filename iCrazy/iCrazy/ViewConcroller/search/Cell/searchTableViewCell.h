//
//  searchTableViewCell.h
//  iCrazy
//
//  Created by Administrator on 15/10/16.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchTableViewCell : UITableViewCell
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UILabel *moneyLabel;
@property (strong, nonatomic) UIImageView *userImg;
@property (strong, nonatomic) UIButton *chooseBut;
@property (strong, nonatomic) UIButton *imgBtn;
@property (strong, nonatomic) UILabel *line;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)str;

@end
