
//
//  SidebarView.m
//  iLazy
//
//  Created by administrator on 15/9/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MyMenuView.h"
#import "Macro.h"
#import "PersonalViewController.h"
#import "AboutViewController.h"
#import "ServiceViewController.h"
#import "SetViewController.h"
#import "FeedbackViewController.h"
#import "WelcomeViewController.h"
#import "UserInfo.h"
#import "AppDelegate.h"

@implementation MyMenuView

- (instancetype)initWithSidebar:(CGRect)frame{
    
    self = [super initWithFrame:CGRectMake(0, -UISCREEN_HEIGHT, UISCREEN_WIDTH,UISCREEN_HEIGHT)];
    
    if (self) {
        
        //退出登录  即底层View
        self.View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        self.View.backgroundColor = COLORNAVIGATION;
        self.ImgView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-57, UISCREEN_HEIGHT*5/6+(UISCREEN_HEIGHT/6)/2-30, 48, 48)];
        self.ImgView.image = [UIImage imageNamed:@"fankui"];
        self.Label = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-10, UISCREEN_HEIGHT*5/6+(UISCREEN_HEIGHT/6)/2-25, 100, 50)];
        self.Label.text = @"意见反馈";
        self.Label.textColor = [UIColor whiteColor];
        
        self.but = [[UIButton alloc]initWithFrame:CGRectMake(0, UISCREEN_HEIGHT*5/6, UISCREEN_WIDTH, UISCREEN_HEIGHT/6)];
        self.but.backgroundColor = [UIColor clearColor];
        
        [self.View addSubview:self.but];
        
        
        [self.View addSubview:self.ImgView];
        [self.View addSubview:self.Label];
        [self addSubview:self.View];
        
        //个人资料
        self.personalView = [[UIView alloc] initWithFrame:CGRectMake(0, -UISCREEN_HEIGHT*5, UISCREEN_WIDTH, UISCREEN_HEIGHT/6)];
        self.personalView.backgroundColor = COLORMAMP(246,115,128,1);
        self.personalImgView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-40,UISCREEN_HEIGHT/6/2-15, 30, 30)];
        self.personalImgView.image = [UIImage imageNamed:@"map"];
        self.personalLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-10, UISCREEN_HEIGHT/6/2-25, 100, 50)];
        self.personalLabel.text = @"首页";
        self.personalLabel.textColor = [UIColor whiteColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.2f target:self selector:@selector(PersonalUpdateTimer:) userInfo:nil repeats:NO];
        

        
        [self.personalView addSubview:self.personalLabel];
        [self.personalView addSubview:self.personalImgView];
        [self.View addSubview:self.personalView];
        
        
        //地图
        self.mapView = [[UIView alloc] initWithFrame:CGRectMake(0, -UISCREEN_HEIGHT*4, UISCREEN_WIDTH, UISCREEN_HEIGHT/6)];
        self.mapView.backgroundColor = COLORMAMP(255,181,149,1);
        self.mapImgView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-50 , UISCREEN_HEIGHT/6/2-25, 50, 50)];
        self.mapImgView.image = [UIImage imageNamed:@"personal"];
        self.mapLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-10, UISCREEN_HEIGHT/6/2-25, 100, 50)];
        self.mapLabel.text = @"个人资料";
        self.mapLabel.textColor = [UIColor whiteColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(MapUpdateTimer:) userInfo:nil repeats:NO];
        
    
        
        [self.mapView addSubview:self.mapLabel];
        [self.mapView addSubview:self.mapImgView];
        [self.View addSubview:self.mapView];
        
        
        //关于懒人
        self.aboutView = [[UIView alloc] initWithFrame:CGRectMake(0, -UISCREEN_HEIGHT*3, UISCREEN_WIDTH, UISCREEN_HEIGHT/6)];
        self.aboutView.backgroundColor =  COLORMAMP(193,108,133,1);
        self.aboutImgView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-53, UISCREEN_HEIGHT/6/2-29, 55, 55)];
        self.aboutImgView.image = [UIImage imageNamed:@"about"];
        self.aboutLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-10, UISCREEN_HEIGHT/6/2-25, 100, 50)];
        self.aboutLabel.text = @"关于懒人";
        self.aboutLabel.textColor = [UIColor whiteColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.9f target:self selector:@selector(AboutUpdateTimer:) userInfo:nil repeats:NO];
        
 
        
        [self.aboutView addSubview:self.aboutLabel];
        [self.aboutView addSubview:self.aboutImgView];
        [self.View addSubview:self.aboutView];
        
        
        //服务
        self.serviceView = [[UIView alloc] initWithFrame:CGRectMake(0, -UISCREEN_HEIGHT*2, UISCREEN_WIDTH, UISCREEN_HEIGHT/6)];
        self.serviceView.backgroundColor = COLORMAMP(75,192,201,1);
        self.serviceImgView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-40, UISCREEN_HEIGHT/6/2-15, 30, 30)];
        self.serviceImgView.image = [UIImage imageNamed:@"service"];
        self.serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-10, UISCREEN_HEIGHT/6/2-25, 100, 50)];
        self.serviceLabel.text = @"服务";
        self.serviceLabel.textColor = [UIColor whiteColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.7f target:self selector:@selector(ServiceUpdateTimer:) userInfo:nil repeats:NO];
        
   
        [self.serviceView addSubview:self.serviceLabel];
        [self.serviceView addSubview:self.serviceImgView];
        [self.View addSubview:self.serviceView];
        
        
        //设置
        self.settingView = [[UIView alloc] initWithFrame:CGRectMake(0, -UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT/6)];
        self.settingView.backgroundColor = COLORMAMP(59,152,216,1);
        self.settingImgView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-55, UISCREEN_HEIGHT/6/2-33, 58, 58)];
        self.settingImgView.image = [UIImage imageNamed:@"setting"];
        self.settingLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-10, UISCREEN_HEIGHT/6/2-25, 100, 50)];
        self.settingLabel.text = @"设置";
        self.settingLabel.textColor = [UIColor whiteColor];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(SettingUpdateTimer:) userInfo:nil repeats:NO];
        
    
        [self.settingView addSubview:self.settingLabel];
        [self.settingView addSubview:self.settingImgView];
        [self.View addSubview:self.settingView];
        
        //拖拽手势
        UISwipeGestureRecognizer * goBackMap = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(ToMap)];
        goBackMap.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:goBackMap];
        
        //让点击事件在动画之后执行
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(actionTimer:) userInfo:nil repeats:NO];
    }
    
    return self;
}

//计时器
- (void)SettingUpdateTimer:(NSTimer *)sender{
    
    [self view:self.settingView frame:UISCREEN_HEIGHT*4/6];
    
   }
- (void)ServiceUpdateTimer:(NSTimer *)sender{
    
    [self view:self.serviceView frame:UISCREEN_HEIGHT*3/6];
    
 

}
- (void)AboutUpdateTimer:(NSTimer *)sender{
    
    [self view:self.aboutView frame:UISCREEN_HEIGHT*2/6];
    
   }
- (void)MapUpdateTimer:(NSTimer *)sender{
    
    [self view:self.mapView frame:UISCREEN_HEIGHT/6];
    
}
- (void)PersonalUpdateTimer:(NSTimer *)sender{
    
    [self view:self.personalView frame:0];
}

- (void)actionTimer:(NSTimer *)sender{
    
        
        UITapGestureRecognizer *mapTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToPersonal)];
        [self.mapView addGestureRecognizer:mapTap];
        
        UITapGestureRecognizer *aboutTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToAbout)];
        [self.aboutView addGestureRecognizer:aboutTap];
        
        UITapGestureRecognizer *serviceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToService)];
        [self.serviceView addGestureRecognizer:serviceTap];
        
        UITapGestureRecognizer *settingTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToSetting)];
        [self.settingView addGestureRecognizer:settingTap];
        
        UITapGestureRecognizer *personalTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ToMap)];
        [self.personalView addGestureRecognizer:personalTap];
        
        UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(FendBack)];
        [self.but addGestureRecognizer:Tap];

}


//移动的范围
- (void)view:(UIView *)view frame:(CGFloat )y{
    
    [UIView animateWithDuration:0.7
                     animations:^{
                         
                         CGRect rect;
                         rect.origin.y  = y;
                         
                         view.frame = CGRectMake(0, y, UISCREEN_WIDTH, UISCREEN_HEIGHT/6);
                         
                     } completion:^(BOOL finished) {
                         
                         [self show:view];
                     }];
}

//动画效果
- (void)show:(UIView *)view{
    
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    basicAnimation.duration = 0.1;
    basicAnimation.autoreverses = YES;
    basicAnimation.repeatCount = 1;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fromValue = [NSNumber  numberWithFloat:-0.08];
    basicAnimation.toValue = [NSNumber  numberWithFloat:0.08];
    
    //将动作添加到新建的cell中(key可以任意取)
    [view.layer addAnimation:basicAnimation forKey:@"basicAnimation"];
    
}

#pragma mark - 跳页方法

//意见反馈
- (void)FendBack{
    
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    FeedbackViewController *fendBack = [[FeedbackViewController alloc]init];
    [app.rootNav pushViewController:fendBack animated:YES];
    
    [self moveView];
}

- (void)ToSetting{
    
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    SetViewController *setting = [[SetViewController alloc]init];
    [app.rootNav pushViewController:setting animated:YES];
    
    [self moveView];
}

- (void)ToService{

    AppDelegate * app = [UIApplication sharedApplication].delegate;
    ServiceViewController *service = [[ServiceViewController alloc]init];
    [app.rootNav pushViewController:service animated:YES];
    
    [self moveView];
}

- (void)ToAbout{
    
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    AboutViewController *about = [[AboutViewController alloc]init];
    [app.rootNav pushViewController:about animated:YES];
    
    [self moveView];
}

- (void)ToPersonal{

    AppDelegate * app = [UIApplication sharedApplication].delegate;
    PersonalViewController *personal = [[PersonalViewController alloc]init];
    [app.rootNav pushViewController:personal animated:YES];
    
    UserInfo * user = [[UserInfo alloc]init];
    [user userReadInfo:^(NSDictionary *dic) {
        
        [personal setValue:dic forKey:@"userinfoDic"];
        
    }];
    
    [self moveView];
}

- (void)ToMap{
    
    [UIView animateWithDuration:0.7  //速度
                     animations:^{   //修改View坐标
                         
                self.frame = CGRectMake(0, -UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT);
                         
                    } completion:^(BOOL finished) {
            //发通知
            NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
            [center postNotificationName:@"alterCode" object:nil];
     }];

}

- (void)moveView
{
    [UIView animateWithDuration:0.7  //速度
                     animations:^{   //修改View坐标
                         
                         self.alpha = 0;
                         
                     } completion:^(BOOL finished) {
                         self.frame = CGRectMake(0, -UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT);
                         //发通知
                         NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
                         [center postNotificationName:@"alterCode" object:nil];
                     }];
}

@end
