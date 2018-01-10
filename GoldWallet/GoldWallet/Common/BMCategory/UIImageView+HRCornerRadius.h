//
//  UIImageView+HRCornerRadius.h
//  DrobDemo
//
//  Created by 李晋 on 2017/4/16.
//  Copyright © 2017年 李晋. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark - UIImage Gategory
struct HRRadius {
    CGFloat topLeftRadius;
    CGFloat topRightRadius;
    CGFloat bottomLeftRadius;
    CGFloat bottomRightRadius;
};
typedef struct HRRadius HRRadius;
CG_INLINE HRRadius HRRadiusMake(CGFloat topLeftRadius, CGFloat topRightRadius, CGFloat bottomLeftRadius, CGFloat bottomRightRadius);

CG_INLINE HRRadius HRRadiusMake(CGFloat topLeftRadius, CGFloat topRightRadius, CGFloat bottomLeftRadius, CGFloat bottomRightRadius) {
    HRRadius radius;
    radius.topLeftRadius = topLeftRadius;
    radius.topRightRadius = topRightRadius;
    radius.bottomLeftRadius = bottomLeftRadius;
    radius.bottomRightRadius = bottomRightRadius;
    return radius;
}
@interface UIImage (HRImageRoundedCorner)
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size backgroundColor:(UIColor *)backColor strokColor:(UIColor *)strokColor strokWidth:(CGFloat)strokWidth;

#pragma mark - newMethod 
#pragma mark - groundColour: 背景色
#pragma mark - backgroundColor: !backgroundImage -> backgroundColor
- (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius groundColour:(UIColor *)groundColour;
- (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius groundColour:(UIColor *)groundColour withContentMode:(UIViewContentMode)contentMode;

+ (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor groundColour:(UIColor *)groundColour borderWidth:(CGFloat)borderWidth;

+ (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius andColor:(UIColor *)color groundColour:(UIColor *)groundColour;

+ (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor groundColour:(UIColor *)groundColour backgroundImage:(UIImage *)backgroundImage withContentMode:(UIViewContentMode)contentMode;

+ (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit JMRadius:(HRRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor groundColour:(UIColor *)groundColour backgroundImage:(UIImage *)backgroundImage withContentMode:(UIViewContentMode)contentMode;
@end

#pragma mark - UIImageView Gategory
@interface UIImageView (HRCornerRadius)

/// Record property, Don't separate set please
@property (nonatomic, readwrite, strong) NSString *imageName;       //
@property (nonatomic, readwrite, strong) UIImage *originalImage;    // 原图
@property (nonatomic, readwrite, strong) UIColor *defaultBackColor; // imageView背景色
@property (nonatomic, readwrite, strong) UIColor *HRStrokColor;     // 边框颜色
@property (nonatomic, readwrite, assign) CGFloat HRCornerRadio;     // 圆角弧度
@property (nonatomic, readwrite, assign) CGFloat HRStrokWidth;
@property (nonatomic, readwrite, assign) HRRadius radius;           // 弧度
/**
 The chain calls
 */
- (UIImageView *(^)(CGFloat radio))cornerRadio;

- (UIImageView *(^)(UIColor *strokColor))strokColor;

- (UIImageView *(^)(CGFloat strokWidth))strokWidth;

- (UIImageView *(^)(UIColor *defaultColor))defaultBackgroundColor;

- (UIImageView *(^)(NSString *name))imageNamed;

- (UIImageView *(^)(UIViewContentMode contentMode))HRContentMode;

- (UIImageView *(^)(HRRadius radius))HRRadius;

/**
 setRadio: strokColor

 @param radio 弧度
 @param strokColor 边框色
 */
- (void)HRsetCornerRadio:(CGFloat)radio strokColor:(UIColor *)strokColor;

/**
 ImageWithNamed:

 @ imageName lenth=0 设置失效
 @ radio 弧度
 */
- (void)HRsetImageNamed:(NSString *)imageName cornerRadio:(CGFloat)cornerRadio;

/**
 named:strok:

 @ imageName
 @ strokColor 边框色
 */
- (void)HRsetImageNamed:(NSString *)imageName StrokColor:(UIColor *)strokColor;

/**
 named: radio: strok

 imageName
 cornerRadio
 strokColor
 */
- (void)HRsetImageNamed:(NSString *)imageName cornerRadio:(CGFloat)cornerRadio strokColor:(UIColor *)strokColor;


- (void)HRsetImageNamed:(NSString *)imageName cornerRadio:(CGFloat)cornerRadio strokColor:(UIColor *)strokColor strokWidth:(CGFloat)strokWidth;
@end
