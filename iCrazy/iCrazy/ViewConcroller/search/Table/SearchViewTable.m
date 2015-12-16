//
//  SearchViewTable.m
//  iCrazy
//
//  Created by Administrator on 15/10/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "SearchViewTable.h"
#import "Macro.h"
#import "Request.h"
#import "DorderViewController.h"
#import "UserInfoViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"

@implementation SearchViewTable

- (instancetype)initWithFrame:(CGRect)frame and:(NSString *)strId and:(NSArray *)userarr
{
    self = [super initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.frame = frame;
    
    self.orderarr = [[NSMutableArray alloc]init];
    
    self.c_userid = strId;
    self.userarr = userarr;
    
    if (self)
    {
        //底层View
        self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        self.showView.backgroundColor = [UIColor whiteColor];
        self.showView.alpha = 0.5;
        [self addSubview:self.showView];
        
        self.imageview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 64)];
        self.imageview.backgroundColor = COLORNAVIGATION;
        [self.showView addSubview:self.imageview];
        
        //searchbar 设置
        self.searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(5, 20, UISCREEN_WIDTH-60, 44)];
        self.searchbar.barStyle = UIBarStyleDefault;
        self.searchbar.barTintColor = COLORNAVIGATION;
        self.searchbar.translucent = YES;
        self.searchbar.layer.borderColor = COLORNAVIGATION.CGColor;
        self.searchbar.layer.borderWidth = 1;
        self.searchbar.backgroundImage = [UIImage imageNamed:@"lazy"];
        self.searchbar.delegate = self;
        self.searchbar.placeholder = @"输入您想做的事";
        
        //取消按钮
        self.cansebtn = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH-54, 28, 50, 28)];
        [self.cansebtn setTitle:@"取消" forState:UIControlStateNormal];
        self.cansebtn.layer.cornerRadius = 5;
        [self.cansebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.cansebtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.cansebtn.backgroundColor = [UIColor clearColor];
        
        [self.imageview addSubview:self.searchbar];
        [self.imageview addSubview:self.cansebtn];

        
        self.btn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, 74, 60, 20)];
        self.btn1.backgroundColor = COLORMAMP(75,195,210,0.8);
        self.btn1.titleLabel.font = [UIFont systemFontOfSize:12];
        self.btn1.layer.cornerRadius = 5;
        [self.btn1 setTitle:@"快递" forState:UIControlStateNormal];
        
        self.btn2 = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.25+15, 74, 60, 20)];
        self.btn2.backgroundColor = COLORMAMP(75,195,210,0.8);
        self.btn2.titleLabel.font = [UIFont systemFontOfSize:12];
        self.btn2.layer.cornerRadius = 5;
        [self.btn2 setTitle:@"兼职" forState:UIControlStateNormal];

        self.btn3 = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.5+15, 74, 60, 20)];
        self.btn3.backgroundColor = COLORMAMP(75,195,210,0.8);
        self.btn3.titleLabel.font = [UIFont systemFontOfSize:12];
        self.btn3.layer.cornerRadius = 5;
        [self.btn3 setTitle:@"外卖" forState:UIControlStateNormal];
        
        self.btn4 = [[UIButton alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*0.75+15, 74, 60, 20)];
        self.btn4.backgroundColor = COLORMAMP(75,195,210,0.8);
        self.btn4.titleLabel.font = [UIFont systemFontOfSize:12];
        self.btn4.layer.cornerRadius = 5;
        [self.btn4 setTitle:@"垃圾" forState:UIControlStateNormal];

        //tableview设置
        self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        self.table.backgroundColor = [UIColor clearColor];
        self.table.delegate = self;
        self.table.dataSource = self;
        
        [self addSubview:self.table];
        
        self.table.alpha = 0;
        
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        [self addSubview:self.btn3];
        [self addSubview:self.btn4];
        
        [self.btn1 addTarget:self action:@selector(searchbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn2 addTarget:self action:@selector(searchbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn3 addTarget:self action:@selector(searchbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn4 addTarget:self action:@selector(searchbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //未实名认证 提示框
        self.NotCertificationAlert = [[MyAlert alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-50, UISCREEN_HEIGHT/2-22.5, 100, 45) WithNameStr:@"请实名认证！"];
        
        //抢单成功提示
        self.rushSucceed = [[MyAlert alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-75, UISCREEN_HEIGHT/2-22.5, 150, 45) WithNameStr:@"被你抢到啦≧▽≦"];
        
        //抢单成功提示
        self.rushFail = [[MyAlert alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-75, UISCREEN_HEIGHT/2-22.5, 150, 45) WithNameStr:@"抢不到啦>_<"];
        
        //无订单提示
        self.noOrder = [[MyAlert alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH/2-100, UISCREEN_HEIGHT/2-22.5, 200, 45) WithNameStr:@"沒有此类订单哦(⊙o⊙)"];
        
    }
    
    //观察者
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(deleOrder:) name:@"searchOrder" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchSuccessedAlert) name:@"graporder" object:nil];
    return self;
}

- (void)searchSuccessedAlert{
    
    //抢单成功提示
    [self MyAlert:self.rushSucceed];
}

//删除Array中的元素
- (void)deleOrder:(NSNotification *)cation
{
    NSDictionary * orderDic = cation.object;
    
    for(int i=0;i<self.orderarr.count;i++)
    {
        NSDictionary * nsDic = [self.orderarr objectAtIndex:i];
        if([[nsDic objectForKey:@"orderid"] isEqualToString:[orderDic objectForKey:@"orderid"]])
        {
            [self.orderarr removeObjectAtIndex:i];        //删除
        }
        [self.table reloadData];          //刷新Table
    }
}

//cell的初始化
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.searchbar.text isEqualToString:@""])
    {
        return 0;
    }
    else
    {
        return self.orderarr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *str =@"cell";
        self.cell = [tableView dequeueReusableCellWithIdentifier:str];
    
        if (self.cell == nil)
        {
           self.cell = [[searchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        
        self.cell.messageLabel.text = [self.orderarr [indexPath.row] objectForKey:@"ordertitle"];
        self.cell.moneyLabel.text   = [NSString stringWithFormat:@"￥ %@",[self.orderarr [indexPath.row] objectForKey:@"orderprice"]];
        self.cell.chooseBut.tag     = indexPath.row ;
        self.cell.tag               = indexPath.row;
        
        NSString * strId = [self.orderarr [indexPath.row] objectForKey:@"l_user_userid"];
        
        for (NSDictionary *dicu in self.userarr)
        {
            NSString *useridu = [dicu objectForKey:@"l_user_userid"];
                
            if([strId isEqualToString:useridu])
            {
                    
                NSString * url = [NSString stringWithFormat:@"%@%@",LAZY_IMAGE_PATH,[dicu objectForKey:@"userimage"]];
                 
                [self.cell.userImg sd_setImageWithURL:[NSURL URLWithString:url]];
            }
        }
        
        [self.cell.chooseBut addTarget:self action:@selector(grap:) forControlEvents:UIControlEventTouchUpInside];
    
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    if (self.isCertification == YES) {
        
        self.cell.chooseBut.userInteractionEnabled = YES;
    }else{
        
        self.cell.chooseBut.userInteractionEnabled = NO;
    }
    
        return self.cell;
    
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CABasicAnimation *animation  = [CABasicAnimation animationWithKeyPath:@"position"];
    
    CGPoint toPoint = cell.layer.position;
    
    animation.duration = 0.3;
    
    if (self.isCellUpDown == YES) {
        
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x-200, toPoint.y)];
    }else{
        
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x+200, toPoint.y)];
    }
    
    if (indexPath.row == 0) {
        
        animation.duration = 0.1;
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x-300, toPoint.y)];
    }else if(indexPath.row == 1){
        
        animation.duration = 0.2;
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x-300, toPoint.y)];
    }else if(indexPath.row == 2){
        
        animation.duration = 0.4;
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x-300, toPoint.y)];
    }else if(indexPath.row == 3){
        
        animation.duration = 0.6;
        animation.fromValue = [NSValue valueWithCGPoint: CGPointMake(toPoint.x-300, toPoint.y)];
    }
    
    [cell.layer addAnimation:animation forKey:@"a"];
}

#pragma mark - 监听Table滑动
- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView{
    
    [self endEditing:YES];
    
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y< self.lastContentOffset )
    {
        self.isCellUpDown = YES;
        
    } else if (scrollView. contentOffset.y >self.lastContentOffset )
    {
        self.isCellUpDown = NO;
    }
}

#pragma mark - 无订单提示框
- (void)MyAlert:(MyAlert *)alert{

    [UIView animateWithDuration:1 animations:^{
        sleep(0.5);
        alert.alpha = 0.3;
        
        [self addSubview:alert];
        
    } completion:^(BOOL finished) {
        
        sleep(1);
        [UIView animateWithDuration:1 animations:^{
            
            alert.alpha = 0;
        }];
    }];
}

#pragma mark - 监听text change
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (![self.searchbar.text isEqualToString:@""])
    {
        //初始化加载圈圈
        self.isHUD = YES;
        
        self.progressHubView = [[MBProgressHUD alloc]initWithView:self];
        self.progressHubView.delegate = self;
        self.hubView.labelText = @"在路上...";
        [self addSubview:self.progressHubView];
        
        [self.progressHubView showWhileExecuting:@selector(searchBartextDidChange) onTarget:self withObject:nil animated:YES];
    }
    else
    {
        //无订单提示框
//        [self MyAlert:self.noOrder];
        
        NSLog(@"没有订单！");
        self.btn1.hidden =NO;
        self.btn2.hidden =NO;
        self.btn3.hidden =NO;
        self.btn4.hidden =NO;
        self.orderarr = nil;
        [self.table reloadData];
        self.table.alpha = 0;
    }
}

#pragma mark - 按钮点击事件
- (void)grap:(UIButton *)sender
{
    //初始化加载圈圈
    self.isHUD = YES;
    
    self.huButton.tag = sender.tag;
    
    self.hubView = [[MBProgressHUD alloc]initWithView:self];
    self.hubView.delegate = self;
    self.hubView.labelText = @"正在抢...";
    [self addSubview:self.hubView];
    
    [self.hubView showWhileExecuting:@selector(upLoad) onTarget:self withObject:nil animated:YES];
}

#pragma mark - 标签事件
- (void)searchbtn:(UIButton*)sender
{
    //初始化加载圈圈
    self.isHUD = YES;
    [self.searchbar endEditing:YES];
    self.strText = sender.titleLabel.text;
        
    self.ButHubView = [[MBProgressHUD alloc]initWithView:self];
    self.ButHubView.delegate = self;
    self.ButHubView.labelText = @"在路上...";
    [self addSubview:self.ButHubView];
        
    [self.ButHubView showWhileExecuting:@selector(searchClick) onTarget:self withObject:nil animated:YES];
}

- (void)searchBartextDidChange
{
    NSMutableArray * arr1 = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableDictionary *dic = [[NSMutableDictionary  alloc]init];
    [dic setValue:self.searchbar.text forKey:@"data"];
    
    //请求懒人端订单表的信息
    Request *request = [[Request alloc]init];
    [request querylazyorder:dic and:^(NSDictionary *dataOrderDic) {
        
        NSString *str= [dataOrderDic objectForKey:@"code"];
        
        if ([str isEqualToString:@"succeed"])
        {
            NSMutableArray *arr = [dataOrderDic objectForKey:@"value"];
            
            for (NSMutableDictionary *dic in arr)
            {
                if ([[dic objectForKey:@"orderstatus"] isEqualToString:@"2"])
                {
                    [arr1 addObject:dic];
                    
                    self.orderarr = arr1;
                    
                    NSLog(@".........%@",self.orderarr);
                    self.isHUD = NO;
                     self.table.alpha = 1;
                }
                else
                {
                    //无订单提示框
//                    [self MyAlert:self.noOrder];
                    self.isHUD = NO;
                    NSLog(@"没有此订单！！");
                    self.table.alpha = 0;
                }
                
            }
            self.table.alpha =1;
        }
        
        else{
            
            //无订单提示框
            [self MyAlert:self.noOrder];
            self.isHUD = NO;
            NSLog(@"没有此订单！！");
            self.table.alpha = 0;
        }
        if (self.orderarr.count ==0)
        {
            //无订单提示框
//            [self MyAlert:self.noOrder];
            self.isHUD = NO;
            self.btn1.hidden =NO;
            self.btn2.hidden =NO;
            self.btn3.hidden =NO;
            self.btn4.hidden =NO;
            NSLog(@"没有订单");
            self.table.alpha = 0;
        }
        else
        {
            self.isHUD = NO;
            self.btn1.hidden =YES;
            self.btn2.hidden =YES;
            self.btn3.hidden =YES;
            self.btn4.hidden =YES;
            self.table.alpha = 1;
        }
        
        [self.table reloadData];
       
    }];
    while (self.isHUD){}
}

//butoon的点击事件
-(void)upLoad
{

    NSLog(@"*************%@",self.orderarr);
    
    NSString *l_userid  = [self.orderarr[self.huButton.tag] objectForKey:@"l_user_userid"];
    NSString *orderid   = [self.orderarr[self.huButton.tag] objectForKey:@"orderid"];
    NSString *title     = [self.orderarr[self.huButton.tag] objectForKey:@"ordertitle"];
    NSString *price     = [self.orderarr[self.huButton.tag] objectForKey:@"orderprice"];
    NSString *insurance = [self.orderarr[self.huButton.tag] objectForKey:@"orderinsurance"];
    NSString *detail    = [self.orderarr[self.huButton.tag] objectForKey:@"orderdetail"];
    NSString *Remark    = [self.orderarr[self.huButton.tag] objectForKey:@"orderremark"];
    NSString *phone     = [self.orderarr[self.huButton.tag] objectForKey:@"orderphone"];
    
    NSDictionary *orderDica = [NSDictionary dictionaryWithObject:orderid forKey:@"orderid"];
    
    Request *request = [[Request alloc]init];
    
    [request queryorderid:orderDica and:^(NSDictionary *dataOrderDic) {
        
        NSString * strw = [dataOrderDic objectForKey:@"code"];
        
        NSArray * digArray = [dataOrderDic objectForKey:@"value"];
        
        NSDictionary * dig = [digArray firstObject];
        
        if ([strw isEqualToString:@"succeed"]) {

            if ([[dig objectForKey:@"orderstatus"] isEqualToString:@"2"]) {
                
                NSMutableDictionary *status = [[NSMutableDictionary alloc]init];
                [status setObject:l_userid forKey:@"userid"];
                [status setObject:orderid forKey:@"orderid"];
                [status setObject:@"-1" forKey:@"status"];
                
                [request alfterorder:status and:^(NSDictionary *dataDic) {
                    NSString *statusstr = [dataDic objectForKey:@"code"];
                    if ([statusstr isEqualToString:@"succeed"])
                    {
                        
                        NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
                        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                        NSString *currentTime = [formatter stringFromDate:[NSDate date]];
                        
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                        [dict setValue:orderid forKey:@"orderid"];
                        [dict setValue:self.c_userid forKey:@"userid"];
                        [dict setValue:title forKey:@"title"];
                        [dict setValue:@"-1" forKey:@"status"];
                        [dict setValue:price forKey:@"price"];
                        [dict setValue:currentTime forKey:@"time"];
                        [dict setValue:insurance forKey:@"insurance"];
                        [dict setValue:detail forKey:@"detail"];
                        [dict setValue:Remark forKey:@"remark"];
                        [dict setValue:phone forKey:@"phone"];
                        
                        [request insertorder:dict and:^(NSDictionary *dataDic)
                         {
                             NSString *insert = [dataDic objectForKey:@"code"];
                             
                             if ([insert isEqualToString:@"succeed"])
                             {
                                 NSLog(@"！！！！插入成功！！");
                                 
                                 //遍历数组，删除已经抢的订单
                                 for(int i=0;i<self.orderarr.count;i++)
                                 {
                                     NSDictionary * sdic = [self.orderarr objectAtIndex:i];
                                     NSString * ssorderid = [sdic objectForKey:@"orderid"];
                                     
                                     if([ssorderid isEqualToString:orderid])
                                     {
                                         [self.orderarr removeObjectAtIndex:i];
                                         //发通知(删除数组中的元素)(地图页面和搜索页面)
                                         NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
                                         [center postNotificationName:@"searchOrder" object:sdic];
                                         
                                         [self.table reloadData];
                                         self.isHUD = NO;
                                         self.table.alpha = 1;
                                         
                                         [self MyAlert:self.rushSucceed];
                                     }
                                 }
                            }
                             else
                             {
                                 self.isHUD = NO;
                             }
                         }];
                    }
                    else
                    {
                        //抢单失败提示
                        [self MyAlert:self.rushFail];
                        self.isHUD = NO;
                        NSLog(@"失败");
                    }
                }];
            }
            else
            {
                self.isHUD = NO;
            }
        }
        else
        {
            self.isHUD = NO;
        }
    }];
    while (self.isHUD){}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //清除点击阴影
    [self.table deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"666666");
    NSLog(@"789789789%@",self.userarr);
    
    //若未实名认证 则不能点击
    if (self.isCertification == NO) {
        
        [self MyAlert:self.NotCertificationAlert];
        
    }else{
    
        DorderViewController *detail = [[DorderViewController alloc]init];
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        
        
        NSDictionary *orderDic = [self.orderarr objectAtIndex:indexPath.row];
        
        [detail setValue:orderDic forKey:@"orderDic"];
        
        for(NSDictionary * userDic in self.userarr)        //用户信息
        {
            NSString *  userID = [userDic objectForKey:@"l_user_userid"];
            if([[orderDic objectForKey:@"l_user_userid"] isEqualToString:userID])
            {
                [detail setValue:userDic forKey:@"userDic"];
                [detail setValue:self.c_userid forKey:@"c_userid"];
            }
        }
        
        [app.rootNav pushViewController:detail animated:YES];
    }
}

- (void)searchClick
{
    if(![self.strText isEqualToString:@""])
    {
        self.searchbar.text = self.strText;
        
        NSMutableArray * arr1 = [[NSMutableArray alloc]initWithCapacity:0];
        NSMutableDictionary *dic = [[NSMutableDictionary  alloc]init];
        [dic setValue:self.searchbar.text forKey:@"data"];
        
        //请求懒人端订单表的信息
        Request *request = [[Request alloc]init];
        [request querylazyorder:dic and:^(NSDictionary *dataOrderDic) {
            
            NSString *str= [dataOrderDic objectForKey:@"code"];
            
            if ([str isEqualToString:@"succeed"])
            {
                NSMutableArray *arr = [dataOrderDic objectForKey:@"value"];
                
                for (NSMutableDictionary *dic in arr)
                {
                    if ([[dic objectForKey:@"orderstatus"] isEqualToString:@"2"])
                    {
                        [arr1 addObject:dic];
                        
                        self.orderarr = arr1;
                        self.isHUD = NO;
                        self.strText = nil;
                        self.table.alpha = 1;
                        NSLog(@".........%@",self.orderarr);
                    }
                    else
                    {
                        NSLog(@"没有此订单！！");
                        self.table.alpha = 0;
                        self.strText = nil;
                        self.isHUD = NO;
                    }
                    
                }
                self.table.alpha =1;
            }
            if (self.orderarr.count ==0)
            {
                self.isHUD = NO;
                self.btn1.hidden =NO;
                self.btn2.hidden =NO;
                self.btn3.hidden =NO;
                self.btn4.hidden =NO;
                NSLog(@"没有订单");
                self.table.alpha = 0;
                self.strText = nil;
                //无订单提示
                [self MyAlert:self.noOrder];
                
            }
            else
            {
                self.isHUD = NO;
                self.btn1.hidden =YES;
                self.btn2.hidden =YES;
                self.btn3.hidden =YES;
                self.btn4.hidden =YES;
                self.table.alpha = 1;
                self.strText = nil;
            }
            self.isHUD = NO;
            [self.table reloadData];
            
        }];
        while (self.isHUD){}

    }
    else
    {
    
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:NO];
}

@end
