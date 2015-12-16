//
//  PublishViewController.m
//  iLazy
//
//  Created by administrator on 15/9/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "PublishViewController.h"
#import "MyNavigation.h"
#import "MapViewController.h"
#import "Request.h"
#define VIEW_WIDTH self.moneyView.frame.size.width  //view的宽度
#define VIEW_HEIGHT self.moneyView.frame.size.height //view的高度

static NSString * useridStr;

@interface PublishViewController (){
    
    UIButton *doneButton;
    UIView *view;
}

@property (strong, nonatomic)UIImageView * backView;     //背景

@property (strong, nonatomic)UILabel *titleLabel;        //标题
@property (strong, nonatomic)UITextField *titleText;
@property (strong, nonatomic)UILabel *titleDownlin;

@property (strong, nonatomic)UILabel *phoneLabel;        //电话
@property (strong, nonatomic)UITextField *phoneText;
@property (strong, nonatomic)UILabel *phoneDownlin;

@property (strong, nonatomic)UILabel *priceLabel;        //价格
@property (strong, nonatomic)UITextField *priceText;

@property (strong, nonatomic)UILabel *insuranceLabel;    //保险
@property (strong, nonatomic)UILabel *baoxianLabel;
@property (strong, nonatomic)UIButton *insuranceBtn;

@property (strong, nonatomic)UILabel *remarkLabel;       //备注
@property (strong, nonatomic)UITextField *remarkText;
@property (strong, nonatomic)UILabel *remarkDownlin;

@property (strong, nonatomic)UILabel *detailLabel;       //详情
@property (strong, nonatomic)UITextField *detailText;

@property (strong, nonatomic)UIImageView *imageview;

@property (strong, nonatomic)UIView *publicView;
@property (strong, nonatomic)UIView *moneyView;
@property (strong, nonatomic)UIView *remarkView;
@property (strong, nonatomic)UIView *noticView;
@property (strong, nonatomic)UILabel *count;  //计时标签
@property (strong, nonatomic)UIButton *placebtn;  //提示文字按钮
@property (strong, nonatomic)UILabel *label1;    //
@property (strong, nonatomic)UILabel *label2;
@property (strong, nonatomic)UILabel *label3;
@property (strong, nonatomic)UILabel *label4;
@property (strong, nonatomic)UILabel *detailinsurance; // 保险详情

//承载View
@property (strong, nonatomic)UIView * showView;
@property (strong, nonatomic)UIView * textView;

//确定按钮
@property (strong, nonatomic)UIButton *ensurebtn;
//输入框
@property (strong, nonatomic)UITextView *detailTextView;

//单击手势
@property (strong, nonatomic)UITapGestureRecognizer * tap;

@property (strong, nonatomic)Request *request;

//接受懒人端登录的userid
@property (strong, nonatomic) NSString * l_userid;

@property (assign, nonatomic) BOOL isClack;

@property (strong, nonatomic) AFFNumericKeyboard *key;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isClack = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.imageview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.imageview.alpha = 0.8;
    [self.view addSubview:self.imageview];
    
    self.request = [[Request alloc]init];
    
    useridStr = self.l_userid;
    
    //自定义顶部导航
    [self mynavigation];
    
    //改变状态栏
    [self statusBar];
    
    
    //view设置
    [self publicview];
    [self detailview];
    [self remarkview];

    //标题
    [self titlelabel];
    
    //详情
    [self detaillabel];
    
    //联系人
    [self phonelabel];
    
    //价格
    [self pricelabel];
    
    //备注
    [self remarklabel];
    
    //保险
    [self insurancelabel];
    
    //必填标签
    [self nessary];
    
    //初始化手势
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(canceltopublic)];
    
    //承载View
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.showView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.showView];
    [self.showView addGestureRecognizer:self.tap];
    
    //Text下面的背景
    self.textView = [[UIView alloc]initWithFrame:CGRectMake(20, UISCREEN_HEIGHT/5, UISCREEN_WIDTH-40, UISCREEN_HEIGHT/3)];
    self.textView.backgroundColor = [UIColor whiteColor];
    [self.textView.layer setCornerRadius:6];
    self.textView.clipsToBounds = YES;
    [self.view addSubview:self.textView];
    
    //TextView
    self.detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(2, 2, self.textView.bounds.size.width-4, self.textView.bounds.size.height-42)];
    self.detailTextView.layer.cornerRadius = 5;
    self.detailTextView.delegate = self;
    self.detailTextView.textColor = [UIColor grayColor];
    self.detailTextView.font = [UIFont systemFontOfSize:15];
    [self.textView addSubview:self.detailTextView];
    
    //提示文字按钮
    self.placebtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.detailTextView.bounds.size.width, self.detailTextView.bounds.size.height)];
    [self.placebtn setTitle:@"私人信息，谨慎填写\n\n如有需要，电话联系" forState:UIControlStateNormal];
    self.placebtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.placebtn setTitleColor:COLORMAMP(210,210, 214, 1) forState:UIControlStateNormal];
    self.placebtn.titleLabel.numberOfLines = 0;
    [self.placebtn addTarget:self action:@selector(placeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.detailTextView addSubview:self.placebtn];
    
    //字数标签
    self.count = [[UILabel alloc]initWithFrame:CGRectMake(self.textView.bounds.size.width-55, self.detailTextView.bounds.size.height-25, 55, self.textView.bounds.size.height-self.detailTextView.bounds.size.height-20)];
    self.count.backgroundColor = [UIColor clearColor];
    self.count.font = [UIFont systemFontOfSize:12];
    [self.detailTextView addSubview:self.count];
    
    //确定按钮
    self.ensurebtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.detailTextView.bounds.size.height, self.textView.bounds.size.width, self.textView.bounds.size.height-self.detailTextView.bounds.size.height)];
    self.ensurebtn.backgroundColor = COLORNAVIGATION;
    [self.ensurebtn setTitle:@"确定" forState:UIControlStateNormal];
    self.ensurebtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.ensurebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.ensurebtn setShowsTouchWhenHighlighted:YES];
    [self.textView addSubview:self.ensurebtn];
    
    [self.ensurebtn addTarget:self action:@selector(ensuretopublic) forControlEvents:UIControlEventTouchUpInside];
    
    self.showView.alpha = 0;
    self.textView.alpha = 0;
    //缩小
    [UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.textView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)mynavigation{
    
    self.navigationController.navigationBarHidden = YES;      //隐藏默认导航条
    
    MyNavigation *myBar = [[MyNavigation alloc]initWithNavBgImg:@"" leftBtnBgImg:@"goBack" middleBtnBgImg:nil rightBtnImg:@"发布" titleStr:@"发布信息"];
    
    myBar.tag = 8888;
    //返回主界面
    
    [myBar.leftBut addTarget:self action:@selector(wentBack) forControlEvents:UIControlEventTouchUpInside];
   
    //发送按钮
    [myBar.rightBut addTarget:self action:@selector(goBackMAp) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:myBar];
}

#pragma mark - 改变状态栏
//改变状态栏背景色
- (void)statusBar{
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 20)];
    statusBarView.backgroundColor= COLORNAVIGATION;
    statusBarView.tag = 6666;
    
    [self.view addSubview:statusBarView];
    
}

//改变状态栏文字为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}

//发布与详情view 0.18;//102.24  (51.12=0.09)
-(void)publicview{
    
    self.publicView = [[UIView alloc]initWithFrame:CGRectMake(10, 10+64, UISCREEN_WIDTH-20, UISCREEN_HEIGHT*0.15)];
    self.publicView.backgroundColor = [UIColor whiteColor];
    self.publicView.layer.cornerRadius = 5;
    [self.view addSubview:self.publicView];
    
}

//联系电话和价格view
-(void)detailview{
    
    self.moneyView = [[UIView alloc]initWithFrame:CGRectMake(10, 10+64+UISCREEN_HEIGHT*0.15+1, UISCREEN_WIDTH-20, UISCREEN_HEIGHT*0.15)];
    self.moneyView.backgroundColor = [UIColor whiteColor];
    self.moneyView.layer.cornerRadius = 5;
    [self.view addSubview:self.moneyView];
}

//备注与保险view
-(void)remarkview{
    
    self.remarkView = [[UIView alloc]initWithFrame:CGRectMake(10, 10+64+UISCREEN_HEIGHT*0.30+2, UISCREEN_WIDTH-20, UISCREEN_HEIGHT*0.15)];
    self.remarkView.backgroundColor = [UIColor whiteColor];
    self.remarkView.layer.cornerRadius = 5;
    [self.view addSubview:self.remarkView];

}

//标题
-(void)titlelabel{
    //15  80
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.03, UISCREEN_HEIGHT*0.023,UISCREEN_WIDTH*0.16, UISCREEN_HEIGHT*0.038)];
    NSLog(@"%f",UISCREEN_HEIGHT);
    self.titleLabel.text = @"标   题 :";
    self.titleLabel.textColor = COLORMAMP(42, 54, 68, 1);
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.publicView addSubview: self.titleLabel];
    
    self.titleText = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.2, UISCREEN_HEIGHT*0.023+1, UISCREEN_WIDTH*0.62, UISCREEN_HEIGHT*0.038)];
    self.titleText.layer.borderColor = [UIColor whiteColor].CGColor;
    self.titleText.placeholder = @"如:到文星广场取快递";
    self.titleText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.titleText.textColor = COLORMAMP(42, 54, 68, 1);
    self.titleText.font = [UIFont systemFontOfSize:15];
    self.titleText.clearButtonMode =UITextFieldViewModeAlways;//清零
    [self.titleText setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.publicView addSubview:self.titleText];
    
    self.titleDownlin = [[UILabel alloc]initWithFrame:CGRectMake(0,UISCREEN_HEIGHT*0.15/2,UISCREEN_WIDTH-20,1)];
    self.titleDownlin.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.publicView addSubview:self.titleDownlin];
    
}

//详情
-(void)detaillabel{
    //15  80
    
    self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.03, UISCREEN_HEIGHT*0.023+UISCREEN_HEIGHT*0.15/2+1,UISCREEN_WIDTH*0.16, UISCREEN_HEIGHT*0.038)];
    self.detailLabel.backgroundColor = [UIColor whiteColor];
    self.detailLabel.text = @"详   情 :";
    self.detailLabel.textColor = COLORMAMP(42, 54, 68, 1);
    self.detailLabel.font = [UIFont systemFontOfSize:15];
    [self.publicView addSubview: self.detailLabel];
    
    self.detailText = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.2, UISCREEN_HEIGHT*0.023+UISCREEN_HEIGHT*0.15/2+1+1, UISCREEN_WIDTH*0.63, UISCREEN_HEIGHT*0.038)];
    self.detailText.layer.borderColor = [UIColor whiteColor].CGColor;
    self.detailText.backgroundColor = [UIColor whiteColor];
    self.detailText.delegate = self;
    self.detailText.textAlignment = NSTextAlignmentLeft;
    self.detailText.placeholder = @"说明一下订单的详细信息";
    self.detailText.font = [UIFont systemFontOfSize:12.0];
    self.detailText.textColor = COLORMAMP(42, 54, 68, 1);
    self.detailText.font = [UIFont systemFontOfSize:15];
    [self.detailText setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.publicView addSubview:self.detailText];
    
}

//电话号码
-(void)phonelabel{
    //15  80
    
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.03, UISCREEN_HEIGHT*0.023, UISCREEN_WIDTH*0.16, UISCREEN_HEIGHT*0.038)];
    self.phoneLabel.text = @"电   话 :";
    self.phoneLabel.textColor = COLORMAMP(42, 54, 68, 1);
    self.phoneLabel.font = [UIFont systemFontOfSize:15];
    [self.moneyView addSubview: self.phoneLabel];
    
    self.phoneText = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.2, UISCREEN_HEIGHT*0.023+1, UISCREEN_WIDTH*0.62, UISCREEN_HEIGHT*0.038)];
    self.phoneText.layer.borderColor = [UIColor whiteColor].CGColor;
    self.phoneText.backgroundColor = [UIColor whiteColor];
    self.phoneText.placeholder = @"联系电话";
    self.phoneText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.phoneText.textColor = COLORMAMP(42, 54, 68, 1);
    self.phoneText.font = [UIFont systemFontOfSize:15];
    self.phoneText.clearButtonMode =UITextFieldViewModeAlways;//清零
    
    self.phoneText.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.phoneText setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.moneyView addSubview:self.phoneText];
    self.phoneDownlin = [[UILabel alloc]initWithFrame:CGRectMake(0,UISCREEN_HEIGHT*0.15/2,UISCREEN_WIDTH-20,1)];
    self.phoneDownlin.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.moneyView addSubview:self.phoneDownlin];
    
}

//酬劳
-(void)pricelabel{
    
    self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.03, UISCREEN_HEIGHT*0.023+UISCREEN_HEIGHT*0.15/2+1,UISCREEN_WIDTH*0.16, UISCREEN_HEIGHT*0.038)];
    
    self.priceLabel.text = @"酬   劳 :";
    self.priceLabel.textColor = COLORMAMP(42, 54, 68, 1);
    self.priceLabel.font = [UIFont systemFontOfSize:15];
    [self.moneyView addSubview: self.priceLabel];

    self.priceText = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.2, UISCREEN_HEIGHT*0.023+UISCREEN_HEIGHT*0.15/2+1+2, UISCREEN_WIDTH*0.62, UISCREEN_HEIGHT*0.038)];
    self.priceText.clearButtonMode =UITextFieldViewModeAlways;//清零
    self.priceText.layer.borderColor = [UIColor whiteColor].CGColor;
    self.priceText.backgroundColor = [UIColor whiteColor];
    self.priceText.textAlignment = NSTextAlignmentLeft;
    self.priceText.textColor = COLORMAMP(42, 54, 68, 1);
    self.priceText.font = [UIFont systemFontOfSize:15];
    self.priceText.placeholder = @"输入金额(元)";
    
    //数字键盘
    self.key = [[AFFNumericKeyboard alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
    self.priceText.inputView = self.key;
    self.key.delegate = self;
    
//    self.priceText.keyboardType = UIKeyboardTypeNumberPad;
    [self.priceText setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.moneyView addSubview:self.priceText];
}

-(void)numberKeyboardBackspace
{
    if (self.priceText.text.length != 0)
    {
        self.priceText.text = [self.priceText.text substringToIndex:self.priceText.text.length -1];
    }
}

-(void)numberKeyboardInput:(NSString *)number
{
    self.priceText.text = [self.priceText.text stringByAppendingString:number];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.priceText resignFirstResponder];
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = doneButton.frame;
        rect.origin.y += 53*5;
        doneButton.frame = rect;
        
    }];
}

//必须标签
-(void)nessary{
    
    self.label1 = [[UILabel alloc]initWithFrame:CGRectMake(self.publicView.frame.size.width-UISCREEN_WIDTH*0.11-10, UISCREEN_HEIGHT*0.023, UISCREEN_WIDTH*0.11, UISCREEN_HEIGHT*0.038)];
    self.label1.text = @"*必填";
    self.label1.textAlignment = NSTextAlignmentRight;
    self.label1.font = [UIFont systemFontOfSize:14];
    self.label1.textColor = COLORMAMP(210,210, 214, 1);
    [self.publicView addSubview:self.label1];
    
    self.label2 = [[UILabel alloc]initWithFrame:CGRectMake(self.publicView.frame.size.width-UISCREEN_WIDTH*0.11-10, UISCREEN_HEIGHT*0.023+UISCREEN_HEIGHT*0.15/2, UISCREEN_WIDTH*0.11, UISCREEN_HEIGHT*0.038)];
    self.label2.text = @"*必填";
    self.label2.textAlignment = NSTextAlignmentRight;
    self.label2.font = [UIFont systemFontOfSize:14];
    self.label2.textColor = COLORMAMP(210,210, 214, 1);
    [self.publicView addSubview:self.label2];
    
    self.label3 = [[UILabel alloc]initWithFrame:CGRectMake(self.publicView.frame.size.width-UISCREEN_WIDTH*0.11-10, UISCREEN_HEIGHT*0.023, UISCREEN_WIDTH*0.11, UISCREEN_HEIGHT*0.038)];
    self.label3.text = @"*必填";
    self.label3.textAlignment = NSTextAlignmentRight;
    self.label3.font = [UIFont systemFontOfSize:14];
    self.label3.textColor = COLORMAMP(210,210, 214, 1);
    [self.moneyView addSubview:self.label3];
    
    self.label4 = [[UILabel alloc]initWithFrame:CGRectMake(self.publicView.frame.size.width-UISCREEN_WIDTH*0.11-10, UISCREEN_HEIGHT*0.023+UISCREEN_HEIGHT*0.15/2, UISCREEN_WIDTH*0.11, UISCREEN_HEIGHT*0.038)];
    self.label4.text = @"*必填";
    self.label4.textAlignment = NSTextAlignmentRight;
    self.label4.font = [UIFont systemFontOfSize:14];
    self.label4.textColor = COLORMAMP(210,210, 214, 1);
    [self.moneyView addSubview:self.label4];
}

//备注
-(void)remarklabel{
    
    self.remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.03, UISCREEN_HEIGHT*0.023, UISCREEN_WIDTH*0.16, UISCREEN_HEIGHT*0.038)];
    self.remarkLabel.text = @"备   注 :";
    self.remarkLabel.textColor = COLORMAMP(42, 54, 68, 1);
    self.remarkLabel.font = [UIFont systemFontOfSize:15];
    [self.remarkView addSubview: self.remarkLabel];
    
    self.remarkText = [[UITextField alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.2, UISCREEN_HEIGHT*0.023+1, UISCREEN_WIDTH*0.62, UISCREEN_HEIGHT*0.038)];
    self.remarkText.layer.borderColor = [UIColor whiteColor].CGColor;
    self.remarkText.placeholder = @"如:贵重物品,易碎等... ";
    self.remarkText.backgroundColor = [UIColor whiteColor];
    self.remarkText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.remarkText.textColor = COLORMAMP(42, 54, 68, 1);
    self.remarkText.font = [UIFont systemFontOfSize:15];
    self.remarkText.clearButtonMode =UITextFieldViewModeAlways;//清零
    [self.remarkText setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [self.remarkView addSubview:self.remarkText];
    
    self.remarkDownlin = [[UILabel alloc]initWithFrame:CGRectMake(0,UISCREEN_HEIGHT*0.15/2,UISCREEN_WIDTH-20,1)];
    self.remarkDownlin.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.remarkView addSubview:self.remarkDownlin];
}

//保险
-(void)insurancelabel{
    //15  80
    
    self.insuranceLabel = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.03, UISCREEN_HEIGHT*0.022+UISCREEN_HEIGHT*0.15/2,UISCREEN_WIDTH*0.16, UISCREEN_HEIGHT*0.038)];
    self.insuranceLabel.text = @"保   险 :";
    self.insuranceLabel.textColor = COLORMAMP(42, 54, 68, 1);
    self.insuranceLabel.font = [UIFont systemFontOfSize:15];
    [self.remarkView addSubview: self.insuranceLabel];
    
    self.insuranceBtn = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.2, UISCREEN_HEIGHT*0.026+UISCREEN_HEIGHT*0.15/2, 20, 20)];
    self.insuranceBtn.layer.cornerRadius = 5;
    self.insuranceBtn.layer.borderWidth = 1;
    self.insuranceBtn.clipsToBounds = YES;
    self.insuranceBtn.tag = 0;            //默认没买
    self.insuranceBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.insuranceBtn.backgroundColor = [UIColor whiteColor];
    [self.insuranceBtn setImage:[UIImage imageNamed:@"baoxian-0"] forState:UIControlStateNormal];
    [self.insuranceBtn addTarget:self action:@selector(toChoose:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.remarkView addSubview:self.insuranceBtn];
    
    //保险说明
    self.detailinsurance = [[UILabel alloc]initWithFrame:CGRectMake(20, 64+10+10+self.publicView.bounds.size.height+self.moneyView.bounds.size.height+self.remarkView.bounds.size.height,self.view.bounds.size.width-40, 20)];
    self.detailinsurance.textAlignment = NSTextAlignmentRight;
    self.detailinsurance.font = [UIFont systemFontOfSize:12];
    self.detailinsurance.textColor = [UIColor grayColor];
    self.detailinsurance.alpha = 0.6;
    self.detailinsurance.text = @"* 保险一元,为您的订单保驾护航";
    [self.view addSubview:self.detailinsurance];
}

//选择保险按钮
- (void)toChoose:(UIButton *)sender{
    if(sender.tag == 1){          //未买
        [sender setImage:[UIImage imageNamed:@"baoxian-0"] forState:UIControlStateNormal];
        sender.tag = 0;
    }
    else if(sender.tag == 0)        //买了
    {
        [sender setImage:[UIImage imageNamed:@"baoxian-1"] forState:UIControlStateNormal];
        sender.tag = 1;
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.view.frame = CGRectMake(0, 0,UISCREEN_WIDTH, UISCREEN_HEIGHT);
    [self.view viewWithTag:8888].frame = CGRectMake(0, 0, UISCREEN_WIDTH, 44);
    [self.view bringSubviewToFront:[self.view viewWithTag:1]];
    
    [self.view viewWithTag:6666].frame = CGRectMake(0, 0, UISCREEN_WIDTH, 20);
    [self.view bringSubviewToFront: [self.view viewWithTag:2]];
    
    //初始化蒙层输入
    [self initMengCeng];
    
    return NO;
}

#pragma mark - 初始化蒙层
- (void)initMengCeng
{
    //放大
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.showView.alpha = 0.5;
        self.textView.alpha = 1;
        self.textView.transform = CGAffineTransformMakeScale(1, 1);
        self.detailTextView.text = self.detailText.text;
       
    } completion:^(BOOL finished) {
        
    }];
}

-(void)canceltopublic{
    
    //缩小
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.textView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.showView.alpha = 0;
        self.textView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
    }];
    
    NSLog(@"3333");
}

-(void)ensuretopublic
{
    //缩小
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        self.textView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        self.detailText.text = self.detailTextView.text;
        self.showView.alpha = 0;
        self.textView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
    }];
}


-(void)wentBack{
    
   [self.navigationController popViewControllerAnimated:YES];
}

-(void)goBackMAp{
    
    if(self.isClack)
    {
        self.isClack = NO;
        if(![self.titleText.text isEqualToString:@""] && ![self.detailText.text isEqualToString:@""] && ![self.phoneText.text isEqualToString:@""] && ![self.priceText.text isEqualToString:@""]){
            
            NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *currentTime = [formatter stringFromDate:[NSDate date]];
            
            NSMutableDictionary * orderDic = [[NSMutableDictionary  alloc]init];
            
            [orderDic setValue:useridStr forKey:@"userid"];
            [orderDic setValue:self.titleText.text forKey:@"title"];
            [orderDic setValue:@"2" forKey:@"status"];
            [orderDic setValue:self.priceText.text  forKey:@"price"];
            [orderDic setValue:currentTime  forKey:@"time"];
            [orderDic setValue:self.detailText.text forKey:@"detail"];
            [orderDic setValue:self.phoneText.text forKey:@"phone"];
            [orderDic setValue:self.remarkText.text  forKey:@"remark"];
            [orderDic setValue:[NSString stringWithFormat:@"%ld",(long)self.insuranceBtn.tag] forKey:@"insurance"];
            
            NSLog(@"*******************%@",orderDic);
            
            [self.request insertOrder:orderDic and:^(NSDictionary *dataDic) {
                
                NSString *str = [dataDic objectForKey:@"code"];
                
                if ([str isEqualToString:@"succeed"]) {
                    NSLog(@"插入成功");
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"发布成功！" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alert addAction:okAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    self.isClack = YES;
                }
                else{
                    
                    NSLog(@"插入失败");
                    
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"发布失败，请稍后再发" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:okAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    self.isClack = YES;
                }
            }];
        }
        
        else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写必填选项" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            self.isClack = YES;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self.titleText becomeFirstResponder];
}

//字数限制
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>160)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已输入160个字" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.ensurebtn.userInteractionEnabled = NO;
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    else
    {
        return YES;
    }
}

//字数显示倒计时
- (void)textViewDidChange:(UITextView *)textView{
    
    long int count;
    count = 160 - self.detailTextView.text.length;
    [self.count setText:[NSString stringWithFormat:@"%ld/160", count]];  //_wordCount是一个显示剩余可输入数字的label
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([self.detailTextView.text isEqualToString:@""]) {
        
        self.placebtn.hidden = NO;
    }
}

- (void)placeClick
{
   [UIView animateWithDuration:0.5 animations:^{
       
       self.placebtn.hidden = YES;
       [self.detailTextView becomeFirstResponder];      //获得焦点
   }];
}

@end
