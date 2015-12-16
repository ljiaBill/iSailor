//
//  UnCarryTableView.h
//  iLazy
//
//  Created by Administrator on 15/10/19.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "CarryTableViewCell.h"
#import "AlartViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "dataRequest.h"
#import "AlterOrderViewController.h"

@interface UnCarryTableView : UIView<UITableViewDataSource,UITableViewDelegate,MyAlartViewDelegate>

//页面
@property (strong, nonatomic)UIView * showView;

//UITableView
@property (strong, nonatomic)UITableView * table;

//标识要确定的一个
@property (assign, nonatomic)long isAlter;

//传递的数组参数
@property (strong, nonatomic)NSMutableArray * orderArray;    //l_order的订单信息

//数据操作
@property (strong, nonatomic)NSDictionary * deleDic;
@property (strong, nonatomic)NSDictionary * valueDic;

//初始化方法
- (instancetype)initWithTableView:(CGRect)frame;

//取值返回的订单信息
- (void)getOrderData:(NSArray *)orderArray and:(NSString *)userid;

//假定由主页传过来的用户信息(这里假定l_user为2的用户)
@property (strong, nonatomic)NSString * l_userid;

//没有数据显示的Button
@property (strong, nonatomic)UIButton * notInfoBut;
@property (strong, nonatomic)NSTimer * timer;
@property (assign, nonatomic)int isTime;

@end
