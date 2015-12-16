//
//  PersonalService.h
//  iLazy
//
//  Created by administrator on 15/10/9.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface PersonalService : NSObject

//修改Lazy用户信息
- (void)alterLazyUserInfo:(NSMutableDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedAlter;

//添加头像
- (void)insertUserImage:(UIImage *)image and:(void (^)(NSDictionary * dataDic))succeedRequest;

//取得用户信息
- (void)selectUserLoginInfo:(NSDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedSelect;

//修改Lazy用户密码
- (void)alterLazyUserPasswd:(NSDictionary *)UserPasswdDic and:(void (^)(NSDictionary * dataDic))succeedAlter;


@end
