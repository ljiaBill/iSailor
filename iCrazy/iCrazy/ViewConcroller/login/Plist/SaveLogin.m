//
//  SaveLogin.m
//  iLazy
//
//  Created by Administrator on 15/10/19.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "SaveLogin.h"
#import "UserPlist.h"

@implementation SaveLogin

//存入Plist
- (void)saveInfo:(NSMutableDictionary *)dic andSuccess:(void (^)(NSString * str))succeed{
    
    UserPlist *localinfo = [[UserPlist alloc]init];
    NSString *infoPath = [localinfo userInformationPath];
    NSString *lastPath = [infoPath stringByAppendingPathComponent:@"loginPlist.Plist"];
    NSLog(@"%@",lastPath);
    
    if ([dic writeToFile:lastPath atomically:YES]) {
        
        NSString *str = @"存入成功";
        
        succeed(str);
        
    }
    
    else {
        
        NSString *str = @"存入失败";
        succeed(str);
    }
}

//取出Plist
-(void)getInfo:(void (^)(NSMutableDictionary *))getdic {
    
    UserPlist *localinfo =[[UserPlist alloc]init];
    NSString *infoPath = [localinfo userInformationPath];
    NSString *lastPath = [infoPath stringByAppendingPathComponent:@"loginPlist.Plist"];
    NSLog(@"%@",lastPath);
    NSMutableDictionary *dics = [NSMutableDictionary dictionaryWithContentsOfFile:lastPath];
    
    if (dics) {
        
        getdic(dics);
    }
    else{
        
    }
}

@end
