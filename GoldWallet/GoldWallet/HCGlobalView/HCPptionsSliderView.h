//
//  HCPptionsSliderView.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/29.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectBtnCompeletion)(NSString *title, NSInteger idx);
@interface HCPptionsSliderView : UIView
@property (nonatomic, readwrite, assign) NSInteger maxcol;              /// 做多按钮个数  超过开始滚动
@property (nonatomic, readwrite, strong) UIColor *tintColor;            /// 按钮主题色
@property (nonatomic, readwrite, strong) UIColor *selectColor;          /// 选中颜色
@property (nonatomic, readwrite, assign) CGFloat fontSize;              /// 字体
@property (nonatomic, readwrite, assign) CGFloat slideViewScale;        /// 滑动条相对按钮比例<0~1>
@property (nonatomic, readwrite, assign) CGFloat margin;                /// 按钮间隔

@property (nonatomic, readwrite, assign) CGFloat scroll_line_spacing;   ///

+ (instancetype)viewWithframe:(CGRect)frame equally:(BOOL)equally;
- (void)prepareSilderWithTitleArray:(NSArray<NSString *> *)titleArray handdle:(selectBtnCompeletion)handdle;
- (void)changeCurrentSelectedButtonWithIdx:(NSInteger)idx;
@end
