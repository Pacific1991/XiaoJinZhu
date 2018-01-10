//
//  HCFont.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/20.
//  Copyright © 2017年 fmf. All rights reserved.
//

#ifndef HCFont_h
#define HCFont_h
#import "UIFont+MHExtension.h"

/**设置系统的字体大小（YES：粗体 NO：常规）*/
NS_INLINE UIFont * MHFont(CGFloat size, BOOL isBold) {
    return isBold ? [UIFont boldSystemFontOfSize:size] : [UIFont systemFontOfSize:size];
}

/** 极细体 */
NS_INLINE UIFont * MHUltralightFont(CGFloat size) {
    return [UIFont mh_fontForPingFangSC_UltralightFontOfSize:size];
}

/** 中粗体 */
NS_INLINE UIFont * MHSemiboldFont(CGFloat size) {
    return [UIFont mh_fontForPingFangSC_SemiboldFontOfSize:size];
}

/** 纤细体 */
NS_INLINE UIFont * MHThinFont(CGFloat size) {
    return [UIFont mh_fontForPingFangSC_ThinFontOfSize:size];
}

/** 细体 */
NS_INLINE UIFont * MHLightFont(CGFloat size) {
    return [UIFont mh_fontForPingFangSC_LightFontOfSize:size];
}
// 该项目 主要使用以下三种字体
// 中等
NS_INLINE UIFont * MHMediumFont(CGFloat size) {
    return kIOSVersion() < 9.0 ? MHFont(size, NO) : [UIFont mh_fontForPingFangSC_RegularFontOfSize:size];
}

// 常规
NS_INLINE UIFont * MHRegularFont(CGFloat size) {
    return [UIFont mh_fontForPingFangSC_RegularFontOfSize:size];
}

/**
 *  Frame PX  ---> Pt 6的宽度 全部向下取整数
 */
NS_INLINE CGFloat MHPxConvertPt(CGFloat px) {
    return floor(px * kWidthScale());
}

/**  评论内容字体大小 */
NS_INLINE UIFont * CommentTextFont() {
    return MHMediumFont(12);
}
/** --------------------------------------------------- */
/** 评论姓名字体大小 */
NS_INLINE UIFont *EvaluationNameFont() {
    return MHMediumFont(13 * kWidthScale());
}
/** 评论时间字体大小 */
NS_INLINE UIFont *EvaluationTimeFont() {
    return MHLightFont(13 * kWidthScale());
}

/** 评论内容字体大小 */
NS_INLINE UIFont *EvaluationContentFont() {
    return MHMediumFont(14 * kWidthScale());
}

/**  话题昵称字体大小 */
NS_INLINE UIFont * TopicNicknameFont() {
    return MHMediumFont(10);
}

/**  显示更多内容字体大小 */
NS_INLINE UIFont * TopicMoreContentFont() {
    return MHMediumFont(11);
}

/**  显示更多内容字体大小 */
NS_INLINE UIFont * TopicTimeFont() {
    return MHMediumFont(11);
}

/**  删除动态按钮字体大小*/
NS_INLINE UIFont * DeleteTitleFont() {
    return MHMediumFont(11);
}

/**  显示更多内容字体大小 */
NS_INLINE UIFont * TopicLikeListFont() {
    return MHMediumFont(13);
}

NS_INLINE UIFont * TopicListFont(NSInteger size) {
    return MHMediumFont(size);
}
#endif /* HCFont_h */
