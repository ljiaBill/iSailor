//
//  MyAlert.m
//  iCrazy
//
//  Created by Administrator on 15/11/5.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MyAlert.h"

@implementation MyAlert

- (instancetype)initWithFrame:(CGRect)frame WithNameStr:(NSString *)name{
    
    self = [super initWithFrame:frame];
    
    if (self){
        
        self.backgroundColor = [UIColor blackColor];
        
        self.alpha = 0.3;
        
        [self.layer setCornerRadius:5];
        
        self.nameLabel = [[UILabel alloc]init];
        
        self.nameLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
        self.nameLabel.text = name;
        
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        
        self.nameLabel.textColor = [UIColor whiteColor];
        
        self.nameLabel.font = [UIFont systemFontOfSize:15];
        
        [self addSubview:self.nameLabel];
    }
    
    return self;
}

@end
