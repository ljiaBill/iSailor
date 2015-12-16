//
//  AlartViewController.m
//  iLazy
//
//  Created by Administrator on 15/9/25.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "AlartViewController.h"
#import "Macro.h"

@interface AlartViewController ()

@property (strong, nonatomic)UIView * rootView;

@property (strong, nonatomic)UIView * titleHolder;

@property (strong, nonatomic)UILabel * titleLabel;

@property (strong, nonatomic)UIView * positiveView;

@property (strong, nonatomic)UIView * negativeView;

//两条线
@property (strong, nonatomic)UILabel * crossLable;
@property (strong, nonatomic)UILabel * erectLable;

//数据展示
@property (strong, nonatomic)NSString * lelfStr;
@property (strong, nonatomic)NSString * rightStr;
@property (strong, nonatomic)NSString * titleStr;
@property (strong, nonatomic)NSString * pointStr;

//标识
@property (assign, nonatomic)BOOL isClick;     //两种模式

@end

@implementation AlartViewController

#pragma mark - 初始化方法
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - 传递参数
- (void)deliverInfoLelf:(NSString *)lelf andRight:(NSString *)right andTitle:(NSString *)title andPoint:(NSString *)point andStatus:(BOOL)isClick
{
    self.lelfStr = lelf;
    self.rightStr = right;
    self.titleStr = title;
    self.pointStr = point;
    self.isClick = isClick;
}

#pragma mark - 设计界面排版
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //背景色
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];

    //最底层的view(起始位置)
    self.rootView = [[UIView alloc] initWithFrame:CGRectMake(45, -40, UISCREEN_WIDTH-90, UISCREEN_HEIGHT/4.5)];
    [self.rootView setBackgroundColor:[UIColor clearColor]];
    [self.rootView.layer setCornerRadius:8];
    self.rootView.clipsToBounds = YES;                 //适应它的形状
    [self.view addSubview:self.rootView];
    
    //显示文字的view
    self.titleHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.rootView.frame.size.width, self.rootView.frame.size.height*2/3)];
    [self.titleHolder setBackgroundColor:[UIColor whiteColor]];
    [self.rootView addSubview:self.titleHolder];
    self.titleHolder.alpha = 0.8;
    
    //文字
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.rootView.frame.size.width, self.rootView.frame.size.height*2/3)];
    [self.titleLabel setText:self.titleStr];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setTextColor:COLORNAVIGATION];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.titleHolder addSubview:self.titleLabel];
    
    //左边按钮(取消)
    self.positiveView = [[UIView alloc] init];
    [self.positiveView setFrame:CGRectMake(0, self.rootView.frame.size.height/3+self.rootView.frame.size.height/6, self.rootView.frame.size.width/2, self.rootView.frame.size.height/3)];
    [self.positiveView.layer setAnchorPoint:CGPointMake(0.5, 1)];
    [self.positiveView setBackgroundColor:[UIColor whiteColor]];
    self.positiveView.alpha = 0.8;
    
    //左边按钮文字
    UILabel *positiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.rootView.frame.size.width/2, self.rootView.frame.size.height/3)];
    positiveLabel.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    [positiveLabel setText:self.lelfStr];
    [positiveLabel setTextAlignment:NSTextAlignmentCenter];
    positiveLabel.font = [UIFont systemFontOfSize:15];
    [positiveLabel setTextColor:COLORNAVIGATION];
    [self.positiveView addSubview:positiveLabel];
    
    //右边按钮(确定)
    self.negativeView = [[UIView alloc] init];
    [self.negativeView setFrame:CGRectMake(self.rootView.frame.size.width/2, self.rootView.frame.size.height/3+self.rootView.frame.size.height/6, self.rootView.frame.size.width/2, self.rootView.frame.size.height/3)];
    [self.negativeView.layer setAnchorPoint:CGPointMake(0.5, 1)];
    [self.negativeView setBackgroundColor:[UIColor whiteColor]];
    self.negativeView.alpha = 0.8;
    
    //右边按钮文字
    UILabel *negativeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.rootView.frame.size.width/2, self.rootView.frame.size.height/3)];
    negativeLabel.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    [negativeLabel setText:self.rightStr];
    [negativeLabel setTextAlignment:NSTextAlignmentCenter];
    [negativeLabel setTextColor:COLORNAVIGATION];
    negativeLabel.font = [UIFont systemFontOfSize:15];
    [self.negativeView addSubview:negativeLabel];
    [self.rootView addSubview:self.negativeView];
    
    [self.rootView addSubview:_positiveView];
    //两条线
    self.erectLable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.rootView.frame.size.height-self.rootView.frame.size.height/3, self.rootView.frame.size.width, 1)];
    self.erectLable.backgroundColor = COLORNAVIGATION;
    [self.rootView addSubview:self.erectLable];
    
    self.crossLable = [[UILabel alloc]initWithFrame:CGRectMake(self.positiveView.frame.size.width, 0, 2, self.negativeView.frame.size.height)];
    self.crossLable.backgroundColor = COLORNAVIGATION;
    [self.positiveView addSubview:self.crossLable];
    
    self.erectLable.alpha = 0;
    self.crossLable.alpha = 0;
    
    self.positiveView.alpha = 0;
    self.negativeView.alpha = 0;
    
    //添加手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nagetiveAction:)];
    [self.view addGestureRecognizer:gesture];
}

#pragma mark - 添加到某个view中去(展示)
- (void)showView:(UIView *)targetView
{
    [targetView addSubview:self.view];
}

#pragma mark - 初始化对话框，并展示
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.isClick)
    {
        [UIView animateWithDuration:0.25 animations:^{
            [self.rootView setFrame:CGRectMake(self.rootView.frame.origin.x, 200, self.rootView.frame.size.width, self.rootView.frame.size.height)];
        }];
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            [self.rootView setFrame:CGRectMake(self.rootView.frame.origin.x, UISCREEN_HEIGHT/2-self.rootView.frame.size.height/2-20, self.rootView.frame.size.width, self.rootView.frame.size.height)];
        }];
    }
    
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    [animation setDelegate:self];
    animation.values = @[@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(0)];
    animation.duration = 0.5;
    [animation setKeyPath:@"transform.rotation"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.rootView.layer addAnimation:animation forKey:@"shake"];     //展示
    
}

#pragma mark - 控制按钮的出现和消失以及文字的变化
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag == YES)
    {
        //弹出“取消”按钮
        if ([anim isEqual:[self.rootView.layer animationForKey:@"shake"]])
        {
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200) ;
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            [animation setDelegate:self];
            animation.keyPath = @"transform";
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            animation.duration = 0.25;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [self.positiveView.layer addAnimation:animation forKey:@"rotate"];
            
            
            [UIView animateWithDuration:0.2 animations:^{
                self.positiveView.alpha = 0.8;
                self.negativeView.alpha = 0.8;
                self.erectLable.alpha = 0.7;
                self.crossLable.alpha = 0.7;
            }];
        }
        
        //弹出“确定”按钮
        else if([anim isEqual:[self.positiveView.layer animationForKey:@"rotate"]])
        {
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200) ;
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            [animation setDelegate:self];
            animation.keyPath = @"transform";
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            animation.duration = 0.25;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [self.negativeView.layer addAnimation:animation forKey:@"rotate2"];
        
        }
        
        //改变文字
        else if([anim isEqual:[self.rootView.layer animationForKey:@"close"]])
        {

            CATransform3D transFrom = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200);
            CATransform3D trans = CATransform3DIdentity ;
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            [animation setDelegate:self];
            animation.keyPath = @"transform";
            animation.fromValue = [NSValue valueWithCATransform3D:transFrom];
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            animation.duration = 0.25;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [self.negativeView.layer addAnimation:animation forKey:@"rotate"];
            [self performSelector:@selector(cancelAction) withObject:self afterDelay:1];
            
            [self.titleLabel setText:self.pointStr];
            
            self.crossLable.alpha = 0;
            self.positiveView.alpha = 0;
            self.negativeView.alpha = 0;
            
        }
    }
}

#pragma mark - 动作
CA_EXTERN CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CA_EXTERN CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}

#pragma mark - 移除Alart包括这个控制器和视图
- (void)cancelAction
{
    [UIView animateWithDuration:0.5 animations:^{
        
        [self.rootView setFrame:CGRectMake(self.rootView.frame.origin.x, 550, self.rootView.frame.size.width, self.rootView.frame.size.height)];      //移动rootView到界面外
        
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];          //移除self.view(视图)
        [self removeFromParentViewController];    //移除self(控制器)
    }];
}

#pragma mark -点击事件,
- (void)nagetiveAction:(UIGestureRecognizer*) gesture
{
    CGPoint touchPoint = [gesture locationInView:self.rootView];
    //点击右边的确定事件
    if ([self.negativeView.layer.presentationLayer hitTest:touchPoint])
    {
        [self.delegate positiveButtonAction];

        //左右翻滚
        CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 0, 1, 0), CGPointMake(0, 0), 200) ;
        CABasicAnimation *animation = [[CABasicAnimation alloc] init];
        [animation setDelegate:self];
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:trans];
        animation.duration = 0.5;
        animation.removedOnCompletion = NO;
        [self.rootView.layer addAnimation:animation forKey:@"close"];

    }
    
    //点击左边的取消事件
    else if([self.positiveView.layer.presentationLayer hitTest:touchPoint])
    {
        CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 0, 1, 0), CGPointMake(0, 0), 200) ;
        CABasicAnimation *animation = [[CABasicAnimation alloc] init];
        [animation setDelegate:self];
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:trans];
        animation.duration = 0.5;
        animation.removedOnCompletion = NO;
        [self.rootView.layer addAnimation:animation forKey:@"rotate"];
        
        [self.delegate negativeButtonAction];
        [self cancelAction];
    }
}

@end
