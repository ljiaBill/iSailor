//
//  UserPlist.h
//  iLazy
//
//  Created by Administrator on 15/10/19.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPlist : NSObject
@property(copy , nonatomic)NSString *rootPath;

- (NSString *)userInformationPath;
@end
