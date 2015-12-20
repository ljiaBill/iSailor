
//
//  RootViewController.m
//  iLazy
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MapViewController.h"
#import "DorderViewController.h"
#import "MyRushTableViewCell.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "UserInfoViewController.h"
#import "Request.h"
#import "MJRefresh.h"

@interface MapViewController ()

@property (strong ,nonatomic)MyNavigation *myBar;

//传递的数组参数
@property (strong, nonatomic)NSMutableArray * orderInfoArray;    //c_order的订单信息
@property (strong, nonatomic)NSMutableArray * userInfoArray;     //发单人

@property (strong, nonatomic)NSDictionary * SailorDic;

@end

@implementation MapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.orderInfoArray = [NSMutableArray array];
    self.userInfoArray = [NSMutableArray array];
    
    NSLog(@"c_userid========%@",self.c_userid);
    
    self.CrazyLocationArr = [NSMutableArray array];
    self.l_orderTwoArr = [NSMutableArray array];
    self.l_orderpriceArr = [NSMutableArray array];
    self.l_ordertitleArr = [NSMutableArray array];
    self.l_userimgArr = [NSMutableArray array];
    
    self.l_useridArr = [NSMutableArray array];
    
    self.menuClick = YES;
    
    //归档Crazy用户信息
    [self requestUserInfo];
    
    //置顶
    [self.view bringSubviewToFront:self.MyMenu];
    
    //置顶
    [self.view bringSubviewToFront:self.searchview];
    
    //改变状态栏
    [self statusBar];
    
    //自定义navigation
    [self mynavigation];
    
    //地图
    [self map];
    
    //存储Crazy用户位置
    [self saveCrazyLocation];
    
    //定位按钮
    [self location];
    
    //下拉手势
    [self recognizer];

    //首页 抢单信息
    [self initRush];
    
    //查询订单为2的信息
    [self requestUserOrderTwo];
    
    //查询Lazy用户信息
    [self requestLazyUserinfo];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test1:) name:@"addOne" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchSuccessedAlert) name:@"graporder" object:nil];
    
    //收起抢单 的按钮
    [self rushOutBut];
    
    //查询个人信用度
    [self requestUserCreditInfo];
    
    //自定义提示框
    [self myalert];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    //定位
    [self locationClicks];
    
    //刷新抢单页
    [self.myRushtable reloadData];
    
    //关掉前面的键盘
    [self.view endEditing:YES];
    
    //查询Crazy用户位置
    [self requestLazyLocationInfo];

    //观察者
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(alterCodeClick) name:@"alterCode" object:nil];

    [center addObserver:self selector:@selector(deleOrder:) name:@"searchOrder" object:nil];
}

- (void)searchSuccessedAlert
{
    //抢单成功提示
    [self MyAlert:self.rushSucceed];
}


#pragma make - 自定义提示框
- (void)myalert
{
    //未实名认证提示
    self.NotCertificationAlert = [[MyAlert alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-50, UISCREEN_HEIGHT/2-22.5, 100, 45) WithNameStr:@"请实名认证!"];
    
    //抢单成功提示
    self.rushSucceed = [[MyAlert alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-75, UISCREEN_HEIGHT/2-22.5, 150, 45) WithNameStr:@"被你抢到啦≧▽≦"];
    
    //抢单成功提示
    self.rushFail = [[MyAlert alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-75, UISCREEN_HEIGHT/2-22.5, 150, 45) WithNameStr:@"抢不到啦>_<"];
}

#pragma make - 状态判断
//判断是否实名认证
- (void)judgeUserstatus{

    if ([self.c_userstatus isEqualToString:@"1"]) {
        
        self.isCertification = YES;
    }else if ([self.c_userstatus isEqualToString:@"0"]){
    
        self.isCertification = NO;
    }
}

- (void)alterCodeClick
{
    self.menuClick = YES;
}

#pragma mark - 抢单按钮控制
- (void)rushOutBut{
    
    self.close = NO;
    
    //收起抢单页按钮
    self.shouBut = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH-100, UISCREEN_HEIGHT-50, 30, 30)];
    [self.shouBut setImage:[UIImage imageNamed:@"shou_b"] forState:UIControlStateNormal];
    [self.shouBut addTarget:self action:@selector(rushOut) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.shouBut];
}

// 初始化 抢单table
- (void)initRush
{
    self.myRushtable = [[UITableView alloc]initWithFrame:CGRectMake(0, UISCREEN_HEIGHT/3, UISCREEN_WIDTH, UISCREEN_HEIGHT/2-65)];
    self.myRushtable.backgroundColor = [UIColor clearColor];
    self.myRushtable.tableFooterView = [[UIView alloc]init];
    self.myRushtable.delegate = self;
    self.myRushtable.dataSource = self;
    [self.view addSubview:self.myRushtable];
    
    //調用刷新方法
    [self setupRefresh];
}

- (void)rushOut{
    
    if (self.close == NO) {
        
        [self.shouBut setImage:[UIImage imageNamed:@"kai_b"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.7  //速度
                         animations:^{   //修改View坐标
                             
                             self.myRushtable.frame = CGRectMake(UISCREEN_WIDTH, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT/2-65);
                         } completion:^(BOOL finished) {
                             
                             [self.myRushtable removeFromSuperview];
                             self.close = YES;
                        }];
        
    }else{
        
        [self.myRushtable reloadData];
        
        [self.shouBut setImage:[UIImage imageNamed:@"shou_b"] forState:UIControlStateNormal];
        
        [self.view addSubview:self.myRushtable];
        
        self.myRushtable.frame = CGRectMake(0, UISCREEN_HEIGHT/3, UISCREEN_WIDTH, UISCREEN_HEIGHT/2-65);
        
        self.close = NO;
    }
    //置顶
    [self.view bringSubviewToFront:self.MyMenu];
}

#pragma mark - 抢单 Rush tableview 方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.orderInfoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 90;
}

- (MyRushTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str = @"table";
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (self.cell == nil)
    {
        self.cell = [[MyRushTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    self.cell.backgroundColor = [UIColor clearColor];
    
    self.cell.tag = indexPath.row;
    
    NSString * strId = [self.orderInfoArray [indexPath.row] objectForKey:@"l_user_userid"];
    
    for (NSDictionary *dicu in self.userInfoArray)
    {
        NSString *useridu = [dicu objectForKey:@"l_user_userid"];
        
        if([strId isEqualToString:useridu])
        {
            
            NSString * url = [NSString stringWithFormat:@"%@%@",LAZY_IMAGE_PATH,[dicu objectForKey:@"userimage"]];
            
            [self.cell.userImg sd_setImageWithURL:[NSURL URLWithString:url]];
            
            self.cell.messageLabel.text = [[self.orderInfoArray objectAtIndex:indexPath.row] objectForKey:@"ordertitle"];
            self.cell.moneyLabel.text = [NSString stringWithFormat:@"￥ %@",[[self.orderInfoArray objectAtIndex:indexPath.row] objectForKey:@"orderprice"]];
        }
    }
    self.cell.chooseBut.highlighted = YES;
    
    //设置cell点击颜色
    UIView *view_bg = [[UIView alloc]initWithFrame:self.cell.frame];
    view_bg.backgroundColor = [UIColor clearColor];
    self.cell.selectedBackgroundView = view_bg;
    
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    //收滚动条
    tableView.showsVerticalScrollIndicator = NO;
    
    self.cell.chooseBut.tag = indexPath.row;
    
    if (self.isCertification == NO) {
        
        //禁止抢单
        self.cell.chooseBut.enabled = NO;
    }else{
    
        [self.cell.chooseBut addTarget:self action:@selector(qiang:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self.cell;
}

- (void)qiang:(UIButton *)sender{
    
    self.l_userIDStatus  = [self.orderInfoArray[sender.tag] objectForKey:@"orderid"];
    
    self.SailorDic = [self.orderInfoArray objectAtIndex:sender.tag];       //要删除的字典
    
    NSLog(@"l_userIDStatus = %@",self.l_userIDStatus);
    
    //删除本地
    [self.orderInfoArray removeObjectAtIndex:sender.tag];

    [self.myRushtable reloadData];
    
    //修改订单状态
    [self changeOrderStatus];
}

//删除Array中的元素(并刷新TableView)
- (void)deleOrder:(NSNotification *)cation
{
    NSDictionary * orderDic = cation.object;
    for(int i=0;i<self.orderInfoArray.count;i++)
    {
        NSDictionary * nsDic = [self.orderInfoArray objectAtIndex:i];
        if([[nsDic objectForKey:@"orderid"] isEqualToString:[orderDic objectForKey:@"orderid"]])
        {
            [self.orderInfoArray removeObjectAtIndex:i];        //删除
        }
    }
    [self.myRushtable reloadData];           //刷新Table
}


- (void)tableView:(UITableView*)tableView willDisplayCell:(MyRushTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
    
    CGPoint toPoint = cell.layer.position;

    animation.duration = 0.4;
    
    if (self.isCellUpDown == YES) {
        
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x-200, toPoint.y)];
    }else{
    
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x+200, toPoint.y)];
    }
    
    if (indexPath.row == 0) {
        
        animation.duration = 0.2;
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x-300, toPoint.y)];
    }else if(indexPath.row == 1){
        
        animation.duration = 0.4;
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x-300, toPoint.y)];
    }else if(indexPath.row == 2){
        
        animation.duration = 0.6;
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x-300, toPoint.y)];
    }else if(indexPath.row == 3){
        
        animation.duration = 0.8;
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x-300, toPoint.y)];
    }
    
    [cell.layer addAnimation:animation forKey:@"a"];
}

//判断cell 上滑 下滑
- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView{
    
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y< self.lastContentOffset )
    {
        self.isCellUpDown = YES;
        
    } else if (scrollView. contentOffset.y >self.lastContentOffset )
    {
        //向下
        
        self.isCellUpDown = NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //若未实名认证 则不能点击
    if (self.isCertification == NO) {
        
        [self userImgAlert];
        
    }else{
        
        NSDictionary *orderDic = [self.orderInfoArray objectAtIndex:indexPath.row];
        
        DorderViewController *detail = [[DorderViewController alloc]init];
        
        [detail setValue:orderDic forKey:@"orderDic"];
        
        
        NSString *orderID = [orderDic objectForKey:@"l_user_userid"];
        
        for(NSDictionary * userDic in self.userInfoArray)        //用户信息
        {
            NSString *  userID = [userDic objectForKey:@"l_user_userid"];
            
            if([orderID isEqualToString:userID])
            {
                [detail setValue:userDic forKey:@"userDic"];
                [detail setValue:self.c_userid forKey:@"c_userid"];
                [self.navigationController pushViewController:detail animated:YES];
            }
        }
    }
}

#pragma mark - 下拉菜单

//下拉手势
- (void)recognizer{
    
    UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(ToMenu:)];
    [recognizer setDirection:UISwipeGestureRecognizerDirectionDown];
    [[self view] addGestureRecognizer:recognizer];
    
}

//下拉手势执行的方法
- (void)ToMenu:(UISwipeGestureRecognizer *)recognizer{
    
    //初始化下拉菜单
    [self MenuStar];
    
}

//初始化MENU
- (void)MenuStar
{
    self.MyMenu = [[MyMenuView alloc]initWithSidebar:CGRectMake(0, -UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    
    [self.view addSubview:self.MyMenu];
    
    if (self.menuClick == YES)
    {
        //下拉菜单出现
        [self Menu];
    }
}

//下拉菜单出现
- (void)Menu
{
    //下拉菜单栏
    [UIView animateWithDuration:0.7  //速度
                     animations:^{   //修改View坐标
                         
                         self.MyMenu.frame = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT);
                     } completion:^(BOOL finished) {
                     }];
    
    self.menuClick = NO;
}


#pragma mark - 地图
- (void)map{
    
    //展示地图
    [MAMapServices sharedServices].apiKey = APIKEY;
    
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    _mapView.delegate = self;
    
    //罗盘不显示
    _mapView.showsCompass = NO;
    //比例尺不显示
    _mapView.showsScale = NO;
    
    [self.view addSubview:_mapView];
    
    //定位
    [self locationClicks];
}

//定位按钮
- (void)location{
    
    self.locationBut = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH-50, UISCREEN_HEIGHT-50, 30, 30)];
    [self.locationBut addTarget:self action:@selector(locationClicks) forControlEvents:UIControlEventTouchUpInside];
    [self.locationBut setImage:[UIImage imageNamed:@"dingwei_q"] forState:UIControlStateNormal];
    
    [self.view addSubview:self.locationBut];
}

//定位
- (void)locationClicks
{
    if(_mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        //打开定位功能
        _mapView.showsUserLocation = YES;
        
        //设置跟踪用户模式
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        
        //设置缩放级别
        [_mapView setZoomLevel:14.09];
    }
    //修改Lazy用户位置
    [self alterCrazyLocation];
}

//定位模式改变时调用该方法
- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated
{
    if(mode == MAUserTrackingModeFollow)
    {
        [self.locationBut setImage:[UIImage imageNamed:@"dingwei_q"] forState:UIControlStateNormal];
    }
    else
    {
        [self.locationBut setImage:[UIImage imageNamed:@"dingwei_z"] forState:UIControlStateNormal];
    }
}

//当位置更新时，会进定位回调，通过回调函数，能获取到定位点的经纬度坐标
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    _locationInfo = userLocation.location;
    if(updatingLocation && self.userLocationAnnotationView != nil)
    {
        //定位点
        self.Lazylatitude = userLocation.coordinate.latitude;
        self.Lazylongitude = userLocation.coordinate.longitude;
        
        //自定义定位点的图标的位置
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            
        }];
    }
}

//对方位置点
- (void)mapImg{
    
    [_mapView setZoomLevel:14.09];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    
    for (int i=0; i<self.CrazyLocationArr.count; i++) {
        
        if (![self.CrazyLocationArr[i] isEqualToString:@""]) {
            
            //字符串分割 ----- 分别截取字符串 ，前后两个数
            NSArray *arr = [self.CrazyLocationArr[i] componentsSeparatedByString:@","];
            
            //NSString转换CLLocationDegrees
            self.Crazylatitude = [[arr objectAtIndex:0] doubleValue];
            self.Crazylongitude = [[arr objectAtIndex:1] doubleValue];
            
            pointAnnotation.coordinate = (CLLocationCoordinate2D){self.Crazylatitude,self.Crazylongitude};
            
            //给位置信息给气泡
            pointAnnotation.title = [NSString stringWithFormat:@"%f,%f",self.Crazylatitude,self.Crazylongitude];
            
            [_mapView addAnnotation:pointAnnotation];
        }
    }
}

//修改 定位图标
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        
        pre.image = [UIImage imageNamed:@"Map_lazyMan"];
        
        //关闭方向指示
        pre.showsHeadingIndicator = NO;
        //关闭精度圈
        pre.showsAccuracyRing = NO;
        
        [_mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
        view.canShowCallout = NO;
        self.userLocationAnnotationView = view;
    }
}

//修改 MAAnnotationView 对应的标注图片
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"Map_cazyMan"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, 0);
        //设置 气泡往左移
        annotationView.calloutOffset = CGPointMake(-55, 0);
        
        return annotationView;
    }
    return nil;
}

//点击气泡会走
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(CustomAnnotationView *)view{
    
    //坐标点 比对
    NSString *location = view.annotation.title ;
    //    NSLog(@"~~~~~~~~~~%@",location);
    
    //遍历location表
    for (NSDictionary *locationDic in self.l_userLocationArr) {
        
        NSString *user_location = [locationDic objectForKey:@"locationinfo"];
        
        //如果坐标点一样
        if ([location isEqualToString:user_location]) {
            //取ID
            NSString *locationID = [locationDic objectForKey:@"l_user_userid"];
            
            //遍历userinfo表
            for (NSDictionary *userDic in self.l_userInfoArr) {
                
                //取ID
                NSString *userID = [userDic objectForKey:@"l_user_userid"];
                //比对 如果一样 就赋值
                if ([locationID isEqualToString:userID]) {
                    
                    view.calloutView.usernameLabel.text = [userDic objectForKey:@"usernick"];
                    
                    //异步获取网络图片
                    NSString * url = [NSString stringWithFormat:@"%@%@",LAZY_IMAGE_PATH,[userDic objectForKey:@"userimage"]];
                    
                    // UIImage * internetImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
                    // view.calloutView.userImg.image = internetImage;
                    
                    [view.calloutView.userImg sd_setImageWithURL:[NSURL URLWithString:url]];
                    
                    self.l_userDic = userDic;
                    
                    if(self.isCertification == YES){
                    
                        UITapGestureRecognizer *userImgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToUserInfo)];
                        
                        view.calloutView.userImg.userInteractionEnabled = YES;
                        
                        [view.calloutView.userImg addGestureRecognizer:userImgTap];
                    }
                    else{
                        
                        UITapGestureRecognizer *userImgAlertTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userImgAlert)];
                        
                        view.calloutView.userImg.userInteractionEnabled = YES;
                        
                        [view.calloutView.userImg addGestureRecognizer:userImgAlertTap];
                        
                    }
                }
            }
        }
    }
}

#pragma mark - 未实名认证提示 气泡 头像
- (void)userImgAlert{

    //抢单成功提示
    [self MyAlert:self.NotCertificationAlert];
}

#pragma mark - 无订单提示框
- (void)MyAlert:(MyAlert *)alert{
    
    [UIView animateWithDuration:1 animations:^{
        
        alert.alpha = 0.3;
        
        [self.view addSubview:alert];
        
    } completion:^(BOOL finished) {
        
        sleep(1);
        [UIView animateWithDuration:1 animations:^{
            
            alert.alpha = 0;
        }];
    }];
}

#pragma mark - 改变状态栏
//改变状态栏背景色
- (void)statusBar{
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 20)];
    
    statusBarView.backgroundColor= COLORNAVIGATION;
    
    [self.view addSubview:statusBarView];
    
}
//改变状态栏文字为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - 自定义navigation
- (void)mynavigation{
    
    self.navigationController.navigationBarHidden = YES;      //隐藏默认导航条
    
    self.myBar = [[MyNavigation alloc]initWithNavBgImg:nil leftBtnBgImg:@"x_order" middleBtnBgImg:@"hanbaobaobao" rightBtnImg:@"search" titleStr:nil];
    
    [self.myBar.middleBut addTarget:self action:@selector(ToDown) forControlEvents:UIControlEventTouchUpInside];
    self.myBar.rightBut.frame = CGRectMake(UISCREEN_WIDTH-50, 23, 34, 34);
    [self.myBar.leftBut addTarget:self action:@selector(ToOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.myBar.rightBut addTarget:self action:@selector(ToSearch) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.myBar];
}


#pragma mark - 跳页方法

- (void)ToPersonal{
    
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    [self.navigationController pushViewController:personal animated:YES];
}

- (void)search{
    
    self.searchclose = YES;
    
    self.searchview = [[SearchViewTable alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT) and:self.c_userid and:self.userInfoArray];
    
    self.searchview.alpha =0;
    
    if (self.isCertification == YES) {
        
        self.searchview.isCertification = YES;
    }else{
        
        self.searchview.isCertification = NO;
    }

    [self.view addSubview:self.searchview];
}

- (void)ToSearch{
    
    [self search];
    
    if (self.searchclose == YES) {
        
      [UIView animateWithDuration:0.8 animations:^{
         
          self.searchview.alpha = 1;
          self.myBar.rightBut.alpha = 0;
          self.myBar.leftBut.alpha = 0;
          self.myBar.middleBut.alpha = 0;
          [self.searchview.searchbar resignFirstResponder];

          [self.searchview.cansebtn addTarget:self action:@selector(canse) forControlEvents:UIControlEventTouchUpInside];

      }];
    }
    else
    {
        self.searchview.alpha =0;
    }
    self.menuClick = NO;
    //置顶
    [self.view bringSubviewToFront:self.searchview];
}

//判断按钮的点击事件
-(void)canse{
    
    self.searchview.cansebtn.showsTouchWhenHighlighted =YES;
    
    [UIView animateWithDuration:0.8 animations:^{
        
        self.searchview.alpha =0;
        self.myBar.rightBut.alpha = 1;
        self.myBar.leftBut.alpha = 1;
        self.myBar.middleBut.alpha = 1;
 
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addOne" object:@"1"];
    
    [self.view endEditing:YES];
    
    self.menuClick = YES;
}

- (void)test1:(NSNotification*)notification{
    
    self.searchview.btn1.hidden =NO;
    self.searchview.btn2.hidden =NO;
    self.searchview.btn3.hidden =NO;
    self.searchview.btn4.hidden =NO;
    self.searchview.searchbar.text = @"";
    [self.searchview.table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)ToDown{
    
    if(self.menuClick == YES)
    {
        //初始化下拉菜单
        [self MenuStar];
        
        //下拉菜单栏
        [UIView animateWithDuration:0.7  //速度
                         animations:^{   //修改View坐标
                             
                             self.MyMenu.frame = CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT);
                         } completion:^(BOOL finished) {
                         }];
    }
}

- (void)ToOrder
{
    OrderViewController *Order = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:Order animated:YES];
    
    [Order setValue:self.c_userid forKey:@"c_userid"];
}

- (void)ToUserInfo{

    UserInfoViewController *userinfo = [[UserInfoViewController alloc]init];
    [self.navigationController pushViewController:userinfo animated:YES];
    
    [userinfo setValue:self.l_userDic  forKey:@"userDic"];
}

#pragma mark - 数据操作
//存储Crazy用户位置
- (void)saveCrazyLocation{

    NSString *locationin = [[NSString alloc]initWithFormat:@"%f,%f",self.Lazylatitude,self.Lazylongitude];
    
    NSLog(@"%@",locationin);
    
    //存自己当前的位置点
    NSMutableDictionary *LocationInfoDic = [NSMutableDictionary dictionary];
    [LocationInfoDic setValue:locationin forKey:@"locationinfo"];
    [LocationInfoDic setValue:self.c_userid forKey:@"userid"];
    
    MapService *mapDate = [[MapService alloc]init];
    
    [mapDate insertCrazyLocationInfo:LocationInfoDic and:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            
            NSString *userid = [dataDic objectForKey:@"userid"];
            
            NSLog(@"userid = %@",userid);
            
        }else
        {
            NSString *message =  [dataDic objectForKey:@"message"];
            
            NSLog(@"message = %@",message);
        }
    }];
}
//修改Crazy用户位置
- (void)alterCrazyLocation{
    
    NSString *locationin = [[NSString alloc]initWithFormat:@"%f,%f",self.Lazylatitude,self.Lazylongitude];
    
    NSLog(@"%@",locationin);
    
    //存自己当前的位置点
    NSMutableDictionary *LocationInfoDic = [NSMutableDictionary dictionary];
    [LocationInfoDic setValue:locationin forKey:@"locationinfo"];
    [LocationInfoDic setValue:self.c_userid forKey:@"userid"];
    
    MapService *mapDate = [[MapService alloc]init];
    
    [mapDate updateCrazyLocationInfo:LocationInfoDic and:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            
            NSString *userid = [dataDic objectForKey:@"userid"];
            
            NSLog(@"userid = %@",userid);
            
        }else
        {
            NSString *message =  [dataDic objectForKey:@"message"];
            
            NSLog(@"message = %@",message);
        }
    }];
}

//查询Lazy用户位置 显示在地图上
- (void)requestLazyLocationInfo{
    
    MapService *mapDate = [[MapService alloc]init];
    
    [mapDate requestLazyLocationInfo:^(NSDictionary *dataDic) {
         
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            NSArray *arr = [dataDic objectForKey:@"value"];
            
            self.l_userLocationArr = [dataDic objectForKey:@"value"];
            
            //遍历数组 取用户位置信息
            for (NSDictionary *userDic in arr) {
                
                NSString * str = [userDic objectForKey:@"locationinfo"];
                [self.CrazyLocationArr addObject:str];
                
                //展示对方位置点
                [self mapImg];
            }
        }else{
            
            NSLog(@"查询Crazy用户位置失败");
        }
    }];
}

//查询Lazy用户信息
- (void)requestLazyUserinfo{
    
    MapService *map = [[MapService alloc]init];
    
    [map requestLazyUserData:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        
        if([str isEqualToString:@"succeed"])
        {
            
            self.userInfoArray = [dataDic objectForKey:@"value"];
            
            self.l_userInfoArr = [dataDic objectForKey:@"value"];

        }else
        {
            NSLog(@"查询Lazy用户信息失败!");
        }
    }];
}

//归档用户信息(本地化)
- (void)requestUserInfo
{
    MapService * map = [[MapService alloc]init];
    
    [map requestCrazyUserData:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            NSArray *arr = [dataDic objectForKey:@"value"];
            
            //遍历数组 取用户信息
            for (NSDictionary *userDic in arr) {
                
                NSString * userID = [userDic objectForKey:@"c_user_userid"];
                
                if ([userID isEqualToString:self.c_userid]) {
    
                    self.c_userstatus = [userDic objectForKey:@"userstatus"];
                    
                    //判断是否已实名认证
                    [self judgeUserstatus];
                    
                    //存本地
                    UserInfomation * user = [[UserInfomation alloc]init];
                    
                    [user userSaveInfo:userDic andSuccess:^(NSString *str) {
                        NSLog(@"+++++++++++++++++%@",str);
                    }];
                }
            }
        }
        else
        {
            NSLog(@"查询Crazy用户信息失败!");
        }
    }];
}

//查询状态为2的订单 且每次请求3条
- (void)requestUserOrderTwo{

    self.myBar.rightBut.userInteractionEnabled = NO;
    self.myBar.leftBut.userInteractionEnabled = NO;
    self.myBar.middleBut.userInteractionEnabled = NO;
    
    MapService *map =[[MapService alloc]init];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                        @"2",                       @"status",
                                                          nil];
    
    [map requestLazyOrderTwo:dic and:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        
        if([str isEqualToString:@"succeed"])
        {
            for(NSDictionary * dic in [dataDic objectForKey:@"value"])
            {
                [self.orderInfoArray addObject:dic];
            }
        }
        else
        {
            NSLog(@"查询状态为2的订单失败!");
        }
        
        self.myBar.rightBut.userInteractionEnabled = YES;
        self.myBar.leftBut.userInteractionEnabled = YES;
        self.myBar.middleBut.userInteractionEnabled = YES;
    }];
}

//修改订单状态
- (void)changeOrderStatus{

    MapService *map = [[MapService alloc]init];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         self.l_userIDStatus,    @"orderid",
                         @"-1",    @"status",
                         nil];
    
    [map alfterOrderStatus:dic and:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        
        if([str isEqualToString:@"succeed"])
        {

            NSLog(@"修改订单状态成功");
            
            //抢单成功提示
            [self MyAlert:self.rushSucceed];
            
            Request *request = [[Request alloc]init];
            NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *currentTime = [formatter stringFromDate:[NSDate date]];
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            
            [dict setValue:[self.SailorDic objectForKey:@"orderid"] forKey:@"orderid"];
            [dict setValue:self.c_userid forKey:@"userid"];
            [dict setValue:[self.SailorDic objectForKey:@"ordertitle"] forKey:@"title"];
            [dict setValue:@"-1" forKey:@"status"];
            [dict setValue:[self.SailorDic objectForKey:@"orderprice"] forKey:@"price"];
            [dict setValue:currentTime forKey:@"time"];
            [dict setValue:[self.SailorDic objectForKey:@"orderinsurance"] forKey:@"insurance"];
            [dict setValue:[self.SailorDic objectForKey:@"orderdetail"] forKey:@"detail"];
            [dict setValue:[self.SailorDic objectForKey:@"orderremark"] forKey:@"remark"];
            [dict setValue:[self.SailorDic objectForKey:@"orderphone"] forKey:@"phone"];
            
            [request insertorder:dict and:^(NSDictionary *dataDic)
             {
                 NSString *insert = [dataDic objectForKey:@"code"];
                 
                 if ([insert isEqualToString:@"success"])
                 {
                     NSLog(@"！！！！插入成功！！");
                 }
             }];
            
        }else{

            NSLog(@"修改订单状态失败");
            
            //抢单失败提示
            [self MyAlert:self.rushFail];
        }
    }];
}
     
//查询Crazy用户信用度信息
- (void)requestUserCreditInfo{
    
    MapService * map = [[MapService alloc]init];
    
    NSDictionary *useridDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         self.c_userid,@"userid",
                         nil];
    
   [map selectUserCredit:useridDic and:^(NSDictionary *dataDic) {
       
       NSString * str = [dataDic objectForKey:@"code"];
       if([str isEqualToString:@"succeed"])
       {
           NSArray * arr = [dataDic objectForKey:@"value"];
           NSDictionary * dicc = [arr firstObject];
           
           NSLog(@"22222%@",dicc);
           
           UserInfomation * user = [[UserInfomation alloc]init];
           
           [user userSaveCreditInfo:dicc andSuccess:^(NSString *str) {
               
               NSLog(@"存入信用度成功！");
           }];
       }
       else
       {
           NSLog(@"查询Crazy用户信息失败!");
       }
   }];
}

#pragma mark - 上拉和下拉刷新
#pragma mark-自定义刷新方法
- (void)setupRefresh
{
    //下拉刷新
    [self.myRushtable addHeaderWithTarget:self action:@selector(hearRefreshing) dateKey:@"myRushtable"];
    [self.myRushtable headerBeginRefreshing];
    self.myRushtable.headerPullToRefreshText=@"下拉刷新";
    self.myRushtable.headerReleaseToRefreshText=@"松开马上刷新";
    self.myRushtable.headerRefreshingText=@"正在赶来...";

    // 上拉加载更多
//    [self.myRushtable addFooterWithTarget:self action:@selector(footerRefreshing)];
//    self.myRushtable.footerPullToRefreshText=@"上拉加载";
//    self.myRushtable.footerReleaseToRefreshText=@"松开马上加载";
//    self.myRushtable.footerRefreshingText=@"加载中...";
}

#pragma mark-下拉刷新
- (void)hearRefreshing
{
    
    MapService *map =[[MapService alloc]init];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:
                         @"2",                       @"status",
                         nil];
    [map requestLazyOrderTwo:dic and:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        
        if([str isEqualToString:@"succeed"])
        {
            NSArray * arr = [dataDic objectForKey:@"value"];
            self.orderInfoArray = [arr mutableCopy];
            
            //刷新抢单页
            [self.myRushtable reloadData];
            [self.myRushtable headerEndRefreshing];
        }
        else
        {
            //刷新抢单页
            [self.myRushtable reloadData];
            [self.myRushtable headerEndRefreshing];
        }
    }];
}

//#pragma mark-上拉加载
//- (void)footerRefreshing
//{
//    [self.myRushtable reloadData];
//    [self.myRushtable footerEndRefreshing];
//}

@end
