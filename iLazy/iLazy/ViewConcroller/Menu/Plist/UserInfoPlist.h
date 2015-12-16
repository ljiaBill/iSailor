//
//  UserInfoPlist.h
//  iLazy
//
//  Created by Administrator on 15/10/21.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoPlist : NSObject

@property(copy , nonatomic)NSString *rootPath;

- (NSString *)userInformationPath;

@end
