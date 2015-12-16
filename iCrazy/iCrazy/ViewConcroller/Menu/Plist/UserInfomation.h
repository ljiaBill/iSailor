//
//  UserInfomation.h
//  iCrazy
//
//  Created by administrator on 15/10/22.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfomationPlist.h"

@interface UserInfomation : NSObject

//个人信息的存储
//写入
- (void)userSaveInfo:(NSDictionary *)dic andSuccess:(void (^)(NSString * str))succeed;

//读取
- (void)userReadInfo:(void(^)(NSDictionary * dic))infoDic;

//存个人信用度
//写入
- (void)userSaveCreditInfo:(NSDictionary *)dic andSuccess:(void (^)(NSString * str))succeed;

//读取
- (void)userReadCreditInfo:(void(^)(NSDictionary * dic))infoDic;

@end
