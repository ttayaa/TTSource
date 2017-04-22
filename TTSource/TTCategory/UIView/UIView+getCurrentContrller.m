//
//  UIView+getCurrentContrller.m
//  ttayaa微博部署
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 ttayaa. All rights reserved.
//

#import "UIView+getCurrentContrller.h"

@implementation UIView (getCurrentContrller)
/** 获取当前View的控制器对象 */
-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    
    do {
        
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}
@end
