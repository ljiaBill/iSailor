//
//  MyRushTableViewCell.h
//  iCrazy
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRushTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *view;

@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UILabel *moneyLabel;
@property (strong, nonatomic) UIImageView *userImg;
@property (strong, nonatomic) UIButton *chooseBut;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)str;

@end
