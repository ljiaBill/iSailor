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

//查询Crazy用户位置信息
- (void)requestCrazyLocationInfo:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_SElECT_ICRAZY_USERLOCATION parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求查询Cazy用户位置信息失败!");
        
    }];
}

//修改Crazy用户位置信息
- (void)alterCrazyLocationInfo:(NSMutableDictionary *)LocationInfo and:(void (^)(NSDictionary * dataDic))succeedAlter{

    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ILAZY_USERINFO parameters:LocationInfo success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedAlter(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求修改用户信息失败!");
        
    }];
    
}

//添加Lazy用户位置
- (void)insertLazyLocationInfo:(NSMutableDictionary *)LocationInfo and:(void (^)(NSDictionary * dataDic))succeedInsert{
    
    NSString * userid = [LocationInfo objectForKey:@"userid"];
    NSString * locationinfo = [LocationInfo objectForKey:@"locationinfo"];
    
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString * url = [NSString stringWithFormat:@"%@%@%@%@%@",iS_INSERT_ILAZY_LOCATION,@"?userid=",userid,@"&locationinfo=",locationinfo];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedInsert(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求添加Lazy用户位置失败!");
        
    }];

}

//修改Lazy用户信息
- (void)alterLazyUserInfo:(NSMutableDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedAlter
{
    
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ILAZY_USERINFO parameters:UserInfoDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
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
    
    [manager GET:iS_ALTER_ILAZY_PASSWORD parameters:UserInfoDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedAlter(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求修改用户信息失败!");
        
    }];
}

//查询Crazy用户信用度信息
- (void)requestUserCreditInfo:(void (^)(NSDictionary * dataDic))succeedRequest{

    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_SELECTALL_CREDIT parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求查询Crazy用户信用度信息失败!");
        
    }];
}


@end
