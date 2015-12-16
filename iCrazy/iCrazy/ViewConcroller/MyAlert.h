//
//  MyAlert.h
//  iCrazy
//
//  Created by Administrator on 15/11/5.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAlert : UIView

@property (strong, nonatomic) UILabel *nameLabel;

- (instancetype)initWithFrame:(CGRect)frame WithNameStr:(NSString *)name;

@end
