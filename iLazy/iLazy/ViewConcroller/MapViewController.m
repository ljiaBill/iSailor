//
//  RootViewController.m
//  iLazy
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MapViewController.h"
#import "UserInfo.h"
#import "UserInfoViewController.h"
#import "UIImageView+WebCache.h"

@interface MapViewController ()

@end


@implementation MapViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuClick = YES;
    
    //置顶
    [self.view bringSubviewToFront:self.MyMenu];
    
    self.view.backgroundColor = [UIColor clearColor];

    self.CrazyLocationArr = [NSMutableArray array];
    self.CrazyLocationArrCallout = [NSMutableArray array];
    
    //改变状态栏
    [self statusBar];
    
    //自定义navigation
    [self mynavigation];
    
    //地图
    [self initMap];
    
    //定位按钮
    [self initLocation];
    
    //下拉手势
    [self recognizer];

    //归档用户信息
    [self requestUserInfo];
    
    //查询Crazy用户信息
    [self requestCrazyUserinfo];
    
    //查询Crazy用户信用度信息
    [self requestUserCreditInfo];

}

- (void)alterCodeClick
{
    self.menuClick = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];

    [super viewWillAppear:YES]; 
    //关掉前面的键盘
    [self.view endEditing:YES];
    
    //查询Crazy用户位置
    [self requestCrazyLocationInfo];
    
    //观察者
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(alterCodeClick) name:@"alterCode" object:nil];
}

//定位按钮
- (void)initLocation{

    self.locationBut = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH-50, UISCREEN_HEIGHT-50, 30, 30)];
    [self.locationBut addTarget:self action:@selector(locationClicks) forControlEvents:UIControlEventTouchUpInside];
    [self.locationBut setImage:[UIImage imageNamed:@"dingwei_q"] forState:UIControlStateNormal];
    
    [self.view addSubview:self.locationBut];
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
- (void)initMap{
    
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

    //存储Lazy用户位置
    [self saveLazyLocation];
}

//定位
- (void)locationClicks{
    
    if(_mapView.userTrackingMode != MAUserTrackingModeFollow)
    {
        //打开定位功能
        _mapView.showsUserLocation = YES;
        //设置定位模式(跟随用户位置的变化而确定中心点)
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        //缩放级别
        [_mapView setZoomLevel:14.09];
    }
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
        
//        NSLog(@"/////////////%f, %f",self.Lazylatitude,self.Lazylongitude);
        
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
        
        pre.image = [UIImage  imageNamed:@"Map_lazyMan"];
        
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

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(CustomAnnotationView *)view{
    
    //坐标点 比对
    NSString *location = view.annotation.title ;
//    NSLog(@"~~~~~~~~~~%@",location);
    
//遍历location表
    for (NSDictionary *locationDic in self.c_userLocationArr) {

        NSString *user_location = [locationDic objectForKey:@"locationinfo"];

//如果坐标点一样
        if ([location isEqualToString:user_location]) {
//取ID
              NSString *locationID = [locationDic objectForKey:@"c_user_userid"];

//遍历userinfo表
            for (NSDictionary *userDic in self.c_userInfoArr) {
                
                //取ID
                NSString *userID = [userDic objectForKey:@"c_user_userid"];
                //比对 如果一样 就赋值
                if ([locationID isEqualToString:userID]) {
                    
                    view.calloutView.usernameLabel.text = [userDic objectForKey:@"usernick"];
                    
                    //异步获取网络图片
                    NSString * url = [NSString stringWithFormat:@"%@%@",CRAZY_IMAGE_PATH,[userDic objectForKey:@"userimage"]];
//                    UIImage * internetImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
//
//                    view.calloutView.userImg.image = internetImage;
                    [view.calloutView.userImg sd_setImageWithURL:[NSURL URLWithString:url]];

                    self.c_userDic = userDic;
                    
                    UITapGestureRecognizer *userImgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToUserInfo)];
                    
                    view.calloutView.userImg.userInteractionEnabled = YES;
                    
                    [view.calloutView.userImg addGestureRecognizer:userImgTap];
                }
            }
            
//遍历userCreditInfo表
            for (NSDictionary *userCreditDic in self.c_userCreditInfoArr) {
                
                //取ID
                NSString *userCreditID = [userCreditDic objectForKey:@"c_user_userid"];
                
                //比对 如果一样 就赋值
                if ([locationID isEqualToString:userCreditID]) {
                
                    self.c_userCreditDic = userCreditDic;
                    
                 NSInteger fraction = [[userCreditDic objectForKey:@"creditinfo"] integerValue];
//星星
                        if (fraction > 500)
                        {
                            //五颗星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarTwo"];
                        }
                        else if (fraction > 400)
                        {
                            //四颗半星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarThere"];
                        }
                        else if (fraction > 300)
                        {
                            //四颗星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarOne"];
                        }
                        else if (fraction > 200)
                        {
                            //三颗半星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarThere"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarOne"];
                        }
                        else if (fraction > 100)
                        {
                            //三颗星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarOne"];
                        }
                        
                        else if (fraction > 70)
                        {
                            //两颗半星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarThere"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarOne"];
                        }
                        else if (fraction > 40)
                        {
                            //两颗星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarOne"];
                        }
                        else if (fraction > 20)
                        {
                            //一颗半星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarThere"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarOne"];
                        }
                        else if (fraction > 8)
                        {
                            //一颗星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarTwo"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarOne"];
                        }
                        else if (fraction > 2)
                        {
                            //半颗星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarThere"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarOne"];
                        }
                        else
                        {
                            //无星
                            view.calloutView.starOne.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starTwo.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starThere.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFour.image = [UIImage imageNamed:@"creditStarOne"];
                            view.calloutView.starFive.image = [UIImage imageNamed:@"creditStarOne"];
                        }
                    
                }
            }
        }
     }
    
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
    
    MyNavigation *myBar = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"x_order" middleBtnBgImg:@"hanbaobaobao" rightBtnImg:@"publish" titleStr:nil];
    
    [myBar.middleBut addTarget:self action:@selector(ToDown) forControlEvents:UIControlEventTouchUpInside];
    
    [myBar.leftBut addTarget:self action:@selector(ToOrder) forControlEvents:UIControlEventTouchUpInside];
    
    [myBar.rightBut addTarget:self action:@selector(ToPublish) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:myBar];
}

#pragma mark - 数据操作

//查询Crazy用户信息
- (void)requestCrazyUserinfo{
    
    MapService *map = [[MapService alloc]init];
    
    [map requestCrazyUserData:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            
            self.c_userInfoArr = [dataDic objectForKey:@"value"];

        }else
        {
            NSLog(@"查询Crazy用户信息失败!");
        }
    }];
}

//存储Lazy用户位置
- (void)saveLazyLocation{
    
    NSString *locationin = [[NSString alloc]initWithFormat:@"%f,%f",self.Lazylatitude,self.Lazylongitude];
    
    NSLog(@"locationin = %@",locationin);
    
    //存自己当前的位置点
    NSMutableDictionary *LocationInfoDic = [NSMutableDictionary dictionary];
    [LocationInfoDic setValue:locationin forKey:@"locationinfo"];
    [LocationInfoDic setValue:self.l_userid forKey:@"userid"];
    
    MapService *mapDate = [[MapService alloc]init];
    
    [mapDate insertLazyLocationInfo:LocationInfoDic and:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            
            NSString *userid = [dataDic objectForKey:@""];
            
            NSLog(@"userid = %@",userid);
            
        }else
        {
            NSString *message =  [dataDic objectForKey:@"message"];
            
            NSLog(@"message = %@",message);
        }
    }];
}

//查询Crazy用户位置 显示在地图上
- (void)requestCrazyLocationInfo{

     MapService *mapDate = [[MapService alloc]init];
    
    [mapDate requestCrazyLocationInfo:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
             NSArray *arr = [dataDic objectForKey:@"value"];
            
            self.c_userLocationArr  = [dataDic objectForKey:@"value"];
            
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

//归档用户信息(本地化)
- (void)requestUserInfo
{
    MapService * map = [[MapService alloc]init];
    
    [map requestLazyUserData:^(NSDictionary *dataDic) {
        
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
            NSArray *arr = [dataDic objectForKey:@"value"];
            
            //遍历数组 取用户信息
            for (NSDictionary *userDic in arr) {

                NSString * userID = [userDic objectForKey:@"l_user_userid"];
                
                if ([userID isEqualToString:self.l_userid]) {
                    
                    UserInfo * user = [[UserInfo alloc]init];
                    
                    [user userSaveInfo:userDic andSuccess:^(NSString *str) {
                        
                        NSLog(@"+++++++++++++++++%@",str);
                    }];
                }
            }
        }
        else
        {
            NSLog(@"查询Lazy用户信息失败!");
        }
    }];
}


//查询Crazy用户信用度信息
- (void)requestUserCreditInfo{

    MapService * map = [[MapService alloc]init];
    
    [map requestUserCreditInfo:^(NSDictionary *dataDic) {
       
        NSString * str = [dataDic objectForKey:@"code"];
        if([str isEqualToString:@"succeed"])
        {
           self.c_userCreditInfoArr = [dataDic objectForKey:@"value"];
        
            
            NSLog(@"!!!!!!!!!!!!%@",self.c_userCreditInfoArr);
        }
        else
        {
            NSLog(@"查询Crazy用户信用度信息失败!");
        }
    }];
}


#pragma mark - 跳页方法

- (void)ToPersonal{
    
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    [self.navigationController pushViewController:personal animated:YES];
}

- (void)ToOrder{

    AppDelegate * app = [UIApplication sharedApplication].delegate;
     OrderViewController *Order = [[OrderViewController alloc]init];
    [app.rootNav pushViewController:Order animated:YES];
    
    [Order setValue:self.l_userid forKey:@"l_userid"];
}

- (void)ToPublish{
 
    PublishViewController *publish = [[PublishViewController alloc]init];
    
    [publish setValue:self.l_userid forKey:@"l_userid"];
    
    [self.navigationController pushViewController:publish animated:YES];
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

- (void)ToUserInfo{
    
    UserInfoViewController *userinfo = [[UserInfoViewController alloc]init];
    [self.navigationController pushViewController:userinfo animated:YES];
    
    [userinfo setValue:self.c_userDic  forKey:@"userDic"];
    [userinfo setValue:self.c_userCreditDic  forKey:@"fractionDic"];
    
}

@end
