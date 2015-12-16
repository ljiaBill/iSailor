//
//  MyMessageTableViewCell.h
//  iLazy
//
//  Created by administrator on 15/10/12.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UILabel *line;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIImageView *Img;

@property (strong, nonatomic) UILabel * noultLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)str;

@end
