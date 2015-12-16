//
//  PersonalViewController.h
//  iLazy
//
//  Created by Vic on 15/9/26.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol personalDelegate <NSObject>

- (void)personal;

@end

@interface PersonalViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate,personalDelegate>


@end
