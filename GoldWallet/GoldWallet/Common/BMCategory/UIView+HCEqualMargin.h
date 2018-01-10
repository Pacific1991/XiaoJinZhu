//
//  UIView+HCEqualMargin.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/25.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HCEqualMargin)
//- (void) distributeSpacingHorizontallyWith:(NSArray*)views;
- (void) distributeSpacingHorizontallyWith:(NSArray*)views spacing:(CGFloat)spacing;
- (void) distributeSpacingVerticallyWith:(NSArray*)views;
@end
