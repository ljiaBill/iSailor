//
//  FinishTableView.h
//  iLazy
//
//  Created by Administrator on 15/9/24.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTableViewCell.h"
#import "Macro.h"
#import "AlartViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"
#import "dataRequest.h"
#import "UserInfoViewController.h"

@interface FinishTableView : UIView<UITableViewDataSource,UITableViewDelegate,MyAlartViewDelegate>

//页面
@property (strong, nonatomic)UIView * showView;

//UITableView
@property (strong, nonatomic)UITableView * table;

//初始化方法
- (instancetype)initWithTableView:(CGRect)frame;

//传递的数组参数
@property (strong, nonatomic)NSMutableArray * orderInfoArray;    //l_order的订单信息
@property (strong, nonatomic)NSMutableArray * userInfoArray;     //接单人(c_userid的信息)

//传递过来的信息
- (void)getOrderData:(NSArray *)orderInfoArray and:(NSArray *)userInfoArray and:(NSArray *)orderAllInfoArray and:(NSString *)userid;

//标识要删除的一个
@property (assign, nonatomic)long isDelete;

//需要删除的订单元素
@property (strong, nonatomic)NSDictionary * deleDic;

//假定由主页传过来的用户信息(这里假定l_user为2的用户)
@property (strong, nonatomic)NSString * l_userid;

//没有数据显示的Button
@property (strong, nonatomic)UIButton * notInfoBut;
@property (strong, nonatomic)NSTimer * timer;
@property (assign, nonatomic)int isTime;

//获取网络端图片
@property (strong, nonatomic)UIImage * internetImage;

//控制按钮事件
@property (assign, nonatomic)BOOL isClick;

@end
