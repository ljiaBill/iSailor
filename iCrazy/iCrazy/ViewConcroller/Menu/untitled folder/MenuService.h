//
//  MenuService.h
//  iCrazy
//
//  Created by Administrator on 15/10/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MenuService : NSObject

//修改Lazy用户信息
- (void)alterCrazyUserInfo:(NSMutableDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedAlter;

//添加头像
- (void)insertUserImage:(UIImage *)image and:(void (^)(NSDictionary * dataDic))succeedRequest;

//取得用户信息
- (void)selectUserLoginInfo:(NSDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedSelect;

//修改Lazy用户密码
- (void)alterCrazyUserPasswd:(NSDictionary *)UserPasswdDic and:(void (^)(NSDictionary * dataDic))succeedAlter;

//身份认证
- (void)requestCrazyUserIDcar:(NSDictionary *)UserDic andDic:(void (^)(NSDictionary * dataDic))succeedRequest;

//修改身份认证状态
- (void)alterCrazyUserIDcarStatus:(NSDictionary *)UserDic andDic:(void (^)(NSDictionary * dataDic))succeedAlter;

@end
