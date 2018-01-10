//
//  HCTextView.m
//  HealthClaims
//
//  Created by 李晋 on 2017/10/9.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCTextView.h"
@interface HCTextView()
@property (weak, nonatomic) UILabel *placeholderLabel;
@end
@implementation HCTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self setUp];
    return self;
}

- (void)setUp {
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_placeholderLabel = placeholderLabel];
    
    self.hc_placeholderColor = [UIColor lightGrayColor];
    self.hc_placeholderFont = [UIFont systemFontOfSize:16.0f];
    self.font = [UIFont systemFontOfSize:16.0f];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - UITextViewTextDidChangeNotification

- (void)textDidChange {
    self.placeholderLabel.hidden = self.hasText;
}


- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}


- (void)setHc_placeholderFont:(UIFont *)hc_placeholderFont {
    _hc_placeholderFont = hc_placeholderFont;
    self.placeholderLabel.font = hc_placeholderFont;
    [self setNeedsLayout];
}

- (void)setHc_placeholder:(NSString *)hc_placeholder {
    _hc_placeholder = [hc_placeholder copy];
    
    self.placeholderLabel.text = hc_placeholder;
    
    [self setNeedsLayout];
    
}
- (void)noeditwith:(BOOL)isedit{
    self.editable = isedit;
}

- (void)setHc_placeholderColor:(UIColor *)hc_placeholderColor {
    _hc_placeholderColor = hc_placeholderColor;
    self.placeholderLabel.textColor = hc_placeholderColor;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.placeholderLabel.frame;
    frame.origin.y = self.textContainerInset.top;
    frame.origin.x = self.textContainerInset.left+6.0f;
    frame.size.width = self.frame.size.width - self.textContainerInset.left*2.0;
    
    CGSize maxSize = CGSizeMake(frame.size.width, MAXFLOAT);
    frame.size.height = [self.hc_placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    self.placeholderLabel.frame = frame;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}

@end
