//
//  RootViewController.h
//  iLazy
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "PublishViewController.h"
#import "OrderViewController.h"
#import "MyNavigation.h"
#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"
#import "MyMenuView.h"
#import "AppDelegate.h"

#import "PersonalViewController.h"
#import "AboutViewController.h"
#import "ServiceViewController.h"
#import "WelcomeViewController.h"

#import "MapService.h"

@interface MapViewController : UIViewController<MAMapViewDelegate>
{
    MAMapView *_mapView;
}

/* 懒人经纬度. */
@property (nonatomic, assign) CGFloat Lazylatitude;
@property (nonatomic, assign) CGFloat Lazylongitude;
/* 勤人经纬度. */
@property (nonatomic, assign) CLLocationDegrees Crazylatitude;
@property (nonatomic, assign) CLLocationDegrees Crazylongitude;

#pragma mark - 存储位置信息(中心点坐标)
@property (strong, nonatomic)CLLocation *locationInfo;

//自定义图标
@property (strong, nonatomic) MAPointAnnotation *MyPoint;
@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

//Crazy的位置
@property (strong, nonatomic) NSMutableArray *CrazyLocationArr;
@property (strong, nonatomic) NSMutableArray *CrazyLocationArrCallout;

//对方位置表
@property (strong, nonatomic) NSArray *c_userLocationArr;
//对方用户信息
@property (strong, nonatomic) NSArray *c_userInfoArr;
//对方用户信用度信息
@property (strong, nonatomic) NSArray *c_userCreditInfoArr;

@property (strong, nonatomic) NSDictionary *c_userCreditDic;

//下拉菜单view
@property (strong, nonatomic) MyMenuView *MyMenu;

//手势判断
@property (assign, nonatomic) BOOL menuClick;
//区别对方与自己
@property (assign, nonatomic) BOOL type;

//接受懒人端登录的userid
@property (strong, nonatomic) NSString * l_userid;

//定位按钮
@property (strong, nonatomic) UIButton *locationBut;

@property (strong, nonatomic) NSDictionary *c_userDic;

@end
