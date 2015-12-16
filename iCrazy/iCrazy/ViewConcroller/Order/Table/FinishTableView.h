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
@property (strong, nonatomic)NSMutableArray * orderInfoArray;    //c_order的订单信息
@property (strong, nonatomic)NSMutableArray * userInfoArray;     //发单人(l_userid的信息)

//传递过来的信息
- (void)getOrderData:(NSArray *)orderInfoArray and:(NSArray *)userInfoArray and:(NSArray *)orderAllInfoArray and:(NSString *)userid;

//标识要删除的一个
@property (assign, nonatomic)long isDelete;

//需要删除的订单元素
@property (strong, nonatomic)NSDictionary * deleDic;

//假定由主页传过来的用户信息(这里假定c_user为1的用户)
@property (strong, nonatomic)NSString * c_userid;

//没有数据显示的Button
@property (strong, nonatomic)UIButton * notInfoBut;
@property (strong, nonatomic)NSTimer * timer;
@property (assign, nonatomic)int isTime;

//获取网络端图片
@property (strong, nonatomic)UIImage * internetImage;

@end
