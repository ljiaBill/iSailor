//
//  AuthenticationViewController.h
//  iLazy
//
//  Created by administrator on 15/10/18.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalService.h"

@interface AuthenticationViewController : UIViewController

@property (strong, nonatomic) UITextField *nameText;
@property (strong, nonatomic) UITextField *IDcardText;

@property (strong, nonatomic) NSString *str;

@property (strong, nonatomic) UIButton *okBut;

@end
