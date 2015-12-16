//
//  dataRequest.h
//  iLazy
//
//  Created by Administrator on 15/9/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface dataRequest : NSObject

//请求订单表中的所有数据
- (void)requestOrderData:(NSDictionary *)useridDic and: (void (^)(NSDictionary * dataDic))succeedRequest;

//请求订单表(l_order)中的全部数据
- (void)requestOrderAllData:(void (^)(NSDictionary * dataDic))succeedRequest;

//请求用户信息表中的所有数据
- (void)requestUserData:(void (^)(NSDictionary * dataDic))succeedRequest;

//删除订单表(l_order)中的信息
- (void)deleteLazyOrderId:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//删除订单表(c_order)中的信息
- (void)deleteCrazyOrderId:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//修改订单(c_order)状态
- (void)alterCrazyOrderId:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//修改订单(l_order)状态
- (void)alterOrderId:(NSDictionary *)orderDic and:(void (^)(NSDictionary * dataDic))succeedRequest;

//添加反馈信息
- (void)insertIdeaInfo:(NSDictionary *)ideaInfo and:(void (^)(NSDictionary * dataDic))succeedRequest;

//添加反馈图片
- (void)insertFeedbackImage:(UIImage *)image and:(void (^)(NSDictionary * dataDic))succeedRequest;

@end
