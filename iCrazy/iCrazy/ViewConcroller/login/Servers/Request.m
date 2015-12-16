//
//  Request.m
//  iLazy
//
//  Created by Administrator on 15/10/9.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "Request.h"

@implementation Request


//勤人端登录请求
- (void)requestUserInfo:(NSDictionary *)userDic andSuccess:(void (^)(NSDictionary *postDic))success{
    
    NSLog(@"+-+-+-+-+-%@",userDic);
    
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_LOGIN_ADDRESS parameters:userDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         success(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
}

//勤人端请求是否已经注册

-(void)orregiste:(NSDictionary *)userDic and:(void (^)(NSDictionary *))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ExistName parameters:userDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
    
}



//勤人端注册请求
-(void)registUser:(NSDictionary *)userDic and:(void (^)(NSDictionary *))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_REGISTER_ADDRESS parameters:userDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
}

//勤人端请求插入用户信息表
-(void)insertUserInfo:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_Insert_UserInfo parameters:userDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
}

//勤人端请求修改密码，忘记密码
-(void)afterpassword:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_Uppassword parameters:userDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
}


//勤人端请求懒人端订单数据(模糊查询)
-(void)querylazyorder:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataOrderDic))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_Order_Search parameters:userDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
}

//勤人端请求懒人端所有用户
-(void)querylazyuser:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataUserDic))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_User_Info parameters:userDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
}

//修改懒人端的订单的状态
-(void)alfterorder:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ORDER_STATUS parameters:orderDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];

}

//请求插入c_order状态
-(void)insertorder:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_Insert_order  parameters:orderDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
}

//请求插入用户信用表
-(void)insertcredit:(NSDictionary *)creditDic and:(void (^)(NSDictionary * dataCreditDic))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_INSERT_CREDIT  parameters:creditDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
    
}

//请求插入l_order状态
-(void)queryorderid:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataOrderDic))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_Orderid_order  parameters:orderDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
}

@end
