//
//  UIButton+HCGategory.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/26.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "UIButton+HCGategory.h"

@implementation UIButton (HCGategory)
/**
 Button图片/文字 (上/下)
 @param spacing 图片文字间距
 */
- (void)verticalImageAndTitle:(CGFloat)spacing {
//    self.titleLabel.backgroundColor = [UIColor greenColor];
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}]; // [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

@end
