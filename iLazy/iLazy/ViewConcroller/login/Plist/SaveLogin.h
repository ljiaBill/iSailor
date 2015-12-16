//
//  SaveLogin.h
//  iLazy
//
//  Created by Administrator on 15/10/19.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveLogin : NSObject

//自动登录信息
- (void)saveInfo:(NSMutableDictionary *)dic andSuccess:(void (^)(NSString * str))succeed;

- (void)getInfo:(void(^)(NSMutableDictionary * dic))getdic;

@end
