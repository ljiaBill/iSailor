//
//  AuthenticationViewController.h
//  iLazy
//
//  Created by administrator on 15/10/18.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalViewController.h"

@interface AuthenticationViewController : UIViewController

@property (strong, nonatomic) UITextField *nameText;
@property (strong, nonatomic) UITextField *IDcardText;

@property (strong, nonatomic) NSString *str;

@property (strong, nonatomic) UIButton *okBut;

@property (strong, nonatomic) NSString *userid;

//代理属性
@property (strong, nonatomic) id<personalDelegate>delegate;

@end
