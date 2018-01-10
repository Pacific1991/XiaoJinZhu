//
//  HCGeneralMacro.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/20.
//  Copyright © 2017年 fmf. All rights reserved.
//

#ifndef HCGeneralMacro_h
#define HCGeneralMacro_h

/** defines */

/// UIColor
#define HCColor(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0)  blue:(b/255.0)  alpha:1.0]
#define HCColorAlpha(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0)  blue:(b/255.0)  alpha:(a/1.0)]
#define HCTableViewColor [UIColor colorWithHexString:@"#F6F6F6"]
#define KTableSeporateColor [UIColor colorWithHexString:@"#C8C7CC"]

/// NSLog
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"<%s : %d> %s  " fmt), [[[NSString stringWithUTF8String:__FILE__] lastPathComponent]   UTF8String], __LINE__, __PRETTY_FUNCTION__,  ##__VA_ARGS__);
#else
#define NSLog(...)
#endif /* DEBUG */

/// Toast 提示
#define HCToast(str) CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
[kWindow() makeToast:str duration:0.6 position:CSToastPositionCenter style:style];\
kWindow().userInteractionEnabled = NO; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
kWindow().userInteractionEnabled = YES;\
});\

/// 判断当前语言
#define HCCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#endif /* HCGeneralMacro_h */
