//
//  RootViewController.h
//  iLazy
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "OrderViewController.h"
#import "MyNavigation.h"
#import "CustomAnnotationView.h"
#import "MyMenuView.h"
#import "AppDelegate.h"
#import "MapService.h"
#import "PersonalViewController.h"
#import "AboutViewController.h"
#import "ServiceViewController.h"
#import "SetViewController.h"
#import "UserInfomation.h"
#import "WelcomeViewController.h"
#import "SearchViewTable.h"
#import "MyRushTableViewCell.h"

#import "MyAlert.h"

@interface MapViewController : UIViewController<MAMapViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    MAMapView *_mapView;
}

#pragma mark - 抢单页

@property (strong, nonatomic) MyRushTableViewCell *cell;

@property (strong, nonatomic) SearchViewTable *searchview;
@property (strong, nonatomic) UITableView *myRushtable;

@property (nonatomic,strong) NSMutableArray *priceData;
@property (strong, nonatomic) NSMutableArray *imgDate;
@property (strong, nonatomic) NSMutableArray *titleDate;

@property (strong, nonatomic) NSMutableArray *l_orderpriceArr;
@property (strong, nonatomic) NSMutableArray *l_ordertitleArr;

@property (strong, nonatomic) NSMutableArray *l_userimgArr;
@property (strong, nonatomic) NSMutableArray *l_useridArr;

@property (strong, nonatomic) NSDictionary *l_userinfoDic;
@property (strong, nonatomic) NSArray *l_orderuserArr;

@property (strong, nonatomic) NSString *l_userID;

@property (strong, nonatomic) NSMutableArray *l_orderTwoArr;

@property (strong, nonatomic) NSString *l_userIDStatus;

//传给气泡
@property (strong, nonatomic) NSDictionary *l_userDic;

//收起抢单 按钮
@property (strong, nonatomic) UIButton *shouBut;

@property (assign, nonatomic) BOOL close;
@property (assign, nonatomic) BOOL searchclose;

#pragma mark - 经纬度
/* 懒人经纬度. */
@property (nonatomic, assign) CGFloat Lazylatitude;
@property (nonatomic, assign) CGFloat Lazylongitude;
/* 勤人经纬度. */
@property (nonatomic, assign) CLLocationDegrees Crazylatitude;
@property (nonatomic, assign) CLLocationDegrees Crazylongitude;

#pragma mark - 存储位置信息(中心点坐标)
@property (strong, nonatomic)CLLocation *locationInfo;

//定位按钮
@property (strong, nonatomic) UIButton *locationBut;

//自定义图标
@property (strong, nonatomic) MAPointAnnotation *MyPoint;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;
//气泡上的信息
@property (strong, nonatomic) NSString *l_usernick;
@property (strong, nonatomic) NSString *l_userimage;
@property (strong, nonatomic) NSString *l_userid;

@property (strong, nonatomic) NSMutableDictionary *imaDic;
@property (strong, nonatomic) NSMutableArray *imgArr;
@property (strong, nonatomic) NSMutableArray *nameArr;

//Crazy的位置
@property (strong, nonatomic) NSString *CrazyLocation;
@property (strong, nonatomic) NSMutableArray *CrazyLocationArr;

//对方位置表
@property (strong, nonatomic) NSArray *l_userLocationArr;
//对方用户信息
@property (strong, nonatomic) NSArray *l_userInfoArr;
//对方用户信用度信息
@property (strong, nonatomic) NSArray *l_userCreditInfoArr;

@property (strong, nonatomic) NSDictionary *l_userCreditDic;

@property (strong, nonatomic) MyMenuView *MyMenu;

@property (assign, nonatomic) BOOL menuClick;

//假定由主页传过来的用户信息(这里假定c_user为1的用户)
@property (strong, nonatomic) NSString * c_userid;

//是否已实名认证
@property (assign, nonatomic) BOOL isCertification;

@property (strong, nonatomic) NSString *c_userstatus;

//监听scrollview上下滑动状态
@property (assign, nonatomic) BOOL isCellUpDown;
//scrollview初始位置
@property (assign, nonatomic) CGFloat lastContentOffset;

#pragma mark - 提示框

//未实名认证提示框
@property (strong, nonatomic) MyAlert *NotCertificationAlert;

//抢单成功提示框
@property (strong, nonatomic) MyAlert *rushSucceed;

//抢单失败提示框
@property (strong, nonatomic) MyAlert *rushFail;


@end
