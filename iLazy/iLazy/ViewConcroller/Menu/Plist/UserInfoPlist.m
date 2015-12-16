//
//  UserInfoPlist.m
//  iLazy
//
//  Created by Administrator on 15/10/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UserInfoPlist.h"

@implementation UserInfoPlist

- (id)init {
    if (self = [super init]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        _rootPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"LazyUserInfoPlist"];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:_rootPath] == NO) {
            if (![[NSFileManager defaultManager] createDirectoryAtPath:_rootPath
                                           withIntermediateDirectories:NO
                                                            attributes:nil
                                                                 error:nil]) {
                
            }
        }
    }
    return self;
}



- (BOOL)createDirectory:(NSString *)path {
    if ([[NSFileManager defaultManager] fileExistsAtPath:path] == NO) {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil]) {
            // error
            return NO;
        }
    }
    return YES;
}

//存放用户信息的文件
- (NSString *)userInformationPath {
    
    if ([self createDirectory:_rootPath]) {
        return _rootPath;
    }
    return nil;
}

@end
