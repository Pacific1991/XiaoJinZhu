//
//  UIImageView+HRCornerRadius.m
//  DrobDemo
//
//  Created by 李晋 on 2017/4/16.
//  Copyright © 2017年 李晋. All rights reserved.
//

#define lijinIMP self.image = [UIImage hr_imageWithRoundedCornersAndSize:self.bounds.size   \
CornerRadius:self.HRCornerRadio ? self.HRCornerRadio : 0                \
borderColor:self.HRStrokColor ? self.HRStrokColor : nil                 \
borderWidth:self.HRStrokWidth ? self.HRStrokWidth : DefaultStrokWidth   \
backgroundColor:[UIColor colorWithPatternImage:self.imageName ? [UIImage imageNamed:self.imageName] : self.image]                                                                                      \
groundColour:self.defaultBackColor                                                              \
backgroundImage:self.imageName ? [UIImage imageNamed:self.imageName] : self.image               \
withContentMode:self.contentMode];                                                              \

#define nameImp     self.image = [UIImage hr_imageWithRoundedCornersAndSize:self.bounds.size    \
CornerRadius:self.HRCornerRadio ? self.HRCornerRadio : 0                                        \
borderColor:self.HRStrokColor ? self.HRStrokColor : nil                                         \
borderWidth:self.HRStrokWidth ? self.HRStrokWidth : DefaultStrokWidth                           \
backgroundColor:[UIColor colorWithPatternImage:self.imageName ? [UIImage imageNamed:self.imageName] : self.image]                                                                                      \
groundColour:self.defaultBackColor                                                              \
backgroundImage:self.imageName ? [UIImage imageNamed:self.imageName] : self.image               \
withContentMode:self.contentMode];                                                              \

#import "UIImageView+HRCornerRadius.h"
#import <objc/runtime.h>

static char *DefaultBackColorKey = "DefaultBackColorKey";
static char *HRStrokColorKey = "HRStrokColorKey";
static char *HRCornerRadioKey = "HRCornerRadioKey";
static char *HRStrokWidthKey = "HRStrokWidthKey";
static char *HRRadiusKey = "HRRadiusKey";
static char *HRImageNameKey = "HRImageNameKey";
static char *HROriginalImageKey = "HROriginalImageKey";
static const CGFloat DefaultStrokWidth = 1.0f;

@implementation UIImageView (HRCornerRadius)

#pragma mark - getter&setter
- (void)setHRStrokWidth:(CGFloat)HRStrokWidth {
    objc_setAssociatedObject(self, HRStrokWidthKey, @(HRStrokWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)HRStrokWidth {
    
    return [objc_getAssociatedObject(self, HRStrokWidthKey) floatValue];
}

- (void)setHRCornerRadio:(CGFloat)HRCornerRadio {
    
    objc_setAssociatedObject(self, HRCornerRadioKey, @(HRCornerRadio), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)HRCornerRadio {
    
    return [objc_getAssociatedObject(self, HRCornerRadioKey) floatValue];
}

- (void)setDefaultBackColor:(UIColor *)defaultBackColor {
    objc_setAssociatedObject(self, DefaultBackColorKey, defaultBackColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)defaultBackColor {
    return objc_getAssociatedObject(self, DefaultBackColorKey);
}

- (void)setHRStrokColor:(UIColor *)HRStrokColor {
    objc_setAssociatedObject(self, HRStrokColorKey, HRStrokColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)HRStrokColor {
    
    return objc_getAssociatedObject(self, HRStrokColorKey);
}

- (void)setRadius:(HRRadius)radius {
    objc_setAssociatedObject(self, HRRadiusKey, @[@(radius.topLeftRadius), @(radius.topRightRadius), @(radius.bottomLeftRadius), @(radius.bottomRightRadius)], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HRRadius)radius {
    NSArray *obj = objc_getAssociatedObject(self, HRRadiusKey);
    HRRadius rad = HRRadiusMake([obj[0] floatValue], [obj[1] floatValue], [obj[2] floatValue], [obj[3] floatValue]);
    return rad;
}

- (void)setImageName:(NSString *)imageName {
    objc_setAssociatedObject(self, HRImageNameKey, imageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)imageName {
    return objc_getAssociatedObject(self, HRImageNameKey);
}

- (void)setOriginalImage:(UIImage *)originalImage {
    objc_setAssociatedObject(self, HROriginalImageKey, originalImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIImage *)originalImage {
    return objc_getAssociatedObject(self, HROriginalImageKey);
}

#pragma mark - 链式语法调用
- (UIImageView *(^)(CGFloat radio))cornerRadio {
    return ^(CGFloat radio){
        
        NSAssert(radio >= 0, @"It's Dosn't Bug!!!\nErrorName:cornerRadio must be value-valid\nMethodName:cornerRadio\nReason:Please set cornerRadio >= 0");
        self.HRCornerRadio = radio;
        lijinIMP
        return self;
    };
}

- (UIImageView *(^)(UIColor *strokColor))strokColor {
    return ^(UIColor *strokColor){
        NSAssert(strokColor != nil, @"It's Dosn't Bug!!!\nErrorName:strokColor should not be nil\nMethodName:strokColor\nReason:Please set strokColor valid");
        self.HRStrokColor = strokColor;
        lijinIMP
        return self;
    };
}

- (UIImageView *(^)(CGFloat strokWidth))strokWidth {
    return ^(CGFloat strokWidth){
        NSAssert(strokWidth >= 0, @"It's Dosn't Bug!!!\nErrorName:strokWidth must be value-valid\nMethodName:strokWidth\nReason:Please set strokWidth >= 0");
        self.HRStrokWidth = strokWidth;
        lijinIMP
        return self;
    };
}

- (UIImageView *(^)(UIViewContentMode contentMode))HRContentMode {
    return ^(UIViewContentMode contentMode){
        self.contentMode = contentMode;
//        lijinIMP
        if (self.image) {
            
            self.image = [UIImage hr_imageWithRoundedCornersAndSize:self.bounds.size
                                                       CornerRadius:self.HRCornerRadio ? self.HRCornerRadio : 0
                                                        borderColor:self.HRStrokColor ? self.HRStrokColor : nil
                                                        borderWidth:self.HRStrokWidth ? self.HRStrokWidth : 0
                                                    backgroundColor:[UIColor colorWithPatternImage:self.imageName ? [UIImage imageNamed:self.imageName] : self.image]
                                                       groundColour:self.defaultBackColor ? self.defaultBackColor : [UIColor whiteColor]
                                                    backgroundImage:self.imageName ? [UIImage imageNamed:self.imageName] : self.image
                                                    withContentMode:contentMode];
        }

        return self;
    };
}

- (UIImageView *(^)(HRRadius radius))HRRadius {
    return ^(HRRadius radius){
        self.radius = radius;
        self.HRCornerRadio = 0;
        if (self.image) {
            self.image = [UIImage hr_imageWithRoundedCornersAndSize:self.bounds.size
                                                           JMRadius:radius
                                                        borderColor:[UIColor whiteColor]
                                                        borderWidth:0.2
                                                    backgroundColor:nil
                                                       groundColour:self.defaultBackColor ? self.defaultBackColor : [UIColor whiteColor]
                                                    backgroundImage:self.imageName ? [UIImage imageNamed:self.imageName] : self.image
                                                    withContentMode:self.contentMode];
        }
        return self;
    };
}

- (UIImageView *(^)(UIColor *defaultColor))defaultBackgroundColor {
    return ^(UIColor *defaultColor){
        self.defaultBackColor = defaultColor;
        lijinIMP
        return self;
    };
}

- (UIImageView *(^)(NSString *name))imageNamed {
    return ^(NSString *name){
        
        NSAssert(name.length > 0, @"name lenth can't 0");
        self.image = [UIImage imageNamed:name];
        self.imageName = name;
        return self;
    };
}



#pragma mark - Setting Method
- (void)HRsetCornerRadio:(CGFloat)radio strokColor:(UIColor *)strokColor {
    
//    NSAssert(self.image != nil, @"It's Dosn't Bug!!!\nErrorName:nil image for corner\nMethodName:HRsetCornerRadio:\nReason:Please set cornerRadio Below setImage:");
    self.HRCornerRadio = radio;
    self.HRStrokColor = strokColor;
    lijinIMP
}

#pragma mark - Setting WithImageNamed
- (void)HRsetImageNamed:(NSString *)imageName cornerRadio:(CGFloat)cornerRadio {
    if (!imageName.length) {
        return;
    }
    self.HRCornerRadio = cornerRadio;
    self.imageName = imageName;
    CGFloat strokWidth = 0;
    if (self.HRStrokColor != nil) {
        if (self.HRStrokWidth) {
            strokWidth = self.HRStrokWidth;
        } else {
            strokWidth = DefaultStrokWidth;
        }
    }
    self.image = [UIImage hr_imageWithRoundedCornersAndSize:self.bounds.size
                                               CornerRadius:self.HRCornerRadio
                                                borderColor:self.HRStrokColor ? self.HRStrokColor : nil
                                                borderWidth:strokWidth
                                            backgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:imageName]]
                                               groundColour:self.defaultBackColor
                                            backgroundImage:[UIImage imageNamed:imageName]
                                            withContentMode:self.contentMode];
}

- (void)HRsetImageNamed:(NSString *)imageName StrokColor:(UIColor *)strokColor {
    if (!imageName.length) {
        return;
    }
    self.HRStrokColor = strokColor;
    self.imageName = imageName;
    nameImp
}

- (void)HRsetImageNamed:(NSString *)imageName cornerRadio:(CGFloat)cornerRadio strokColor:(UIColor *)strokColor {
    if (!imageName.length) {
        return;
    }
    self.HRCornerRadio = cornerRadio;
    self.HRStrokColor = strokColor;
    self.imageName = imageName;
    nameImp
}

- (void)HRsetImageNamed:(NSString *)imageName cornerRadio:(CGFloat)cornerRadio strokColor:(UIColor *)strokColor strokWidth:(CGFloat)strokWidth {
    if (!imageName.length) {
        return;
    }
    self.HRCornerRadio = cornerRadio;
    self.HRStrokColor = strokColor;
    self.HRStrokWidth = strokWidth;
    self.imageName = imageName;
    nameImp
}

#pragma mark - load Swizzling
+ (void)load {
    [super load];
    
//    Method setImageMethod = class_getInstanceMethod([self class], @selector(setImage:));
//    Method ljSetImageMethod = class_getInstanceMethod([self class], @selector(lj_setImage:));
//    if (!class_addMethod([self class], @selector(setImage:), method_getImplementation(ljSetImageMethod), method_getTypeEncoding(ljSetImageMethod))) {
//        method_exchangeImplementations(setImageMethod, ljSetImageMethod);
//    }
    
//    Method setFrameMethod = class_getInstanceMethod([self class], @selector(setFrame:));
//    Method ljSetFrameMethod = class_getInstanceMethod([self class], @selector(lj_setFrame:));
//    if (!class_addMethod([self class], @selector(setFrame:), method_getImplementation(ljSetFrameMethod), method_getTypeEncoding(ljSetFrameMethod))) {
//        method_exchangeImplementations(setFrameMethod, ljSetFrameMethod);
//    }
    
//    Method setBackgroundColorMethod = class_getInstanceMethod([self class], @selector(setBackgroundColor:));
//    Method ljSetBackgroundColorMethod = class_getInstanceMethod([self class], @selector(lj_setBackgroundColor:));
//    if (!class_addMethod([self class], @selector(setBackgroundColor:), method_getImplementation(ljSetBackgroundColorMethod), method_getTypeEncoding(ljSetBackgroundColorMethod))) {
//        method_exchangeImplementations(setBackgroundColorMethod, ljSetBackgroundColorMethod);
//    }
}

//- (void)setBackgroundColor:(UIColor *)backgroundColor {
//    [super setBackgroundColor:backgroundColor];
//    self.defaultBackColor = backgroundColor;
//    if (self.image) {
//        lijinIMP
//    }
//}

//- (void)lj_setBackgroundColor:(UIColor *)backgroundColor {
//    [self lj_setBackgroundColor:backgroundColor];
//}

//- (void)setFrame:(CGRect)frame {
//    [super setFrame:frame];
//    
//    if (self.backgroundColor) {
//        self.defaultBackColor = self.backgroundColor;
//    }
//    if (self.image) {
//        
//        self.image = [UIImage hr_imageWithRoundedCornersAndSize:frame.size
//                                                   CornerRadius:self.HRCornerRadio ? self.HRCornerRadio : 0
//                                                    borderColor:self.HRStrokColor ? self.HRStrokColor : nil
//                                                    borderWidth:self.HRStrokWidth ? self.HRStrokWidth : 0
//                                                backgroundColor:[UIColor colorWithPatternImage:self.image]
//                                                   groundColour:self.defaultBackColor
//                                                backgroundImage:self.image
//                                                withContentMode:self.contentMode];
//    }
//}

//- (void)setImage:(UIImage *)image {
//    
//}
//
//- (void)lj_setImage:(UIImage *)image {
//    
//    if (self.backgroundColor) {
//        self.defaultBackColor = self.backgroundColor;
//    }
//    if (self.HRCornerRadio != 0) {
//        
//        image = [UIImage hr_imageWithRoundedCornersAndSize:self.bounds.size
//                                              CornerRadius:self.HRCornerRadio ? self.HRCornerRadio : 0
//                                               borderColor:self.HRStrokColor ? self.HRStrokColor : nil
//                                               borderWidth:self.HRStrokWidth ? self.HRStrokWidth : 0
//                                           backgroundColor:[UIColor colorWithPatternImage:image]
//                                              groundColour:self.defaultBackColor ? self.defaultBackColor : [UIColor whiteColor]
//                                           backgroundImage:image
//                                           withContentMode:self.contentMode];
//    } else {
//        image = [UIImage hr_imageWithRoundedCornersAndSize:self.bounds.size
//                                                       JMRadius:self.radius
//                                                    borderColor:[UIColor whiteColor]
//                                                    borderWidth:0.2
//                                                backgroundColor:nil
//                                                   groundColour:self.defaultBackColor ? self.defaultBackColor : [UIColor whiteColor]
//                                                backgroundImage:image
//                                                withContentMode:self.contentMode];
//    }
//    [self lj_setImage:image];
//}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        self.defaultBackColor = newSuperview.backgroundColor;
//        lijinIMP
    }
}

@end

#pragma mark - UIImage Gategory
@implementation UIImage (HRImageRoundedCorner)

- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius andSize:(CGSize)size backgroundColor:(UIColor *)backColor strokColor:(UIColor *)strokColor strokWidth:(CGFloat)strokWidth {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    if (backColor) {
        [backColor setFill];
    } else {
        [[UIColor whiteColor] setFill];
    }
    UIRectFill(rect);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    
    if (strokColor){
        [strokColor setStroke];
        path.lineWidth = strokWidth?strokWidth:1.0;
        [path stroke];
    }
    
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - newMethod
- (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius groundColour:(UIColor *)groundColour {
    return [UIImage hr_imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:nil borderWidth:0 backgroundColor:nil groundColour:groundColour backgroundImage:self withContentMode:UIViewContentModeScaleAspectFill];
}

- (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius groundColour:(UIColor *)groundColour withContentMode:(UIViewContentMode)contentMode {
    return [UIImage hr_imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:nil borderWidth:0 backgroundColor:nil groundColour:groundColour backgroundImage:self withContentMode:contentMode];
}

+ (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor groundColour:(UIColor *)groundColour borderWidth:(CGFloat)borderWidth {
    return [UIImage hr_imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:borderColor borderWidth:borderWidth backgroundColor:nil groundColour:groundColour backgroundImage:nil withContentMode:UIViewContentModeScaleToFill];
}

+ (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit andCornerRadius:(CGFloat)radius andColor:(UIColor *)color groundColour:(UIColor *)groundColour {
    return [UIImage hr_imageWithRoundedCornersAndSize:sizeToFit CornerRadius:radius borderColor:nil borderWidth:0 backgroundColor:color groundColour:groundColour backgroundImage:nil withContentMode:UIViewContentModeScaleToFill];
}

+ (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit CornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor groundColour:(UIColor *)groundColour backgroundImage:(UIImage *)backgroundImage withContentMode:(UIViewContentMode)contentMode {
    return [UIImage hr_imageWithRoundedCornersAndSize:sizeToFit JMRadius:HRRadiusMake(radius, radius, radius, radius) borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor groundColour:groundColour backgroundImage:backgroundImage withContentMode:contentMode];
}

+ (UIImage *)hr_imageWithRoundedCornersAndSize:(CGSize)sizeToFit JMRadius:(HRRadius)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor groundColour:(UIColor *)groundColour backgroundImage:(UIImage *)backgroundImage withContentMode:(UIViewContentMode)contentMode {
    if (backgroundImage) {
        backgroundImage = [backgroundImage scaleToSize:CGSizeMake(sizeToFit.width, sizeToFit.height) withContentMode:contentMode backgroundColor:backgroundColor];
        backgroundColor = [UIColor colorWithPatternImage:backgroundImage];  // image->color
    } else if (!backgroundColor){
        backgroundColor = [UIColor whiteColor];
    }
    
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, YES, UIScreen.mainScreen.scale);
    if (groundColour) {
        
        [groundColour setFill];
    } else {
        [[UIColor whiteColor] setFill];
    }
    UIRectFill(CGRectMake(0, 0, sizeToFit.width, sizeToFit.height));
    
    CGFloat halfBorderWidth = borderWidth / 2;
    //设置上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //边框大小
    CGContextSetLineWidth(context, borderWidth);
    //边框颜色
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    //矩形填充颜色
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGFloat height = sizeToFit.height;
    CGFloat width = sizeToFit.width;
    radius = [UIImage transformationHRRadius:radius size:sizeToFit borderWidth:borderWidth];
    
    CGFloat startPointY;
    if (radius.topRightRadius >= height - borderWidth) {
        startPointY = height;
    } else if (radius.topRightRadius > 0){
        startPointY = halfBorderWidth + radius.topRightRadius;
    } else {
        startPointY = 0;
    }
    CGContextMoveToPoint(context, width - halfBorderWidth, startPointY);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width / 2, height - halfBorderWidth, radius.bottomRightRadius);  // 右下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height / 2, radius.bottomLeftRadius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width / 2, halfBorderWidth, radius.topLeftRadius); // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, height / 2, radius.topRightRadius); // 右上角
    if (borderColor && borderWidth) {
        
        CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    } else {
        
        CGContextDrawPath(context, kCGPathFill); //根据坐标绘制路径
    }
    
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outImage;
}

+ (HRRadius)transformationHRRadius:(HRRadius)radius size:(CGSize)size borderWidth:(CGFloat)borderWidth {
    radius.topLeftRadius = minimum(size.width - borderWidth, size.height - borderWidth, radius.topLeftRadius - borderWidth / 2);
    radius.topRightRadius = minimum(size.width - borderWidth - radius.topLeftRadius, size.height - borderWidth, radius.topRightRadius - borderWidth / 2);
    radius.bottomLeftRadius = minimum(size.width - borderWidth, size.height - borderWidth - radius.topLeftRadius, radius.bottomLeftRadius - borderWidth / 2);
    radius.bottomRightRadius = minimum(size.width - borderWidth - radius.bottomLeftRadius, size.height - borderWidth - radius.topRightRadius, radius.bottomRightRadius - borderWidth / 2);
    return radius;
}

static inline CGFloat minimum(CGFloat a, CGFloat b, CGFloat c) {
    CGFloat minimum = MIN(MIN(a, b), c);
    return MAX(minimum, 0);
}

- (UIImage *)scaleToSize:(CGSize)size withContentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, YES, UIScreen.mainScreen.scale);
    if (backgroundColor) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextAddRect(context, rect);
        CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
    }
    [self drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height) withContentMode:contentMode];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)drawInRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode {
    [self drawInRect:[self convertRect:rect withContentMode:contentMode]];
}

- (CGRect)convertRect:(CGRect)rect withContentMode:(UIViewContentMode)contentMode {
    CGSize size = self.size;
    rect = CGRectStandardize(rect);
    size.width = size.width < 0 ? -size.width : size.width;
    size.height = size.height < 0 ? -size.height : size.height;
    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    switch (contentMode) {
        case UIViewContentModeRedraw:
        case UIViewContentModeScaleAspectFit:
        case UIViewContentModeScaleAspectFill: {
            if (rect.size.width < 0.01 || rect.size.height < 0.01 ||
                size.width < 0.01 || size.height < 0.01) {
                rect.origin = center;
                rect.size = CGSizeZero;
            } else {
                CGFloat scale;
                if (contentMode == UIViewContentModeScaleAspectFill) {
                    if (size.width / size.height < rect.size.width / rect.size.height) {
                        scale = rect.size.width / size.width;
                    } else {
                        scale = rect.size.height / size.height;
                    }
                } else {
                    if (size.width / size.height < rect.size.width / rect.size.height) {
                        scale = rect.size.height / size.height;
                    } else {
                        scale = rect.size.width / size.width;
                    }
                }
                size.width *= scale;
                size.height *= scale;
                rect.size = size;
                rect.origin = CGPointMake(center.x - size.width * 0.5, center.y - size.height * 0.5);
            }
        } break;
        case UIViewContentModeCenter: {
            rect.size = size;
            rect.origin = CGPointMake(center.x - size.width * 0.5, center.y - size.height * 0.5);
        } break;
        case UIViewContentModeTop: {
            rect.origin.x = center.x - size.width * 0.5;
            rect.size = size;
        } break;
        case UIViewContentModeBottom: {
            rect.origin.x = center.x - size.width * 0.5;
            rect.origin.y += rect.size.height - size.height;
            rect.size = size;
        } break;
        case UIViewContentModeLeft: {
            rect.origin.y = center.y - size.height * 0.5;
            rect.size = size;
        } break;
        case UIViewContentModeRight: {
            rect.origin.y = center.y - size.height * 0.5;
            rect.origin.x += rect.size.width - size.width;
            rect.size = size;
        } break;
        case UIViewContentModeTopLeft: {
            rect.size = size;
        } break;
        case UIViewContentModeTopRight: {
            rect.origin.x += rect.size.width - size.width;
            rect.size = size;
        } break;
        case UIViewContentModeBottomLeft: {
            rect.origin.y += rect.size.height - size.height;
            rect.size = size;
        } break;
        case UIViewContentModeBottomRight: {
            rect.origin.x += rect.size.width - size.width;
            rect.origin.y += rect.size.height - size.height;
            rect.size = size;
        } break;
        case UIViewContentModeScaleToFill:
        default: {
            rect = rect;
        }
    }
    return rect;
}


@end
