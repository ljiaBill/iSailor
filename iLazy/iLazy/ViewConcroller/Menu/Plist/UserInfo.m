//
//  UserInfo.m
//  iLazy
//
//  Created by Administrator on 15/10/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

//个人信息的存储
//写入
- (void)userSaveInfo:(NSDictionary *)dic andSuccess:(void (^)(NSString * str))succeed
{
    UserInfoPlist *userinfo = [[UserInfoPlist alloc]init];
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
    UserInfoPlist *userinfo = [[UserInfoPlist alloc]init];
    NSString *infoPath = [userinfo userInformationPath];
    NSString *lastPath = [infoPath stringByAppendingPathComponent:@"userInfo.Plist"];
    NSLog(@"%@",lastPath);
    NSDictionary * dics = [NSDictionary dictionaryWithContentsOfFile:lastPath];
    
    //回调
    infoDic(dics);
}

@end
