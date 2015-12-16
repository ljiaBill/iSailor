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

//懒人端请求用户登录
- (void)requestUserInfo:(NSDictionary *)userDic andSuccess:(void (^)(NSDictionary *postDic))success;


//懒人端用户注册请求
- (void)registUser:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest;


//懒人端判断用户是否已经注册
-(void)orregiste:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//请求插入用户信息表
-(void)insertUserInfo:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//请求修改密码，忘记密码
-(void)afterpassword:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//请求插入订单表
-(void)insertOrder:(NSDictionary *)userDic and:(void (^)(NSDictionary * dataDic))succeedRequest;



@end
