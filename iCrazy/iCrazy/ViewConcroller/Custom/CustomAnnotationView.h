//
//  CustomAnnotationView.h
//  iLazy
//
//  Created by administrator on 15/9/22.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"
@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) CustomCalloutView *calloutView;


@end
