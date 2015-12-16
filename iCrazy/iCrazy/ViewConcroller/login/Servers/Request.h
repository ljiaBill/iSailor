//
//  Request.h
//  iLazy
//
//  Created by Administrator on 15/10/9.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Macro.h"

@interface Request : NSObject

//勤人端请求用户登录
- (void)requestUserInfo:(NSDictionary *)userDic andSuccess:(void (^)(NSDictionary *postDic))success;


//勤人端用户注册请求
- (void)registUser:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest;


//勤人端判断用户是否已经注册
-(void)orregiste:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//勤人端请求插入用户信息表
-(void)insertUserInfo:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//勤人端请求修改密码，忘记密码
-(void)afterpassword:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//勤人端请求懒人端订单数据(模糊查询)
-(void)querylazyorder:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataOrderDic))succeedRequest;

//勤人端请求懒人端所有用户
-(void)querylazyuser:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataUserDic))succeedRequest;

//请求修改l_order状态
-(void)alfterorder:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest;
//请求插入c_order状态
-(void)insertorder:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//请求插入用户信用表
-(void)insertcredit:(NSDictionary *)creditDic and:(void (^)(NSDictionary * dataCreditDic))succeedRequest;

//请求插入l_order状态
-(void)queryorderid:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataOrderDic))succeedRequest;


@end