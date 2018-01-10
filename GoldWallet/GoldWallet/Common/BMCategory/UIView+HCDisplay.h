//
//  UIView+HCDisplay.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/23.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HCDisplay)
/**
 *  绘制虚线
 *
 *  @param lineFrame 虚线的Frame
 *  @param length    虚线中短线的宽度
 *  @param spacing   虚线中短线之间的间距
 *  @param color     虚线中短线的颜色
 *
 *  @return UIView对象
 */
+ (UIView *)createDashedLineWithFrame:(CGRect)lineFrame
                           lineLength:(int)length
                          lineSpacing:(int)spacing
                            lineColor:(UIColor *)color;

@end
