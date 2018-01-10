//
//  HCDatePicker.m
//  HealthClaims
//
//  Created by 李晋 on 2017/10/14.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCDatePicker.h"
@interface HCDatePicker()
@property (nonatomic, readwrite, strong) UIColor *backgroundColor;
@property (nonatomic, readwrite, copy) NSString *dateFormate;
@property (nonatomic, readwrite, strong) NSDate *maxDate;
@property (nonatomic, readwrite, strong) NSDate *minDate;
@end
@implementation HCDatePicker

+ (instancetype)pickerWithFrame:(CGRect)frame
                backgroundColor:(UIColor *)backgroundColor
                           mode:(UIDatePickerMode)mode
                        maxDate:(NSDate *)maxDate
                        minDate:(NSDate *)minDate
                    dateFormate:(NSString *)dateFormate {
    HCDatePicker *picker = [[HCDatePicker alloc] initWithFrame:frame];
    picker.datePickerMode = mode;
    picker.dateFormate = dateFormate;
    picker.backgroundColor = backgroundColor;
    picker.maxDate = maxDate;
    picker.minDate = minDate;
    [picker configuration];
    return picker;
}

- (void)configuration {
    self.backgroundColor = self.backgroundColor;
    [self addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    //默认根据手机本地设置显示为中文还是其他语言
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
    self.locale = locale;
    //当前时间创建NSDate
    NSDate *localDate = [NSDate date];
    //在当前时间加上的时间：格里高利历
    //    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    //设置时间
    [offsetComponents setYear:4];
    [offsetComponents setMonth:2];
    [offsetComponents setDay:2];
    [offsetComponents setHour:20];
    [offsetComponents setMinute:0];
    [offsetComponents setSecond:0];
    //设置最小值时间
    if (self.maxDate) {
        self.maximumDate = self.minDate;
    }
    if (self.minDate) {
        self.minimumDate = self.minDate;
    }
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:self.dateFormate];
    self.currentDateString = [pickerFormatter stringFromDate:localDate];
}

-(void)dateChanged:(UIDatePicker *)sender{
    
    //NSDate格式转换为NSString格式
    NSDate *pickerDate = [sender date];
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];
    [pickerFormatter setDateFormat:self.dateFormate];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    if (self.selectedAction) {
        self.selectedAction(dateString);
    }
}


@end
