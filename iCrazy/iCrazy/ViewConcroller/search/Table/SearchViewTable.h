//
//  SearchViewTable.h
//  iCrazy
//
//  Created by Administrator on 15/10/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchTableViewCell.h"
#import "MyAlert.h"
#import "MBProgressHUD.h"

@interface SearchViewTable : UIVisualEffectView <UITableViewDataSource ,UITableViewDelegate,UISearchBarDelegate,MBProgressHUDDelegate>

- (instancetype)initWithFrame:(CGRect)frame and:(NSString *)strId and:(NSArray *)userarr;

//底层View
@property (strong, nonatomic)UIView * showView;

@property (strong, nonatomic)UITableView *table;
@property (strong, nonatomic)UIView *imageview;
@property (strong, nonatomic)UISearchBar *searchbar;
@property (strong, nonatomic)UIButton *cansebtn;
@property (strong, nonatomic)UIButton *btn1;
@property (strong, nonatomic)UIButton *btn2;
@property (strong, nonatomic)UIButton *btn3;
@property (strong, nonatomic)UIButton *btn4;

@property (retain, nonatomic)NSMutableArray *orderarr;
@property (strong, nonatomic)NSArray *userarr;

//假定由主页传过来的用户信息(这里假定c_user为1的用户)
@property (strong, nonatomic) NSString * c_userid;

@property (strong, nonatomic) searchTableViewCell *cell;

@property (assign, nonatomic) BOOL isCertification;

@property (assign, nonatomic) BOOL isCellUpDown;

@property (assign, nonatomic) CGFloat lastContentOffset;

//未实名认证 提示框
@property (strong, nonatomic) MyAlert *NotCertificationAlert;
//抢单成功提示框
@property (strong, nonatomic) MyAlert *rushSucceed;
//抢单失败提示框
@property (strong, nonatomic) MyAlert *rushFail;

//抢单失败提示框
@property (strong, nonatomic) MyAlert *noOrder;

//加载圈圈
@property (strong, nonatomic) MBProgressHUD * hubView;

@property (strong, nonatomic) MBProgressHUD * progressHubView;

@property (strong, nonatomic) MBProgressHUD * ButHubView;

@property (assign, nonatomic) BOOL isHUD;

@property (strong, nonatomic) UIButton * huButton;

@property (strong, nonatomic) NSString * strText;

@end
