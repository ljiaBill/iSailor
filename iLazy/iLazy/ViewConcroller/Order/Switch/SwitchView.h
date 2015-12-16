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
#import "AssessViewTableView.h"
#import "UnCarryTableView.h"
#import "dataRequest.h"
#import "MBProgressHUD.h"

@interface SwitchView : UIView<MBProgressHUDDelegate>

//已完成页面
@property (strong, nonatomic)UIView * finishView;

//待完成页面
@property (strong, nonatomic)UIView * unFinishView;

//未评价页面
@property (strong, nonatomic)UIView * assessView;

//待接单页面
@property (strong, nonatomic)UIView * unCarryView;

//初始化方法
- (instancetype)initWithSwitchView:(CGRect)frame andId:(NSString *)l_userid;

//展示已完成页面
- (void)switchFinishView;

//展示待完成页面
- (void)switchUnFinishView;  

//展示未评价页面
- (void)switchAssessView;

//展示待接单页面
- (void)switchUnCarryView;

//UITableView
@property (strong, nonatomic)FinishTableView * finishTableView;
@property (strong, nonatomic)UnFinishTableView * unFinishTableView;
@property (strong, nonatomic)AssessViewTableView * assessTableView;
@property (strong, nonatomic)UnCarryTableView * unCarryTableView;

//请求得到的数组数据
@property (strong, nonatomic)NSArray * orderInfoArray;    //l_order的订单信息
@property (strong, nonatomic)NSArray * userInfoArray;     //接单人(c_userid的信息)
@property (strong, nonatomic)NSArray * orderAllInfoArray;    //c_order的全部信息

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

//假定由主页传过来的用户信息(这里假定l_user为2的用户)
@property (strong, nonatomic)NSString * l_userid;

@end
