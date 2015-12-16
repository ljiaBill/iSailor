//
//  SidebarView.h
//  iLazy
//
//  Created by administrator on 15/9/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMenuView : UIView<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *View;
@property (strong, nonatomic) UIView *settingView;
@property (strong ,nonatomic) UIView *serviceView;
@property (strong, nonatomic) UIView *aboutView;
@property (strong, nonatomic) UIView *mapView;
@property (strong, nonatomic) UIView *personalView;

@property (strong, nonatomic) UILabel *Label;
@property (strong, nonatomic) UILabel *settingLabel;
@property (strong, nonatomic) UILabel *serviceLabel;
@property (strong, nonatomic) UILabel *aboutLabel;
@property (strong, nonatomic) UILabel *mapLabel;
@property (strong, nonatomic) UILabel *personalLabel;

@property (strong, nonatomic) UIImageView *ImgView;
@property (strong, nonatomic) UIImageView *settingImgView;
@property (strong, nonatomic) UIImageView *serviceImgView;
@property (strong, nonatomic) UIImageView *aboutImgView;
@property (strong, nonatomic) UIImageView *mapImgView;
@property (strong, nonatomic) UIImageView *personalImgView;

@property (strong, nonatomic) UIButton * but;

@property (strong, nonatomic) NSTimer *timer;

- (instancetype)initWithSidebar:(CGRect)frame;


@end
