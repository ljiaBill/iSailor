//
//  SwitchView.h
//  iLazy
//
//  Created by Administrator on 15/9/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "FinishTableView.h"
#import "UnFinishTableView.h"
#import "dataRequest.h"
#import "MBProgressHUD.h"

@interface SwitchView : UIView<MBProgressHUDDelegate>

//已完成页面
@property (strong, nonatomic)UIView * finishView;

//待完成页面
@property (strong, nonatomic)UIView * unFinishView;

//初始化方法
- (instancetype)initWithSwitchView:(CGRect)frame andId:(NSString *)userid;

//展示已完成页面
- (void)switchFinishView;

//展示待完成页面
- (void)switchUnFinishView;

//UITableView
@property (strong, nonatomic)FinishTableView * finishTableView;
@property (strong, nonatomic)UnFinishTableView * unFinishTableView;

//请求得到的数组数据
@property (strong, nonatomic)NSArray * orderInfoArray;    //c_order的订单信息
@property (strong, nonatomic)NSArray * userInfoArray;     //接单人(c_userid的信息)
@property (strong, nonatomic)NSArray * orderAllInfoArray;    //l_order的全部信息

//加载标识
@property (assign, nonatomic)BOOL isClick;

//定时器
@property (strong, nonatomic)NSTimer * timer;

//加载缓冲
@property (strong, nonatomic)MBProgressHUD * finishProgressHUD;

//重新加载的按钮
@property (strong, nonatomic)UIButton * finishAnewBut;
@property (strong, nonatomic)UILabel * point;

//放加载圈圈的view
@property (strong, nonatomic)UIView * finishHUDView;

//假定由主页传过来的用户信息(这里假定c_user为1的用户)
@property (strong, nonatomic)NSString * c_userid;

@end
