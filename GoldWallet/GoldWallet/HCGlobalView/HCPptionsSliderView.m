//
//  HCPptionsSliderView.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/29.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCPptionsSliderView.h"
#define LINEVIEWHEIGHT 1.5f
#define BTNTAGADDIN 10
@interface HCPptionsSliderView() {
    BOOL _equally;                          /// 是否平均分配宽度
    CGFloat _equallyButtonWidth;            /// 平均分布按钮宽度
    NSArray<NSString *> *_titleArray;
    
    UIButton *_selectedButton;              /// 已选中按钮
}
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;
@property (nonatomic, readwrite, strong) UIView *slideView;
@property (nonatomic, readwrite, strong) UILabel * linelabel;

@property (nonatomic, readwrite, copy) selectBtnCompeletion completion;
@end
@implementation HCPptionsSliderView

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
    }
    return _scrollView;
}

- (UIView *)slideView {
    if (!_slideView) {
        _slideView = [[UIView alloc] init];
    }
    return _slideView;
}


+ (instancetype)viewWithframe:(CGRect)frame equally:(BOOL)equally {
    
    HCPptionsSliderView *view = [[self alloc] initWithFrame:frame equally:equally];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        _maxcol = 0;
        _equallyButtonWidth = 0.0f;
        _tintColor = [UIColor colorWithHexString:@"#4A4A4A"];
        _selectColor = [UIColor colorWithHexString:@"#FF0000"];
        _fontSize = 14.0f;
        _scroll_line_spacing = 0;
        _slideViewScale = 0.5;
        _margin = 0.0f;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame equally:(BOOL)equally {
    
    self = [self initWithFrame:frame];
    if (self) {
        
        _equally = equally;
        [self prepareSubViews];
    }
    return self;
}

/**
 配置ScrollView
 */
- (void)prepareSubViews {
    
    self.scrollView.frame = self.bounds;
    [self addSubview:self.scrollView];
}

- (void)prepareSilderWithTitleArray:(NSArray<NSString *> *)titleArray handdle:(selectBtnCompeletion)handdle {
    NSAssert(titleArray, @"titleArray could not be nil");
    NSAssert(titleArray.count != 0, @"titleArray count can't be 0");
    self.completion = handdle;
    _equallyButtonWidth = self.bounds.size.width / titleArray.count;
    _titleArray = titleArray;
    [self.slideView setBackgroundColor:self.selectColor];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _linelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height-1, kScreenWidth(), 1.0)];
    _linelabel.backgroundColor = [UIColor colorWithHexString:@"#DEDEDE"];
    
    [self.scrollView addSubview:_linelabel];
    [self.scrollView addSubview:self.slideView];

  
    if (_equally) {
        
        [self equallyButtonLayout];
    } else {
        
        [self unEquallyButtonLayout];
    }
}

/**
 等宽按钮排列
 */
- (void)equallyButtonLayout {
    CGFloat btnWidth = _equallyButtonWidth;
    if (self.maxcol > 0) {
        btnWidth = self.bounds.size.width / self.maxcol;
    }
    @weakify(self)
    [_titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self)
        UIButton *titleBtn = [self establishButtonWithTitle:obj idx:idx];
        titleBtn.frame = CGRectMake(idx*(btnWidth + self.margin),
                                    0,
                                    btnWidth,
                                    self.bounds.size.height - self.scroll_line_spacing - LINEVIEWHEIGHT);
        [self.scrollView addSubview:titleBtn];
        if (idx == 0) {
            
            [self titleButtonClickAction:titleBtn];
        }
        if (idx == _titleArray.count - 1) {
            
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(titleBtn.frame), self.bounds.size.height);
        }
    }];
    self.slideView.frame = CGRectMake(btnWidth*(1-self.slideViewScale)*0.5, self.bounds.size.height - LINEVIEWHEIGHT, btnWidth*self.slideViewScale, LINEVIEWHEIGHT);
  
}

/**
 不等宽按钮排列
 */
- (void)unEquallyButtonLayout {
    __block CGFloat minBtnWidth = 0.0f;
    __block UIButton *lastButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *titleBtn = [self establishButtonWithTitle:obj idx:idx];
        CGSize titleSize = [NSString getwidthForStr:obj testFont:self.fontSize height:self.bounds.size.height - self.scroll_line_spacing - LINEVIEWHEIGHT];
        if (idx == 0) {
            minBtnWidth = titleSize.width;
        } else {
            if (minBtnWidth > titleSize.width) {
                
                (minBtnWidth = titleSize.width);
            }
        }
        titleBtn.frame = CGRectMake(CGRectGetMaxX(lastButton.frame),
                                    0,
                                    titleSize.width+Margin,
                                    self.bounds.size.height - self.scroll_line_spacing - LINEVIEWHEIGHT);
        [self.scrollView addSubview:titleBtn];
        if (idx == 0) {
            
            [self titleButtonClickAction:titleBtn];
        }
        if (idx == _titleArray.count - 1) {
            
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(titleBtn.frame), self.bounds.size.height);
        }
        lastButton = titleBtn;
    }];
    CGFloat fistBtnWidth = CGRectGetWidth([[self.scrollView viewWithTag:BTNTAGADDIN] frame]);
    self.slideView.frame = CGRectMake((fistBtnWidth - (minBtnWidth*self.slideViewScale))*0.5, self.bounds.size.height - LINEVIEWHEIGHT, minBtnWidth*self.slideViewScale, LINEVIEWHEIGHT);

}

/**
 创建按钮

 @param title title
 @param idx 下标
 @return button
 */
- (UIButton *)establishButtonWithTitle:(NSString *)title idx:(NSInteger)idx {
    
    UIButton *titleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    titleBtn.tag = BTNTAGADDIN+idx;
    [titleBtn setBackgroundColor:[UIColor whiteColor]];
    [titleBtn setTitleColor:self.tintColor forState:(UIControlStateNormal)];
    [titleBtn setTitleColor:self.selectColor forState:(UIControlStateSelected)];
    [titleBtn.titleLabel setFont:[UIFont systemFontOfSize:self.fontSize]];
    [titleBtn setTitle:title forState:(UIControlStateNormal)];
    [titleBtn setTitle:title forState:(UIControlStateSelected)];
    [titleBtn addTarget:self action:@selector(titleButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    return titleBtn;
}

#pragma mark - 按钮点击事件
- (void)titleButtonClickAction:(UIButton *)sender {
    if (_selectedButton != sender) {
        _selectedButton.selected = NO;
        _selectedButton = sender;
        _selectedButton.selected = YES;
        if (self.completion) {
            
            self.completion(sender.titleLabel.text, sender.tag - BTNTAGADDIN);
        }
        [UIView animateWithDuration:0.3 animations:^{
            
            self.slideView.centerX = sender.centerX;
        }];
    }
}

- (void)changeCurrentSelectedButtonWithIdx:(NSInteger)idx {
    UIButton *button = [_scrollView viewWithTag:BTNTAGADDIN+idx];
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.slideView.centerX = _selectedButton.centerX;
    }];
}

@end
