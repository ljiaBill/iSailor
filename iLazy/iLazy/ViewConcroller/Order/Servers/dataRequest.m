//
//  dataRequest.m
//  iLazy
//
//  Created by Administrator on 15/9/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "dataRequest.h"
#import "Macro.h"

@implementation dataRequest

//根据userid请求订单表(l_order)中的数据
- (void)requestOrderData:(NSDictionary *)useridDic and: (void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ORDER_ADDRESS parameters:useridDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//请求订单表(c_order)中的全部数据
- (void)requestOrderAllData:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ORDER_ALL_ADDRESS parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//请求用户信息表(c_userInfo)中的所有数据
- (void)requestUserData:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_SElECT_USERINFO parameters:nil success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];

        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//删除订单表中的信息
- (void)deleteOrderId:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_DELETE_ORDER parameters:orderDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//修改订单(l_order)状态
- (void)alterOrderId:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ORDER_STATUS parameters:orderDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//修改订单(c_order)状态
- (void)alterCrazyOrderId:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_CRAZY_ORDER_STATUS parameters:orderDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//添加评价信息
- (void)insertCommentInfo:(NSDictionary *)commentInfo and:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_INSERT_COMMENT parameters:commentInfo success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//添加反馈信息
- (void)insertIdeaInfo:(NSDictionary *)ideaInfo and:(void (^)(NSDictionary * dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_INSERT_IDEA parameters:ideaInfo success:^(AFHTTPRequestOperation *operation, NSData *responseObject){
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//修改订单信息
- (void)updataOrder:(NSDictionary *)oredrInfo and:(void (^) (NSDictionary *dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ORDER_INFO parameters:oredrInfo success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//添加反馈图片
- (void)insertFeedbackImage:(UIImage *)image and:(void (^)(NSDictionary * dataDic))succeedRequest
{
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:iS_INSERT_IDEA_IMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data name:@"upload" fileName:@".png" mimeType:@""];
        
    } success:^(AFHTTPRequestOperation * operation, NSData * response) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//获取用户信用表信息
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

//修改用户信息表
- (void)insertUserCredit:(NSDictionary *)userid and:(void (^) (NSDictionary *dataDic))succeedRequest
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_INSERT_USER_CREDIT parameters:userid success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求失败!");
        
    }];
}

@end
