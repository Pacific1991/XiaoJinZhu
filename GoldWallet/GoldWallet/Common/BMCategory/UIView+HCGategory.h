//
//  UIView+HCGategory.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/20.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HCGategory)
- (CGFloat)x;

- (CGFloat)y;

- (CGFloat)width;

- (CGFloat)height;

- (CGPoint)origin;

- (CGSize)size;

- (CGFloat)centerX;

- (CGFloat)centerY;

- (CGFloat)bottom;

- (void)setX:(CGFloat)x;

- (void)setY:(CGFloat)y;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

- (void)setOrigin:(CGPoint)origin;

- (void)setSize:(CGSize)size;

- (void)setCenterX:(CGFloat)centerX;

- (void)setCenterY:(CGFloat)centerY;

- (void)setBottom: (CGFloat) newbottom;

- (UIViewController *)viewController;
@end
