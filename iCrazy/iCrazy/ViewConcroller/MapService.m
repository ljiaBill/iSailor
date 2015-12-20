//
//  MapService.m
//  iLazy
//
//  Created by administrator on 15/10/9.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MapService.h"
#import "Macro.h"
@implementation MapService

//查询Lazy用户信息
- (void)requestLazyUserData:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_SElECT_ILAZY_USERINFO parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求查询Lazy用户信息失败!");
        
    }];
}

//查询Crazy用户信息
- (void)requestCrazyUserData:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_SElECT_ICRAZY_USERINFO parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求查询Cazy用户信息失败!");
        
    }];
}

//查询Lazy用户位置信息
- (void)requestLazyLocationInfo:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_SElECT_ILAZY_USERLOCATION parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求查询Lazy用户位置信息失败!");
        
    }];
}

//修改Crazy用户位置信息
- (void)alterCrazyLocationInfo:(NSMutableDictionary *)LocationInfo and:(void (^)(NSDictionary * dataDic))succeedAlter{

    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ICRAZY_USERINFO parameters:LocationInfo success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedAlter(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求修改用户信息失败!");
        
    }];
    
}

//修改Crazy用户位置信息
- (void)updateCrazyLocationInfo:(NSMutableDictionary *)LocationInfo and:(void (^)(NSDictionary * dataDic))succeedAlter{
    
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:INSERT_ILAZY_LOCATION parameters:LocationInfo success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedAlter(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求修改用户信息失败!");
        
    }];
    
}

//添加Crazy用户位置
- (void)insertCrazyLocationInfo:(NSMutableDictionary *)LocationInfo and:(void (^)(NSDictionary * dataDic))succeedInsert{
    
    NSString * userid = [LocationInfo objectForKey:@"userid"];
    NSString * locationinfo = [LocationInfo objectForKey:@"locationinfo"];
    
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * url = [NSString stringWithFormat:@"%@%@%@%@%@",iS_INSERT_ICRAZY_LOCATION,@"?userid=",userid,@"&locationinfo=",locationinfo];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedInsert(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求添加Crazy用户位置失败!");
        
    }];

}

//修改Lazy用户信息
- (void)alterLazyUserInfo:(NSMutableDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedAlter
{
    
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ICRAZY_USERINFO parameters:UserInfoDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedAlter(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求修改用户信息失败!");
        
    }];
}

//修改Lazy密码
- (void)alterLazyUserPasswordInfo:(NSMutableDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedAlter{

    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ICRAZY_USERPASSWD parameters:UserInfoDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedAlter(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求修改用户信息失败!");
        
    }];
}

//查询订单
- (void)requestLazyOrder:(void (^)(NSDictionary * dataDic))succeedRequest{
    
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ORDER_ALL_ADDRESS parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求查询订单失败!");
        
    }];
}

//查询状态为2的订单信息
- (void)requestLazyOrderTwo:(NSDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedRequest{

    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:IS_SELECT_ILAZY_ORDERTWO parameters:UserInfoDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求查询状态为2的订单失败!");
        
    }];
    
}

//修改懒人端的订单的状态
-(void)alfterOrderStatus:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ORDER_STATUS parameters:orderDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求修改懒人端的订单的状态失败!");
         
     }];
    
}

//查询Crazy用户信用度信息
- (void)selectUserCredit:(NSDictionary *)userid and:(void (^) (NSDictionary *dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_SELECT_CREDIT parameters:userid success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}


@end
