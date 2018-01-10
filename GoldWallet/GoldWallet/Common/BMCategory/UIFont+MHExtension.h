//
//  UIFont+MHExtension.h
//  MHDevLibExample
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 Mike_He. All rights reserved.
//
/**
 *  Mike_He 但是苹方字体 iOS9.0+出现  需要做适配
 *  这个分类主要用来 字体...
 (
 "PingFangSC-Ultralight",
 "PingFangSC-Regular",
 "PingFangSC-Semibold",
 "PingFangSC-Thin",
 "PingFangSC-Light",
 "PingFangSC-Medium"
 )
 */

#import <UIKit/UIKit.h>

@interface UIFont (MHExtension)

/**
 *  苹方极细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) mh_fontForPingFangSC_UltralightFontOfSize:(CGFloat)fontSize;

/**
 *  苹方常规体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) mh_fontForPingFangSC_RegularFontOfSize:(CGFloat)fontSize;

/**
 *  苹方中粗体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) mh_fontForPingFangSC_SemiboldFontOfSize:(CGFloat)fontSize;

/**
 *  苹方纤细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) mh_fontForPingFangSC_ThinFontOfSize:(CGFloat)fontSize;

/**
 *  苹方细体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) mh_fontForPingFangSC_LightFontOfSize:(CGFloat)fontSize;

/**
 *  苹方中黑体
 *
 *  @param fontSize 字体大小
 *
 */
+(instancetype) mh_fontForPingFangSC_MediumFontOfSize:(CGFloat)fontSize;


@end
