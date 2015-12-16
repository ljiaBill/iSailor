//
//  UnCarryTableView.m
//  iLazy
//
//  Created by Administrator on 15/10/19.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UnCarryTableView.h"

@implementation UnCarryTableView

#pragma mark - 初始化方法
- (instancetype)initWithTableView:(CGRect)frame
{
    
    self = [super initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    if(self)
    {
        self.showView = [[UIView alloc]initWithFrame:CGRectMake(0,0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
        
        self.orderArray = [NSMutableArray array];

        self.showView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self addSubview:self.showView];
    }
    //观察者
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(refreshTable:) name:@"anewRequest" object:nil];
    return self;
}

#pragma mark - 接收到通知后的处理事件
- (void)refreshTable:(NSNotification *)cation
{
    //添加到数组
    NSDictionary * newDic = cation.object;
    
    NSString * newID = [newDic objectForKey:@"orderid"];
    
    NSString * userid = [newDic objectForKey:@"userid"];
    NSString * detail = [newDic objectForKey:@"detail"];
    NSString * orderid = [newDic objectForKey:@"orderid"];
    NSString * insurance = [newDic objectForKey:@"insurance"];
    NSString * phone = [newDic objectForKey:@"phone"];
    NSString * price = [newDic objectForKey:@"price"];
    NSString * remark = [newDic objectForKey:@"remark"];
    NSString * status = [newDic objectForKey:@"status"];
    NSString * time = [newDic objectForKey:@"time"];
    NSString * title = [newDic objectForKey:@"title"];

    
    NSDictionary * rightDic = [NSDictionary dictionaryWithObjectsAndKeys:
                               userid,         @"l_user_userid",
                               detail,         @"orderdetail",
                               orderid,        @"orderid",
                               insurance,      @"orderinsurance",
                               phone    ,      @"orderphone",
                               price,          @"orderprice",
                               remark,         @"orderremark",
                               status,         @"orderstatus",
                               time,           @"ordertime",
                               title,          @"ordertitle"
                               , nil];
    
    for(int i=0; i<self.orderArray.count;i++)
     {
         NSString * ID = [[self.orderArray objectAtIndex:i] objectForKey:@"orderid"];
         
         if([newID isEqualToString:ID])
         {
             [self.orderArray replaceObjectAtIndex:i withObject:rightDic];
         }
     }
    
    [self.table reloadData];         //刷新
}

#pragma mark - 取值返回的信息
- (void)getOrderData:(NSArray *)orderArray and:(NSString *)userid
{
    if(orderArray.count == 0)
    {
        [self notOrder];
    }
    else
    {
        for(NSDictionary * dic in orderArray)                //得到需要展示出来的订单
        {
            NSString * status = [dic objectForKey:@"orderstatus"];
            
            if([status isEqualToString:@"2"])
            {
                [self.orderArray addObject:dic];
            }
        }
        
        if(self.orderArray.count == 0)
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
    self.l_userid = userid;
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
    return self.orderArray.count;
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
    
    CarryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil)
    {
        cell = [[CarryTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    //去线
    self.table.separatorStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    NSDictionary * dic = [self.orderArray objectAtIndex:indexPath.row];
    
    cell.titleLable.text = [dic objectForKey:@"ordertitle"];
    
    cell.detailLable.text = [dic objectForKey:@"orderdetail"];
    
    //计算时间
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * newDateFormatter = [dateFormatter dateFromString:[dic objectForKey:@"ordertime"]];       //取出的时间
    
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate * current_date = [[NSDate alloc] init];
    
    NSTimeInterval time = [current_date timeIntervalSinceDate:newDateFormatter];
    
    int month = ((int)time)/(3600*24*30);
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/60;
    int second = ((int)time)%(3600*24*60*60);
    if(month!=0)
    {
        cell.timeLable.text = [NSString stringWithFormat:@"%i%@",month,@"个月前"];
    }
    else if(days!=0)
    {
        cell.timeLable.text = [NSString stringWithFormat:@"%i%@",days,@"天前"];
    }
    else if(hours!=0)
    {
        cell.timeLable.text = [NSString stringWithFormat:@"%i%@",hours,@"小时前"];
    }
    else if(minute!=0)
    {
        cell.timeLable.text = [NSString stringWithFormat:@"%i%@",minute,@"分钟前"];
    }
    else
    {
        cell.timeLable.text = [NSString stringWithFormat:@"%i%@",second,@"秒前"];
    }
    
    cell.clickBut.tag = indexPath.row;
    
    cell.alterBut.tag = indexPath.row;
    
    [cell.clickBut addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.alterBut addTarget:self action:@selector(alterButClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //设置cell点击颜色
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *view_bg = [[UIView alloc]initWithFrame:cell.frame];
    [view_bg.layer setCornerRadius:5];
    view_bg.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = view_bg;
    
    return cell;
}

#pragma mark - 删除按钮的点击事件
- (void)butClick:(UIButton *)sendr
{
    AlartViewController * alartViewController = [[AlartViewController alloc]init];
    [alartViewController deliverInfoLelf:@"取消" andRight:@"确定" andTitle:@"确定删除订单吗?" andPoint:@"删除订单成功!" andStatus:YES];
    alartViewController.delegate = self;
    [alartViewController showView:self];
    self.isAlter = sendr.tag;
    
    //发通知
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"loseEfficacy" object:nil];
}

#pragma mark - 修改按钮的点击事件
- (void)alterButClick:(UIButton *)sendr
{
    self.isAlter = sendr.tag;
    self.valueDic = [self.orderArray objectAtIndex:self.isAlter];
    
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    AlterOrderViewController * alter = [[AlterOrderViewController alloc]init];
    [app.rootNav pushViewController:alter animated:YES];
    [alter setValue:self.valueDic forKey:@"valueDic"];
}

#pragma mark - 提示框的代理方法
- (void)positiveButtonAction
{
    NSLog(@"你点击了确定!");
    NSLog(@"你修改了第%ld个的状态",self.isAlter);
    
    self.deleDic = [self.orderArray objectAtIndex:self.isAlter];
    
    [self.orderArray removeObjectAtIndex:self.isAlter];      //删除本地
    
    [self.table reloadData];          //刷新table
    [self daleteDB:self.deleDic];           //对数据库的修改状态操作
    
    //发通知
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"becomeEfficacy" object:nil];
}

- (void)negativeButtonAction
{
    NSLog(@"你取消了删除订单!");
    
    //发通知
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"becomeEfficacy" object:nil];
}

#pragma mark - 对数据库操作
- (void)daleteDB:(NSDictionary *)dic
{
    NSString * orderid = [dic objectForKey:@"orderid"];
    
    NSDictionary * isDic = [NSDictionary dictionaryWithObjectsAndKeys:
                          orderid,  @"orderid",
                          nil];
    dataRequest * data = [[dataRequest alloc]init];
    
    [data deleteOrderId:isDic and:^(NSDictionary *dataDic) {
        
        if([[dataDic objectForKey:@"code"] isEqualToString:@"succeed"])
        {
            NSLog(@"删除成功!");
        }
        else
        {
            NSLog(@"删除失败!");
        }
    }];
}

#pragma mark - 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //清除点击阴影
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
