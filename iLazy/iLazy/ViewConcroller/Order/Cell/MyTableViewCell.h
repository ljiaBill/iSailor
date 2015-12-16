//
//  MyTableViewCell.h
//  iLazy
//
//  Created by Administrator on 15/9/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell

@property (strong, nonatomic)UIView * showView;
@property (strong, nonatomic)UIView * imgView;
@property (strong, nonatomic)UIButton * imgBut;
@property (strong, nonatomic)UILabel * line;
@property (strong, nonatomic)UILabel * nameLabel;
@property (strong, nonatomic)UILabel * titleLable;
@property (strong, nonatomic)UILabel * moneyLable;
@property (strong, nonatomic)UIButton * clickBut;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
