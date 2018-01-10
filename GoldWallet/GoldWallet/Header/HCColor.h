//
//  HCColor.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/30.
//  Copyright © 2017年 fmf. All rights reserved.
//

#ifndef HCColor_h
#define HCColor_h

#import "UIColor+HQ8902.h"

//黑色文字
NS_INLINE UIColor * kBlackTextColor() {
    return [UIColor colorWithHexString:@"#4A4A4A"];
}

//灰色文字
NS_INLINE UIColor * kGrayTextColor() {
    return [UIColor colorWithHexString:@"#919191"];
}

//细下滑线颜色 以及分割线颜色
NS_INLINE UIColor * kBottomLineColor() {
    
    return [UIColor colorWithHexString:@"#d6d7dc"];
}

NS_INLINE UIColor *kLineColor() {
    return [UIColor colorWithHexString:@"#DEDEDE"];
}

// 微信支付绿
NS_INLINE UIColor *kWeChatPayGreen() {
    return [UIColor colorWithHexString:@"#00B700"];
}

// 阿里支付蓝
NS_INLINE UIColor *kAliPayBlue() {
    return [UIColor colorWithHexString:@"#00A0E9"];
}

// 银联支付红
NS_INLINE UIColor *kUnionPayRed() {
    return [UIColor colorWithHexString:@"#E03333"];
}

#endif /* HCColor_h */
