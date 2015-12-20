//
//  MapService.h
//  iLazy
//
//  Created by administrator on 15/10/9.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MapService : NSObject

//查询Crazy用户信息
- (void)requestCrazyUserData:(void (^)(NSDictionary * dataDic))succeedRequest;

//查询Lazy用户信息
- (void)requestLazyUserData:(void (^)(NSDictionary * dataDic))succeedRequest;

//添加Crazy用户位置信息
- (void)insertCrazyLocationInfo:(NSMutableDictionary *)LocationInfo and:(void (^)(NSDictionary * dataDic))succeedInsert;

//修改Lazy用户信息
- (void)alterLazyUserInfo:(NSMutableDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedAlter;

//查询Lazy用户位置信息
- (void)requestLazyLocationInfo:(void (^)(NSDictionary * dataDic))succeedRequest;

//修改Crazy用户位置信息
- (void)alterCrazyLocationInfo:(NSMutableDictionary *)LocationInfo and:(void (^)(NSDictionary * dataDic))succeedAlter;

//修改Lazy用户密码
- (void)alterLazyUserPasswordInfo:(NSMutableDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedAlter;

//查询订单信息
- (void)requestLazyOrder:(void (^)(NSDictionary * dataDic))succeedRequest;

//查询状态为2的订单信息
- (void)requestLazyOrderTwo:(NSDictionary *)UserInfoDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//修改懒人端的订单的状态
-(void)alfterOrderStatus:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//查询Crazy用户信用度信息
- (void)selectUserCredit:(NSDictionary *)userid and:(void (^) (NSDictionary *dataDic))succeedRequest;

//修改Crazy用户位置信息
- (void)updateCrazyLocationInfo:(NSMutableDictionary *)LocationInfo and:(void (^)(NSDictionary * dataDic))succeedAlter;

@end
