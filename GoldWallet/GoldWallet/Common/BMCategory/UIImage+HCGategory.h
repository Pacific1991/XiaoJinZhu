//
//  UIImage+HCGategory.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/20.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HCGategory)
+ (UIImage *)resizeImageByTile:(NSString *)name;
+ (UIImage *)resizeImageByStretch:(NSString *)name;
+ (UIImage *)resizeImageByTile:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
+ (UIImage *)resizeImageByStretch:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

/**生成二维码*/
+ (UIImage *)QRImageForString:(NSString *)string imageSize:(CGFloat)imagesize logoImageSize:(CGFloat)waterImagesize;
/**给二维码中间添加logo*/
+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withSize:(CGFloat)size waterImageSize:(CGFloat)waterImagesize;
/**改变图片的渲染颜色*/
- (UIImage *)imageBlackToTransparentWithRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

/**
 *  全屏截图
 *
 *  @return UIImage对象
 */
+ (UIImage *)shotScreen;

/**
 *  截取一张View生成图片
 *
 *  @param view 要截取的View
 *
 *  @return UIImage对象
 */
+ (UIImage *)shotWithView:(UIView *)view;

/**
 *  截取view中某个区域生成一张图片
 *
 *  @param view  要截取的View
 *  @param scope 区域的Frame
 *
 *  @return UIImage对象
 */
+ (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope;

/**
 *  压缩图片到指定尺寸大小
 *
 *  @param image 要压缩的图片（原图）
 *  @param size  指定大小
 *
 *  @return UIImage对象
 */
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

/**
 *  压缩图片到指定文件大小
 *
 *  @param image 要压缩的图片（原图）
 *  @param size  文件大小，单位KB
 *
 *  @return 二进制数据NSData
 */
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

@end
