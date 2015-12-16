//
//  SwitchView.m
//  iLazy
//
//  Created by Administrator on 15/9/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "SwitchView.h"

@implementation SwitchView

#pragma mark - 初始化方法
- (instancetype)initWithSwitchView:(CGRect)frame andId:(NSString *)l_userid
{
    self.l_userid = l_userid;
    self = [super initWithFrame:CGRectMake(0, 94, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    if(self)
    {
        self.isClick = YES;
        //展示页面
        self.finishView = [[UIView alloc]initWithFrame:CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT)];

        self.unFinishView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];

        self.assessView = [[UIView alloc]initWithFrame:CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        
        self.unCarryView = [[UIView alloc]initWithFrame:CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        
        //初始化TableView
        self.finishTableView = [[FinishTableView alloc]initWithTableView:CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        self.unFinishTableView = [[UnFinishTableView alloc]initWithTableView:CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        self.assessTableView = [[AssessViewTableView alloc]initWithTableView:CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        self.unCarryTableView = [[UnCarryTableView alloc]initWithTableView:CGRectMake(0, UISCREEN_HEIGHT, UISCREEN_WIDTH, UISCREEN_HEIGHT)];

        self.finishView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.finishTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self.finishView addSubview: self.finishTableView];
        [self.unFinishView addSubview:self.unFinishTableView];
        [self.assessView addSubview:self.assessTableView];
        [self.unCarryView addSubview:self.unCarryTableView];
        
        self.finishAnewBut = [[UIButton alloc]initWithFrame:CGRectMake(40, UISCREEN_WIDTH/2-UISCREEN_HEIGHT/10, UISCREEN_WIDTH-80, UISCREEN_HEIGHT/3.5)];
        
        self.point = [[UILabel alloc]initWithFrame:CGRectMake(40, UISCREEN_WIDTH/2-UISCREEN_HEIGHT/10+UISCREEN_HEIGHT/4, UISCREEN_WIDTH-80, 40)];
        
        self.finishHUDView = [[UIView alloc]initWithFrame:CGRectMake(40, UISCREEN_WIDTH/2-UISCREEN_HEIGHT/10, UISCREEN_WIDTH-80, UISCREEN_HEIGHT/3.5)];
        
        self.finishHUDView.alpha = 0;
        
        //添加
        [self addSubview:self.finishView];      //已完成
        [self addSubview:self.assessView];      //待评价
        [self addSubview:self.unFinishView];    //待完成
        [self addSubview:self.unCarryView];     //待接单
        
        self.finishAnewBut.alpha = 0;
        self.point.alpha = 0;
    }
    
    [self upLoad];
    
    return self;
}

#pragma mark - 请求数据
- (void)requertData
{
    //请求数据
    dataRequest * data = [[dataRequest alloc]init];
    
    NSDictionary * useridDic = [[NSDictionary alloc]initWithObjectsAndKeys:
                                self.l_userid,   @"userid"
                                , nil];
    
    [data requestOrderData:useridDic and:^(NSDictionary *dataDic) {
        
        self.orderInfoArray = [dataDic objectForKey:@"value"];
        [data requestUserData:^(NSDictionary *dataDic) {                //请求用户表
            
            self.userInfoArray = [dataDic objectForKey:@"value"];
            
            [data requestOrderAllData:^(NSDictionary *dataDic) {
                
                self.orderAllInfoArray = [dataDic objectForKey:@"value"];

                [self.finishTableView getOrderData:self.orderInfoArray and:self.userInfoArray and:self.orderAllInfoArray and:self.l_userid];
                [self.unFinishTableView getOrderData:self.orderInfoArray and:self.userInfoArray and:self.orderAllInfoArray and:self.l_userid];
                [self.assessTableView getOrderData:self.orderInfoArray and:self.userInfoArray and:self.orderAllInfoArray and:self.l_userid];
                [self.unCarryTableView getOrderData:self.orderInfoArray and:self.l_userid];
                
                self.isClick = NO;
                [self.timer invalidate];         //取消定时器
                self.finishAnewBut.alpha = 0;
                self.point.alpha = 0;
                self.finishHUDView.alpha = 0;
            }];
         }];
     }];
    
    while(self.isClick){}
}

#pragma mark - 计时器
- (void)ServiceUpdateTimer{
    
    self.isClick = NO;
    NSLog(@"时间到了......");
    self.finishAnewBut.alpha = 1;
    self.point.alpha = 1;
    self.finishHUDView.alpha = 0;
    
    self.finishAnewBut.backgroundColor = [UIColor clearColor];
    [self.finishAnewBut.layer setCornerRadius:10];
    [self.finishAnewBut setImage:[UIImage imageNamed:@"dabai"] forState:UIControlStateNormal];
    [self.finishAnewBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.finishAnewBut.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.finishAnewBut];
    
    self.point.textAlignment = NSTextAlignmentCenter;
    self.point.text = @"---点击重新加载---";
    self.point.textColor = COLORNAVIGATION;
    self.point.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.point];
    
    [self.finishAnewBut addTarget:self action:@selector(upLoad) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 加载圈圈
- (void)upLoad
{
    self.finishAnewBut.alpha = 0;
    self.point.alpha = 0;
    self.finishHUDView.alpha = 1;

    self.isClick = YES;
    //初始化加载圈圈
    self.finishProgressHUD = [[MBProgressHUD alloc]initWithView:self];
    
    [self.finishHUDView addSubview:self.finishProgressHUD];
    
    [self addSubview:self.finishHUDView];
    
    self.finishProgressHUD.delegate = self;
    self.finishProgressHUD.labelText = @"载入中...";
    
    [self.finishProgressHUD showWhileExecuting:@selector(requertData) onTarget:self withObject:nil animated:YES];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:25 target:self selector:@selector(ServiceUpdateTimer) userInfo:nil repeats:NO];
}

#pragma mark - 弹出finishView动画
- (void)switchFinishView
{
    typeof(self) __weak weak = self;
    self.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
        
        weak.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.finishTableView.layer.cornerRadius = 8;
        self.unFinishTableView.layer.cornerRadius = 8;
        self.assessTableView.layer.cornerRadius = 8;
        self.unCarryTableView.layer.cornerRadius = 8;
        sleep(0.6);
        
    } completion:^(BOOL finished)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.unFinishView.alpha = 1;
            self.assessView.alpha = 1;
            
            weak.transform = CGAffineTransformMakeScale(1, 1);
            self.finishView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -UISCREEN_HEIGHT);
            self.assessView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, UISCREEN_HEIGHT);

            self.unFinishView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, UISCREEN_HEIGHT);
            self.unCarryView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, UISCREEN_HEIGHT);

            self.finishTableView.layer.cornerRadius = 0;
            self.unFinishTableView.layer.cornerRadius = 0;
            self.assessTableView.layer.cornerRadius = 0;
            self.unCarryTableView.layer.cornerRadius = 0;
        }];

    }];
}

#pragma mark - 弹出unFinishView动画
- (void)switchUnFinishView
{
    typeof(self) __weak weak = self;
    self.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
        
        weak.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.finishTableView.layer.cornerRadius = 8;
        self.unFinishTableView.layer.cornerRadius = 8;
        self.assessTableView.layer.cornerRadius = 8;
        self.unCarryTableView.layer.cornerRadius = 8;
        sleep(0.6);
        
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.3 animations:^{
             self.unFinishView.alpha = 1;
             self.assessView.alpha = 1;
             
             weak.transform = CGAffineTransformMakeScale(1, 1);
             
             self.unFinishView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,0);
             self.finishView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,UISCREEN_HEIGHT);
             self.assessView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,UISCREEN_HEIGHT);
             self.unCarryView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,UISCREEN_HEIGHT);
             
             self.finishTableView.layer.cornerRadius = 0;
             self.unFinishTableView.layer.cornerRadius = 0;
             self.assessTableView.layer.cornerRadius = 0;
             self.unCarryTableView.layer.cornerRadius = 0;
         }];
         
     }];
}

#pragma mark - 弹出assessView动画
- (void)switchAssessView
{
    typeof(self) __weak weak = self;
    self.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
        
        weak.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.finishTableView.layer.cornerRadius = 8;
        self.unFinishTableView.layer.cornerRadius = 8;
        self.assessTableView.layer.cornerRadius = 8;
        self.unCarryTableView.layer.cornerRadius = 8;
        sleep(0.6);
        
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.3 animations:^{
             self.unFinishView.alpha = 1;
             self.finishView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,UISCREEN_HEIGHT);
             self.unFinishView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,UISCREEN_HEIGHT);
             
             weak.transform = CGAffineTransformMakeScale(1, 1);
             
             self.assessView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,-UISCREEN_HEIGHT);
             self.unCarryView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,UISCREEN_HEIGHT);
             self.assessView.alpha = 1;
             self.finishTableView.layer.cornerRadius = 0;
             self.unFinishTableView.layer.cornerRadius = 0;
             self.assessTableView.layer.cornerRadius = 0;
             self.unCarryTableView.layer.cornerRadius = 0;
         }];
     }];
}

#pragma mark - 弹出unCarryView动画
- (void)switchUnCarryView
{
    typeof(self) __weak weak = self;
    self.transform = CGAffineTransformMakeScale(1, 1);
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0 initialSpringVelocity:0 options:0 animations:^{
        
        weak.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.finishTableView.layer.cornerRadius = 8;
        self.unFinishTableView.layer.cornerRadius = 8;
        self.assessTableView.layer.cornerRadius = 8;
        self.unCarryTableView.layer.cornerRadius = 8;
        sleep(0.6);
        
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.3 animations:^{
             self.unFinishView.alpha = 1;
             self.finishView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,UISCREEN_HEIGHT);
             self.unFinishView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,UISCREEN_HEIGHT);
             
             weak.transform = CGAffineTransformMakeScale(1, 1);
             
             self.assessView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0,UISCREEN_HEIGHT);
             self.unCarryView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -UISCREEN_HEIGHT);
             
             self.assessView.alpha = 1;
             self.unCarryView.alpha = 1;
             self.finishTableView.layer.cornerRadius = 0;
             self.unFinishTableView.layer.cornerRadius = 0;
             self.assessTableView.layer.cornerRadius = 0;
             self.unCarryTableView.layer.cornerRadius = 0;
         }];
     }];
}

@end

