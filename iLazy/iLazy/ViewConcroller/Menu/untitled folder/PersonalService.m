//
//  PersonalService.m
//  iLazy
//
//  Created by administrator on 15/10/9.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "PersonalService.h"
#import "Macro.h"

@implementation PersonalService


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

//添加头像
- (void)insertUserImage:(UIImage *)image and:(void (^)(NSDictionary * dataDic))succeedRequest
{
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:iS_INSERT_USER_IMAGE parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data name:@"upload" fileName:@".png" mimeType:@""];
        
    } success:^(AFHTTPRequestOperation * operation, NSData * response) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
        NSLog(@"请求失败!");
        
    }];
}

//取得用户信息
- (void)selectUserLoginInfo:(NSDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedSelect
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_TEST_PASSWORD parameters:UserInfoDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedSelect(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求修改用户信息失败!");
        
    }];
}


//修改Lazy用户密码
- (void)alterLazyUserPasswd:(NSDictionary *)UserPasswdDic and:(void (^)(NSDictionary * dataDic))succeedAlter
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ILAZY_USERPASSWD parameters:UserPasswdDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedAlter(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求修改用户信息失败!");
        
    }];
}


@end
