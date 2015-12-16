//
//  AlartViewController.h
//  iLazy
//
//  Created by Administrator on 15/9/25.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyAlartViewDelegate <NSObject>

//确定按钮
- (void)positiveButtonAction;
//取消按钮
- (void)negativeButtonAction;

@end

@interface AlartViewController : UIViewController

//声明代理对象
@property (nonatomic,weak) id<MyAlartViewDelegate> delegate;

//展示对话框
- (void)showView:(UIView *)targetView;

//传递信息
- (void)deliverInfoLelf:(NSString *)lelf andRight:(NSString *)right andTitle:(NSString *)title andPoint:(NSString *)point andStatus:(BOOL)isClick;

@end
