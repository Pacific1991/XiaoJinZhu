//
//  HCDatePicker.h
//  HealthClaims
//
//  Created by 李晋 on 2017/10/14.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^changedDate)(NSString *dateString);
@interface HCDatePicker : UIDatePicker
@property (nonatomic, readwrite, copy) NSString *currentDateString;
@property (nonatomic, readwrite, copy) changedDate selectedAction;

+ (instancetype)pickerWithFrame:(CGRect)frame
                backgroundColor:(UIColor *)backgroundColor
                           mode:(UIDatePickerMode)mode
                        maxDate:(NSDate *)maxDate
                        minDate:(NSDate *)minDate
                    dateFormate:(NSString *)dateFormate;

@end
