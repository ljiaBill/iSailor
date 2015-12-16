//
//  UserInfo.h
//  iCrazy
//
//  Created by administrator on 15/10/22.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoPlist.h"

@interface UserInfo : NSObject

//个人信息的存储
//写入
- (void)userSaveInfo:(NSDictionary *)dic andSuccess:(void (^)(NSString * str))succeed;

//读取
- (void)userReadInfo:(void(^)(NSDictionary * dic))infoDic;


@end
