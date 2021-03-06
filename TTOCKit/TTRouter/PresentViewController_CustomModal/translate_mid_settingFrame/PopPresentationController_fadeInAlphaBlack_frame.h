//
//  PopPresentationController_fadeInAlphaBlack_frame.h
//  fscar
//
//  Created by apple on 2016/10/28.
//  Copyright © 2016年 丰硕汽车. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopPresentationController_fadeInAlphaBlack_frame :UIPresentationController

/** 外部提供的 目标控制器的view的尺寸*/
@property (assign,nonatomic) CGRect presentFrame;


/**
 *  这个方法必须要重写,是一个初始化的方法
 用于创建负责转场动画的对象
 *
 *  @param presentedViewController  被展现的控制器(也就是MidDownMenuController)
 *  @param presentingViewController 发起的控制器(也就是进行modal的控制器)
 *
 *  @return 负责转场动画的对象
 */
-(instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController;
@end
