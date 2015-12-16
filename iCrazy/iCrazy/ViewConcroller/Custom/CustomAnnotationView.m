//
//  CustomAnnotationView.m
//  iLazy
//
//  Created by administrator on 15/9/22.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "Macro.h"
@interface CustomAnnotationView()

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;

@end

@implementation CustomAnnotationView

//重写选中方法setSelected。选中时新建并添加calloutView，传入数据；非选中时删除calloutView
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        
        if (self.calloutView == nil)
        {
     
                //创建气泡
                self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
                
                //设置 气泡位置
                self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 10.f + self.calloutOffset.x,
                                                      -CGRectGetHeight(self.calloutView.bounds) / 1.5f + self.calloutOffset.y);
        }
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

// 重新此函数，用以实现点击calloutView判断为点击该annotationView
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    BOOL inside = [super pointInside:point withEvent:event];
    if (!inside && self.selected) {
        
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
        
    }
    
    return inside;
}

@end
