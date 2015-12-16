//
//  AssessViewTableView.m
//  iLazy
//
//  Created by Administrator on 15/9/24.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "AssessViewTableView.h"
#import "AppDelegate.h"
#import "AssessViewController.h"
#import "AssessViewTableView.h"
#import "UIButton+WebCache.h"

@implementation AssessViewTableView

#pragma mark - 初始化方法
- (instancetype)initWithTableView:(CGRect)frame
{
    
    self = [super initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    if(self)
    {
        
        self.showView = [[UIView alloc]initWithFrame:CGRectMake(0,0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        
        self.orderInfoArray = [NSMutableArray array];
        
        self.userInfoArray = [NSMutableArray array];

        self.showView.backgroundColor = [UIColor groupTableViewBackgroundColor];

        [self addSubview:self.showView];

    }
    
    //观察者
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(reloadTable:) name:@"alterStatus" object:nil];
    [center addObserver:self selector:@selector(commentReload:) name:@"alterComment" object:nil];
    
    self.isClick = YES;
    return self;
}

#pragma mark - 收到通知后所做的事情
- (void)reloadTable:(NSNotification *)cation
{
    NSDictionary * orderDic = cation.object;
    
    NSString * userid = [orderDic objectForKey:@"c_user_userid"];
    NSString * orderdetail = [orderDic objectForKey:@"orderdetail"];
    NSString * orderid = [orderDic objectForKey:@"l_order_orderid"];
    NSString * orderinsurance = [orderDic objectForKey:@"orderinsurance"];
    NSString * orderprice = [orderDic objectForKey:@"orderprice"];
    NSString * orderremark = [orderDic objectForKey:@"orderremark"];
    NSString * ordertime = [orderDic objectForKey:@"ordertime"];
    NSString * ordertitle = [orderDic objectForKey:@"ordertitle"];
    
    NSDictionary * rightDic = [NSDictionary dictionaryWithObjectsAndKeys:
                               userid,         @"c_user_userid",
                               orderdetail,    @"orderdetail",
                               orderid,        @"l_order_orderid",
                               orderinsurance, @"orderinsurance",
                               orderprice,     @"orderprice",
                               orderremark,    @"orderremark",
                               @"1",           @"orderstatus",
                               ordertime,      @"ordertime",
                               ordertitle,     @"ordertitle"
                               , nil];
    
//    [self.orderInfoArray addObject:rightDic];        //添加元素
    [self.orderInfoArray insertObject:rightDic atIndex:0];      //在第一个位置插入元素
    
    [self.table reloadData];          //刷新Table
}
- (void)commentReload:(NSNotification *)cation
{
    NSDictionary * orderDic = cation.object;
    for(int i=0;i<self.orderInfoArray.count;i++)
    {
        NSDictionary * nsDic = [self.orderInfoArray objectAtIndex:i];
        if([[nsDic objectForKey:@"l_order_orderid"] isEqualToString:[orderDic objectForKey:@"l_order_orderid"]])
        {
            [self.orderInfoArray removeObjectAtIndex:i];        //删除
        }
        [self.table reloadData];          //刷新Table
    }
}

#pragma mark - 取值返回的信息
- (void)getOrderData:(NSArray *)orderInfoArray and:(NSArray *)userInfoArray and:(NSArray *)orderAllInfoArray and:(NSString *)userid
{
    self.l_userid = userid;
    
    if(orderInfoArray.count == 0 || userInfoArray.count == 0 || orderAllInfoArray.count == 0)
    {
        [self notOrder];
    }
    else
    {
        NSMutableArray * array = [NSMutableArray array];
        
        for(NSDictionary * dic in orderInfoArray)        //得到需要展示出来的订单
        {
            for(NSDictionary * asDic in orderAllInfoArray)
            {
                NSString * idOne = [dic objectForKey:@"orderid"];
                NSString * idTwo = [asDic objectForKey:@"l_order_orderid"];
                if([idOne isEqualToString:idTwo])
                    //待评价
                {
                    [array addObject:asDic];
                }
            }
        }
        
        for(NSDictionary * dic in array)
        {
            if([[dic objectForKey:@"orderstatus"] isEqualToString:@"1"])
            {
                [self.orderInfoArray addObject:dic];
            }
        }
        
        for(NSDictionary * asDic in userInfoArray)
        {
            [self.userInfoArray addObject:asDic];
        }
        
        if(self.orderInfoArray.count == 0)
        {
            [self notOrder];
        }
        else
        {
            self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT-94) style:UITableViewStylePlain];
            
            self.table.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            self.table.delegate = self;
            self.table.dataSource = self;
            
            [self.showView addSubview:self.table];
        }
    }
}

#pragma mark - 没有该订单时候的图片
- (void)notOrder
{
    self.notInfoBut = [[UIButton alloc]initWithFrame:CGRectMake(50, UISCREEN_WIDTH/2-UISCREEN_HEIGHT/10, UISCREEN_WIDTH-100, UISCREEN_HEIGHT/3.5)];
    [self.notInfoBut setImage:[UIImage imageNamed:@"jiazaishibai_2"] forState:UIControlStateNormal];
    [self.notInfoBut.layer setCornerRadius:8];
    self.isTime = 2;
    //每隔一段时间执行一次方法
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(autoimg) userInfo:nil repeats:YES];
    [self addSubview:self.notInfoBut];
    
    UIView * viewPoint = [[UIView alloc]initWithFrame:CGRectMake(50, UISCREEN_WIDTH/2-UISCREEN_HEIGHT/10, UISCREEN_WIDTH-100, UISCREEN_HEIGHT/3.5)];
    viewPoint.backgroundColor = [UIColor clearColor];
    viewPoint.alpha = 0.4;
    [self addSubview:viewPoint];
    
    UILabel * point = [[UILabel alloc]initWithFrame:CGRectMake(50, UISCREEN_WIDTH/2-UISCREEN_HEIGHT/10+UISCREEN_HEIGHT/4, UISCREEN_WIDTH-100, 40)];
    
    point.textAlignment = NSTextAlignmentCenter;
    point.text = @"---您还没有相关订单---";
    point.textColor = COLORNAVIGATION;
    point.font = [UIFont systemFontOfSize:15];
    [self addSubview:point];
}

#pragma mark - 加载失败后的事件(走起来)
- (void)autoimg
{
    if(self.isTime == 1)
    {
       [self.notInfoBut setImage:[UIImage imageNamed:@"jiazaishibai_1"] forState:UIControlStateNormal];
        self.isTime = 3;
    }
    else if(self.isTime == 2)
    {
       [self.notInfoBut setImage:[UIImage imageNamed:@"jiazaishibai_2"] forState:UIControlStateNormal];
        self.isTime = 1;
    }
    else if(self.isTime == 3)
    {
        [self.notInfoBut setImage:[UIImage imageNamed:@"jiazaishibai_2"] forState:UIControlStateNormal];
        self.isTime = 4;
    }
    else if(self.isTime == 4)
    {
        [self.notInfoBut setImage:[UIImage imageNamed:@"jiazaishibai_3"] forState:UIControlStateNormal];
        self.isTime = 2;
    }
}

#pragma mark - 代理方法
#pragma mark -- 分组数目
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -- 每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderInfoArray.count;
}

#pragma mark -- cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

#pragma mark -- 初始化内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"cell";
    
    MyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil)
    {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    //去线
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;

    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    for(int i=0;i<self.orderInfoArray.count; i++)
    {
        NSDictionary * dic = [self.orderInfoArray objectAtIndex:indexPath.row];
        
        NSDictionary * orderDic = [self.orderInfoArray objectAtIndex:indexPath.row];
        NSString * orderID = [orderDic objectForKey:@"c_user_userid"];
        
        for(NSDictionary * userDic in self.userInfoArray)
        {
            NSString *  userID = [userDic objectForKey:@"c_user_userid"];
            if([orderID isEqualToString:userID])
            {
                cell.nameLabel.text = [userDic objectForKey:@"usernick"];
                
                //同步获取网络图片
                NSString * url = [NSString stringWithFormat:@"%@%@",CRAZY_IMAGE_PATH,[userDic objectForKey:@"userimage"]];
//                self.internetImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
                //异步获取图片
                [cell.imgBut sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
            }
        }
        
        cell.moneyLable.text = [NSString stringWithFormat:@"合计：%@元",[dic objectForKey:@"orderprice"]];
        
        cell.titleLable.text = [dic objectForKey:@"ordertitle"];
        [cell.clickBut setTitle:@"评价" forState:UIControlStateNormal];
        //标识
        cell.clickBut.tag = indexPath.row;
        cell.imgBut.tag = indexPath.row;
        
        //cell中的头像
        [cell.imgBut addTarget:self action:@selector(userInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.clickBut addTarget:self action:@selector(assessButClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

#pragma mark - 头像的点击事件
- (void)userInfo:(UIButton *)sendr
{
    if(self.isClick)
    {
        self.isClick = NO;
        
        dataRequest * data = [[dataRequest alloc]init];
        
        AppDelegate * app = [UIApplication sharedApplication].delegate;
        UserInfoViewController * user = [[UserInfoViewController alloc]init];
        
        NSDictionary * orderDic = [self.orderInfoArray objectAtIndex:sendr.tag];
        
        for(NSDictionary * userDic in self.userInfoArray)           //用户信息
        {
            NSString *  userID = [userDic objectForKey:@"c_user_userid"];
            if([[orderDic objectForKey:@"c_user_userid"] isEqualToString:userID])
            {
                NSDictionary * sDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [userDic objectForKey:@"c_user_userid"], @"userid",
                                       nil];
                [data selectUserCredit:sDic and:^(NSDictionary *dataDic) {
                    
                    NSArray * arr = [dataDic objectForKey:@"value"];
                    NSDictionary * dic = [arr firstObject];
                    
                    [user setValue:dic forKey:@"fractionDic"];
                    
                    [user setValue:userDic forKey:@"userDic"];
                    [app.rootNav pushViewController:user animated:YES];
                    self.isClick = YES;
                }];
            }
        }
    }
}

#pragma mark - 评价按钮的点击事件(跳页)
- (void)assessButClick:(UIButton *)sendr
{
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    AssessViewController * assess = [[AssessViewController alloc]init];
    
    NSDictionary * orderDic = [self.orderInfoArray objectAtIndex:sendr.tag];
    [assess setValue: orderDic forKey:@"orderDic"];          //订单信息
    
    for(NSDictionary * userDic in self.userInfoArray)        //用户信息
    {
        NSString *  userID = [userDic objectForKey:@"c_user_userid"];
        if([[orderDic objectForKey:@"c_user_userid"] isEqualToString:userID])
        {
            [assess setValue: userDic forKey:@"userDic"];
        }
    }
    
    [app.rootNav pushViewController:assess animated:YES];
    
    [assess setValue:self.l_userid forKey:@"l_userid"];
}

#pragma mark - cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //清除点击阴影
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(self.isClick)
    {
        self.isClick = NO;
        //跳到详情页
        dataRequest * data = [[dataRequest alloc]init];
        
        AppDelegate * app = [UIApplication sharedApplication].delegate;
        DetailViewController * detail = [[DetailViewController alloc]init];
        
        [detail setValue: @"评价" forKey:@"isButSta"];            //标识
        
        NSDictionary * orderDic = [self.orderInfoArray objectAtIndex:indexPath.row];
        [detail setValue: orderDic forKey:@"orderDic"];          //订单信息
        
        for(NSDictionary * userDic in self.userInfoArray)        //用户信息
        {
            NSString *  userID = [userDic objectForKey:@"c_user_userid"];
            if([[orderDic objectForKey:@"c_user_userid"] isEqualToString:userID])
            {
                NSDictionary * sDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [userDic objectForKey:@"c_user_userid"], @"userid",
                                       nil];
                [data selectUserCredit:sDic and:^(NSDictionary *dataDic) {
                    
                    if([[dataDic objectForKey:@"code"] isEqualToString:@"succeed"])
                    {
                        NSArray * arr = [dataDic objectForKey:@"value"];
                        NSDictionary * dic = [arr firstObject];
                        
                        [detail setValue:dic forKey:@"fractionDic"];
                        
                        [detail setValue:userDic forKey:@"userDic"];
                        [detail setValue:self.l_userid forKey:@"l_userid"];
                        
                        [app.rootNav pushViewController:detail animated:YES];
                        
                        self.isClick = YES;
                        [self.table reloadData];
                    }
                }];
            }
        }
    }
}

@end
