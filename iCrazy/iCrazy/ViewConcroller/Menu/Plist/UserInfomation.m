//
//  UserInfomation.m
//  iCrazy
//
//  Created by administrator on 15/10/22.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UserInfomation.h"

@implementation UserInfomation

//个人信息的存储
//写入
- (void)userSaveInfo:(NSDictionary *)dic andSuccess:(void (^)(NSString * str))succeed
{
    UserInfomationPlist *userinfo = [[UserInfomationPlist alloc]init];
    NSString *infoPath = [userinfo userInformationPath];
    NSString *lastPath = [infoPath stringByAppendingPathComponent:@"userInfo.Plist"];
    NSLog(@"%@",lastPath);
    
    if ([dic writeToFile:lastPath atomically:YES])
    {
        NSString *str = @"存入成功";
        succeed(str);
    } 
    
    else
    {
        NSString *str = @"存入失败";
        succeed(str);
    }
}

//读取
- (void)userReadInfo:(void(^)(NSDictionary * dic))infoDic
{
    UserInfomationPlist *userinfo = [[UserInfomationPlist alloc]init];
    NSString *infoPath = [userinfo userInformationPath];
    NSString *lastPath = [infoPath stringByAppendingPathComponent:@"userInfo.Plist"];
    NSLog(@"%@",lastPath);
    NSDictionary * dics = [NSDictionary dictionaryWithContentsOfFile:lastPath];
    
    //回调
    infoDic(dics);
}

//存个人信用度信息
//写入
- (void)userSaveCreditInfo:(NSDictionary *)dic andSuccess:(void (^)(NSString * str))succeed{
    
    UserInfomationPlist *userinfo = [[UserInfomationPlist alloc]init];
    NSString *infoPath = [userinfo userInformationPath];
    NSString *lastPath = [infoPath stringByAppendingPathComponent:@"userCreditInfo.Plist"];
    NSLog(@"%@",lastPath);
    
    if ([dic writeToFile:lastPath atomically:YES])
    {
        NSString *str = @"存入成功";
        succeed(str);
    }
    
    else
    {
        NSString *str = @"存入失败";
        succeed(str);
    }
}

//读取
- (void)userReadCreditInfo:(void(^)(NSDictionary * dic))infoDic{
    
    UserInfomationPlist *userinfo = [[UserInfomationPlist alloc]init];
    NSString *infoPath = [userinfo userInformationPath];
    NSString *lastPath = [infoPath stringByAppendingPathComponent:@"userCreditInfo.Plist"];
    NSLog(@"%@",lastPath);
    NSDictionary * dics = [NSDictionary dictionaryWithContentsOfFile:lastPath];
    
    //回调
    infoDic(dics);
}

@end
