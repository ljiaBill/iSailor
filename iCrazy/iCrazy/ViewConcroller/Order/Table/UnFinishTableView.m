//
//  UnFinishTableView.m
//  iLazy
//
//  Created by Administrator on 15/9/24.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UnFinishTableView.h"
#import "UIButton+WebCache.h"

@implementation UnFinishTableView

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

    return self;
}

#pragma mark - 取值返回的信息
//取值返回的订单信息
- (void)getOrderData:(NSArray *)orderInfoArray and:(NSArray *)userInfoArray and:(NSArray *)orderAllInfoArray and:(NSString *)userid
{
    
    NSMutableArray * array = [NSMutableArray array];
    
    for(NSDictionary * dic in orderInfoArray)        //得到需要展示出来的订单
    {
        for(NSDictionary * asDic in orderAllInfoArray)
        {
            NSString * idOne = [dic objectForKey:@"l_order_orderid"];
            NSString * idTwo = [asDic objectForKey:@"orderid"];
            if([idOne isEqualToString:idTwo])
            {
                [array addObject:asDic];
            }
        }
    }
    
    for(NSDictionary * dic in array)
    {
        if([[dic objectForKey:@"orderstatus"] isEqualToString:@"-1"])
        {
            [self.orderInfoArray addObject:dic];
        }
    }
    
    for(NSDictionary * asDic in userInfoArray)
    {
        [self.userInfoArray addObject:asDic];
    }

    self.c_userid = userid;
    
    if(self.orderInfoArray.count == 0)
    {
        self.notInfoBut = [[UIButton alloc]initWithFrame:CGRectMake(50, UISCREEN_WIDTH/2-UISCREEN_HEIGHT/10, UISCREEN_WIDTH-100, UISCREEN_HEIGHT/3.5)];
        [self.notInfoBut setImage:[UIImage imageNamed:@"jiazaishibai_2"] forState:UIControlStateNormal];
        [self.notInfoBut.layer setCornerRadius:8];
        self.isTime = 2;
        //每隔一段时间执行一次方法
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(autoimg) userInfo:nil repeats:YES];
        [self addSubview:self.notInfoBut];
        
        UIView * viewPoint = [[UIView alloc]initWithFrame:CGRectMake(50, UISCREEN_WIDTH/2-UISCREEN_HEIGHT/10, UISCREEN_WIDTH-100, UISCREEN_HEIGHT/3.5)];
        viewPoint.alpha = 0.4;
        [self addSubview:viewPoint];
        
        UILabel * point = [[UILabel alloc]initWithFrame:CGRectMake(50, UISCREEN_WIDTH/2-UISCREEN_HEIGHT/10+UISCREEN_HEIGHT/4, UISCREEN_WIDTH-100, 40)];
        
        point.textAlignment = NSTextAlignmentCenter;
        point.text = @"---您还没有相关订单---";
        point.textColor = COLORNAVIGATION;
        point.font = [UIFont systemFontOfSize:15];
        [self addSubview:point];
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
        NSString * orderID = [orderDic objectForKey:@"l_user_userid"];
        
        for(NSDictionary * userDic in self.userInfoArray)
        {
            NSString *  userID = [userDic objectForKey:@"l_user_userid"];
            if([orderID isEqualToString:userID])
            {
                cell.nameLabel.text = [userDic objectForKey:@"usernick"];
                
                //同步获取网络图片
                NSString * url = [NSString stringWithFormat:@"%@%@",LAZY_IMAGE_PATH,[userDic objectForKey:@"userimage"]];
//                self.internetImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
                //异步获取图片
                [cell.imgBut sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
            }
        }
        
        cell.moneyLable.text = [NSString stringWithFormat:@"合计：%@元",[dic objectForKey:@"orderprice"]];
        
        cell.titleLable.text = [dic objectForKey:@"ordertitle"];
        [cell.clickBut setTitle:@"确定" forState:UIControlStateNormal];
        //使用tag值来表示那个按钮的响应事件
        cell.clickBut.tag = indexPath.row;
        cell.imgBut.tag = indexPath.row;
        
        //cell中的头像
        [cell.imgBut addTarget:self action:@selector(userInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.clickBut addTarget:self action:@selector(unFinishButClick:) forControlEvents:UIControlEventTouchUpInside];
    }

    return cell;
}

#pragma mark - 头像的点击事件
- (void)userInfo:(UIButton *)sendr
{
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    UserInfoViewController * user = [[UserInfoViewController alloc]init];
    
    NSDictionary * orderDic = [self.orderInfoArray objectAtIndex:sendr.tag];
    
    for(NSDictionary * userDic in self.userInfoArray)           //用户信息
    {
        NSString *  userID = [userDic objectForKey:@"l_user_userid"];
        if([[orderDic objectForKey:@"l_user_userid"] isEqualToString:userID])
        {
            [user setValue:userDic forKey:@"userDic"];
        }
    }
    [app.rootNav pushViewController:user animated:YES];
}

#pragma mark - 确定按钮的点击事件
- (void)unFinishButClick:(UIButton *)sendr
{
    AlartViewController * alartViewController = [[AlartViewController alloc]init];
    [alartViewController deliverInfoLelf:@"取消" andRight:@"确定" andTitle:@"确定完成订单吗?" andPoint:@"订单提交成功!" andStatus:YES];
    alartViewController.delegate = self;
    [alartViewController showView:self];
    self.isAlter = sendr.tag;
    
    //发通知
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"loseEfficacy" object:nil];
}

#pragma mark - 提示框的代理方法
- (void)positiveButtonAction
{
    NSLog(@"你点击了确定!");
    NSLog(@"你修改了第%ld个的状态",self.isAlter);
    
    self.alterDic = [self.orderInfoArray objectAtIndex:self.isAlter];
    
    [self.orderInfoArray removeObjectAtIndex:self.isAlter];      //删除本地
    
    [self.table reloadData];          //刷新table
    [self alterDB:self.alterDic];               //对数据库的修改状态操作
    
    //发通知
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"becomeEfficacy" object:nil];
}

- (void)negativeButtonAction
{
    NSLog(@"你取消了确定订单!");
    
    //发通知
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"becomeEfficacy" object:nil];
}

#pragma mark - 对数据库操作
- (void)alterDB:(NSDictionary *)dic
{
    NSString * orderid = [dic objectForKey:@"orderid"];
    NSString * ollStatus = [dic objectForKey:@"orderstatus"];
    dataRequest * data = [[dataRequest alloc]init];
    
    if([ollStatus isEqualToString:@"-1"])      //如果是待完成
    {
        NSString * newStatus = @"1";         //变成已完成(另一个端的未评价)
        
        NSDictionary * orderStatus = [NSDictionary dictionaryWithObjectsAndKeys:
                                      orderid, @"orderid",
                                      newStatus,   @"status"
                                      , nil];
        [data alterOrderId:orderStatus and:^(NSDictionary *dataDic) {
            
            NSDictionary * orderDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                       orderid, @"orderid",
                                       @"1",   @"status"
                                       , nil];
            
            [data alterCrazyOrderId:orderDic and:^(NSDictionary *dataDic) {
                
                NSString * code = [dataDic objectForKey:@"code"];
                if([code isEqualToString:@"succeed"])
                {
                    NSLog(@"成功完成第%@号订单",[dataDic objectForKey:@"orderid"]);
                    
                    //发通知
                    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
                    [center postNotificationName:@"alterStatus" object:self.alterDic];
                }
                else
                {
                    NSLog(@"操作失败!");
                }
                
            }];
        }];
    }
}

#pragma mark - 收到通知后所做的事情
- (void)reloadTable:(NSNotification *)cation
{
    NSDictionary * orderDic = cation.object;
    for(int i=0;i<self.orderInfoArray.count;i++)
    {
        NSDictionary * nsDic = [self.orderInfoArray objectAtIndex:i];
        if([[nsDic objectForKey:@"orderid"] isEqualToString:[orderDic objectForKey:@"orderid"]])
        {
            [self.orderInfoArray removeObjectAtIndex:i];        //删除
        }
        [self.table reloadData];          //刷新Table
    }
}

#pragma mark - 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //清除点击阴影
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //跳到详情页
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    DetailViewController * detail = [[DetailViewController alloc]init];
    
    [detail setValue: @"确定" forKey:@"isButSta"];            //标识
    
    NSDictionary * orderDic = [self.orderInfoArray objectAtIndex:indexPath.row];
    [detail setValue: orderDic forKey:@"orderDic"];          //订单信息
    for(NSDictionary * userDic in self.userInfoArray)        //用户信息
    {
        NSString *  userID = [userDic objectForKey:@"l_user_userid"];
        if([[orderDic objectForKey:@"l_user_userid"] isEqualToString:userID])
        {
            [detail setValue: userDic forKey:@"userDic"];
        }
    }
    
    [app.rootNav pushViewController:detail animated:YES];
}

@end
