//
//  UIButton+Layout.m
//  YLButton
//
//  Created by HelloYeah on 2016/12/5.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "UIButton+TTLayout.h"
#import <objc/runtime.h>

@implementation UIButton (TTLayout)

#pragma mark - ************* 通过运行时动态添加关联 ******************
//定义关联的Key
static const char * titleRectKey = "yl_titleRectKey";
- (CGRect)TTtitleRect {
    
    return [objc_getAssociatedObject(self, titleRectKey) CGRectValue];
}

- (void)setTTtitleRect:(CGRect)rect {
    
    objc_setAssociatedObject(self, titleRectKey, [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

//定义关联的Key
static const char * imageRectKey = "yl_imageRectKey";
- (CGRect)TTimageRect {
    
    NSValue * rectValue = objc_getAssociatedObject(self, imageRectKey);
    
    return [rectValue CGRectValue];
}

- (void)setTTimageRect:(CGRect)rect {
    
    objc_setAssociatedObject(self, imageRectKey, [NSValue valueWithCGRect:rect], OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - ************* 通过运行时动态替换方法 ******************
+ (void)load {
    
    MethodSwizzle(self,@selector(titleRectForContentRect:),@selector(override_titleRectForContentRect:));
    MethodSwizzle(self,@selector(imageRectForContentRect:),@selector(override_imageRectForContentRect:));
}

void MethodSwizzle(Class c,SEL origSEL,SEL overrideSEL)
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod= class_getInstanceMethod(c, overrideSEL);
    
    //运行时函数class_addMethod 如果发现方法已经存在，会失败返回，也可以用来做检查用:
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod),method_getTypeEncoding(overrideMethod)))
    {
        //如果添加成功(在父类中重写的方法)，再把目标类中的方法替换为旧有的实现:
        class_replaceMethod(c,overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        //addMethod会让目标类的方法指向新的实现，使用replaceMethod再将新的方法指向原先的实现，这样就完成了交换操作。
        method_exchangeImplementations(origMethod,overrideMethod);
    }
}
      
- (CGRect)override_titleRectForContentRect:(CGRect)contentRect {

    if (!CGRectIsEmpty(self.TTtitleRect) && !CGRectEqualToRect(self.TTtitleRect, CGRectZero)) {
        return self.TTtitleRect;
    }
    return [self override_titleRectForContentRect:contentRect];

}

- (CGRect)override_imageRectForContentRect:(CGRect)contentRect {
    
    if (!CGRectIsEmpty(self.TTimageRect) && !CGRectEqualToRect(self.TTimageRect, CGRectZero)) {
        return self.TTimageRect;
    }
    return [self override_imageRectForContentRect:contentRect];
}

@end
