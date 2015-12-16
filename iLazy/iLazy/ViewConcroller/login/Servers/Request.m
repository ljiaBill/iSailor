//
//  Request.m
//  iLazy
//
//  Created by Administrator on 15/10/9.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "Request.h"

@implementation Request


//懒人端登录请求
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

//懒人端请求是否已经注册

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



//懒人端注册请求
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

//请求插入用户信息表
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

//请求修改密码，忘记密码
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

//插入订单表
-(void)insertOrder:(NSMutableDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_Insert_Order parameters:userDic success:^(AFHTTPRequestOperation *requestOperation, NSData *data)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"请求数据%@",dic);
         succeedRequest(dic);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"请求失败!");
         
     }];
}




@end
