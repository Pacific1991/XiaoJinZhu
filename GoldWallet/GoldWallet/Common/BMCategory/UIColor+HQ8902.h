//
//  UIColor+HQ8902.h
//  NewNeighbourIphone
//
//  Created by mac on 15/8/10.
//  Copyright (c) 2015年 com.wt.zainaer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HQ8902)

/** html颜色转RGB*/
+ (UIColor *)colorWithHexString: (NSString *)color;
+ (UIColor *)colorRandom;

/**16进制颜色字符串转UIColor*/
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
