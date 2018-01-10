//
//  HCTextView.h
//  HealthClaims
//
//  Created by 李晋 on 2017/10/9.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCTextView : UITextView
@property (copy, nonatomic, nullable) IBInspectable NSString *hc_placeholder;

@property (strong, nonatomic, nullable) IBInspectable UIColor *hc_placeholderColor;

@property (strong, nonatomic, nullable) UIFont *hc_placeholderFont;

- (void)noeditwith:(BOOL)isedit;

@end
