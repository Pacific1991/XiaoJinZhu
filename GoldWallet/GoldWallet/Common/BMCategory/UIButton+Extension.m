//
//  UIButton+HCGategory.h
//  HealthClaims
//
//  Created by sdd on 2017/9/26.
//  Copyright © 2017年 fmf. All rights reserved.
//
#import "UIButton+Extension.h"
#import <objc/runtime.h>
@implementation UIButton (Extension)



@dynamic hitTestEdgeInsets;

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";


-(void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}


- (void)verticalImageAndTitle:(CGFloat)spacing{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

- (void)myVerticalImageAndTitle:(CGFloat)spacing{
    
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width - spacing, - (totalHeight - titleSize.height + spacing - 5), 0);
    
}

- (void)leftImageAndRightText:(CGFloat)spacing{
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width - spacing, 0, self.imageView.frame.size.width + spacing)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width + spacing, 0, -self.titleLabel.bounds.size.width - spacing)];
    
}

- (void)leftTextAndRightImage:(CGFloat)spacing{
    
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.imageView.frame.size.width - spacing, 0, self.imageView.frame.size.width + spacing)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width + spacing, 0, -self.titleLabel.bounds.size.width - spacing)];
    
}


@end
