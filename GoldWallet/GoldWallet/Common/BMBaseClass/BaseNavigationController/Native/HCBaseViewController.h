//
//  HCBaseViewController.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/22.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCBaseViewController : UIViewController {
    UINavigationBar *_bar;
}

/**
 自定义返回按钮

 @param title 返回按钮文字
 */
- (void)customNavigationBackItemWithBackImageName:(NSString *)imageName Title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)titleColor;
- (void)customNavigationBackItemWithBackImageName:(NSString *)imageName Title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)titleColor selector:(SEL)selector;

- (void)customRightBarItemWithImage:(UIImage *)image selector:(SEL)selector;

/** 初始化data 子类实现*/
- (void)requestData;

/** 初始化title 子类实现*/
- (void)setupTitleView;

/** 初始化content 子类实现*/
- (void)setupContent;

- (void)definitionNavigation;

/** 初始化notification 子类实现*/
- (void)setupNotification;

/**
 进入后台, 子类自处理操作
 */
- (void)didEnterBackground;

/**
 子类dealloc调用
 */
- (void)subClassDealloc;

/**
 键盘弹起回调
 
 @param frame 键盘Frame
 @param duration 动画时间
 */
- (void)keyboardWillChangeFrame:(CGRect)frame duration:(NSTimeInterval)duration;

/**
 是否navi半透明
 */
- (BOOL)useTransparentNavigationBar;
@end
