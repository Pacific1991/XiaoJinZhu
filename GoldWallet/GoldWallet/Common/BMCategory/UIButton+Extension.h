//
//  UIButton+HCGategory.h
//  HealthClaims
//
//  Created by sdd on 2017/9/26.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 *  点击事件触发范围
 *  输入 正数表示缩小, 负数表示扩大
 */
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;


/**
 *  上图片 下文字
 *
 *  @param spacing 间距
 */
- (void)verticalImageAndTitle:(CGFloat)spacing;

- (void)myVerticalImageAndTitle:(CGFloat)spacing;

/**
 *  左图片 右文字
 *
 *  @param spacing 间距
 */
- (void)leftImageAndRightText:(CGFloat)spacing;


/**
 *  左文字 右图片
 *
 *  @param spacing 间距
 */
- (void)leftTextAndRightImage:(CGFloat)spacing;

@end
