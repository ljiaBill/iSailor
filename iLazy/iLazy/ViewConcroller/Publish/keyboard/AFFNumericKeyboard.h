//
//  CustomKeyboard.h
//  keyboard
//
//  Created by zhaowang on 14-3-25.
//  Copyright (c) 2014年 anyfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AFFNumericKeyboardDelegate <NSObject>

-(void)numberKeyboardInput:(NSString *)number;
- (void) numberKeyboardBackspace;

@end

@interface AFFNumericKeyboard : UIView
{
    NSArray *arrLetter;
}
@property (nonatomic,assign) id<AFFNumericKeyboardDelegate> delegate;

@end
