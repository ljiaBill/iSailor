//
//  MenuService.m
//  iCrazy
//
//  Created by Administrator on 15/10/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "MenuService.h"
#import "Macro.h"

@implementation MenuService

//修改Lazy用户信息
- (void)alterCrazyUserInfo:(NSMutableDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedAlter
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
- (void)alterCrazyUserPasswd:(NSDictionary *)UserPasswdDic and:(void (^)(NSDictionary * dataDic))succeedAlter
{
    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ICRAZY_USERPASSWD parameters:UserPasswdDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedAlter(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求修改用户信息失败!");
        
    }];
}



//身份认证
- (void)requestCrazyUserIDcar:(NSDictionary *)UserDic andDic:(void (^)(NSDictionary * dataDic))succeedRequest{
    
    NSString *name = [UserDic objectForKey:@"name"];
    NSString *cardno = [UserDic objectForKey:@"cardno"];
    
    NSDictionary *headers = @{ @"accept": @"application/json",
                               @"content-type": @"application/json",
                               @"apix-key": ILAZY_USER_IDCAR_KEY };
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:@"%@?name=%@&cardno=%@",ILAZY_USER_IDCAR,name,cardno];
    
    NSLog(@"%@",url);
    
    [manager GET:url parameters:headers success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedRequest(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求身份认证失败!");
        
    }];
}

//修改身份认证状态
- (void)alterCrazyUserIDcarStatus:(NSDictionary *)UserDic andDic:(void (^)(NSDictionary * dataDic))succeedAlter{

    //实例化对象
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:iS_ALTER_ILAZY_IDCAR_STATUS parameters:UserDic success:^(AFHTTPRequestOperation *operation, NSData *responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        succeedAlter(dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"请求修改身份认证状态失败!");
        
    }];
}

@end
