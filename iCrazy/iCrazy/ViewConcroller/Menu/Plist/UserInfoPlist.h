//
//  UserInfoPlist.h
//  iCrazy
//
//  Created by administrator on 15/10/22.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoPlist : NSObject

@property(copy , nonatomic)NSString *rootPath;

- (NSString *)userInformationPath;

@end
