//
//  NSString+HCString.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/20.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "NSString+HCString.h"
#import <CommonCrypto/CommonDigest.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation NSString (HCString)
+(CGSize)getwidthForStr:(NSString*)str testFont:(CGFloat)font height:(CGFloat)height {
    CGSize titleSize = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return titleSize;
}

+ (CGSize)getHeightForStr:(NSString*)str testFont:(CGFloat)font with:(CGFloat)with {
    CGSize titleSize = [str boundingRectWithSize:CGSizeMake(with, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return titleSize;
}

#pragma mark - URL编码
- (NSString *)URLEncodedString {
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    return encodedString;
}

#pragma mark - URL解码
- (NSString *)URLDecodedString {
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

#pragma mark - 货币格式化
+ (NSString *)hc_moneyStringWithMoney:(CGFloat)money {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:money]];
    return formattedNumberString;
}

#pragma mark - 数字单位(万) 格式化
+ (NSString *)hc_unitStringWithCount:(NSInteger)count {
    CGFloat result = count / 10000.0;
    CGFloat bilResult = result / 10000;
    if (bilResult < 1) {
        if (result > 1) {
            return [NSString stringWithFormat:@"%.2f万", result];
        } else {
            return [NSString stringWithFormat:@"%ld", (long)count];
        }
    } else {
        return [NSString stringWithFormat:@"%.2f亿", bilResult];
    }
}

+ (NSString *)hc_unitStringWithNum:(CGFloat)num {
    CGFloat result = num / 10000.0;
    CGFloat bilResult = result / 10000;
    if (bilResult < 1) {
        if (result > 1) {
            return [NSString stringWithFormat:@"%.2f万", result];
        } else {
            return [NSString stringWithFormat:@"%.2f", num];
        }
    } else {
        return [NSString stringWithFormat:@"%.2f亿", bilResult];
    }
}

#pragma mark - 电话号码加空格
+ (NSString *)hc_addBlankWithPhoneNumber:(NSString *)number {
    NSString *str = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < str.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        [result appendString:[str substringWithRange:range]];
        if (i == 2 || i == 6) {
            [result appendString:@" "];
        }
    }
    return [result copy];
}

+ (NSString *)hc_stringWithTimeStamp:(NSNumber *)timeStamp {
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    //将当前时间转化为时间戳
    NSTimeInterval currentDateStamp = [currentDate timeIntervalSince1970] + 8 * kAnHour;
    //将传入的参数转化为时间戳
    double dateStamp = [timeStamp doubleValue] + 8 * kAnHour;
    //计算时间间隔，即当前时间减去传入的时间
    double interval = currentDateStamp - dateStamp;
    //获取当前时间的小时单位（24小时制）
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"H"];
    int nowHour = [[formatter stringFromDate:currentDate] intValue];
    //获取当前时间的分钟单位
    NSDateFormatter *minFormatter = [NSDateFormatter new];
    [minFormatter setDateFormat:@"m"];
    int nowMinute = [[minFormatter stringFromDate:currentDate] intValue];
    //今天0点的时间戳
    double todayZeroClock = currentDateStamp - kAnHour * nowHour - kAMinute * nowMinute;
    //时间格式化，为输出做准备
    NSDateFormatter *outputFormat = [NSDateFormatter new];
    [outputFormat setDateFormat:@"M月d日"];
    //进行条件判断，满足不同的条件返回不同的结果
    if (interval < 10 * kAMinute) {
        //刚刚
        return @"刚刚";
    }
    if (interval < kAnHour) {
        //一个小时之内
        return [NSString stringWithFormat:@"%.0f分钟前", (currentDateStamp - dateStamp) / kAMinute];
    }
    if (todayZeroClock - dateStamp <= 0) {
        //今天之内
        return [NSString stringWithFormat:@"%.0f小时前", (currentDateStamp - dateStamp) / kAnHour];
    }
    if (todayZeroClock - dateStamp > 0) {
        //已经超过一天（昨天）
        return @"昨天";
    }
    if (todayZeroClock - dateStamp > 24 * kAnHour) {
        //已经超过两天以上
        return [outputFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:dateStamp]];
    }
    return @"";
}

#pragma mark - 格式化时间戳
- (NSString *)timeIntervalString{
    if (self.length) {
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        
        // 毫秒值转化为秒
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[self doubleValue]/ 1000.0];
        NSString* dateString = [formatter stringFromDate:date];
        return dateString;
    }
    return @"";
}

#pragma mark - MD5 32位
- (NSString *)hc_MD5String {
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

#pragma mark -获取字符串(或汉字)首字母
+ (NSString *)firstCharacterWithString:(NSString *)string {
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}

#pragma mark - 计算距离当前时间多久
+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime {
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    //上次时间
    NSDate *lastDate = [lastTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:lastTime]];
    //当前时间
    NSDate *currentDate = [currentTime dateByAddingTimeInterval:[timeZone secondsFromGMTForDate:currentTime]];
    //时间间隔
    NSInteger intevalTime = [currentDate timeIntervalSinceReferenceDate] - [lastDate timeIntervalSinceReferenceDate];
    
    //秒、分、小时、天、月、年
    NSInteger minutes = intevalTime / 60;
    NSInteger hours = intevalTime / 60 / 60;
    NSInteger day = intevalTime / 60 / 60 / 24;
    NSInteger month = intevalTime / 60 / 60 / 24 / 30;
    NSInteger yers = intevalTime / 60 / 60 / 24 / 365;
    
    if (minutes <= 10) {
        return  @"刚刚";
    }else if (minutes < 60){
        return [NSString stringWithFormat: @"%ld分钟前",(long)minutes];
    }else if (hours < 24){
        return [NSString stringWithFormat: @"%ld小时前",(long)hours];
    }else if (day < 30){
        return [NSString stringWithFormat: @"%ld天前",(long)day];
    }else if (month < 12){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }else if (yers >= 1){
        NSDateFormatter * df =[[NSDateFormatter alloc]init];
        df.dateFormat = @"yyyy年M月d日";
        NSString * time = [df stringFromDate:lastDate];
        return time;
    }
    return @"";
}

#pragma mark - 获取设备 IP 地址
+ (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

#pragma mark - 判断字符串中是否含有空格
+ (BOOL)isHaveSpaceInString:(NSString *)string {
    NSRange _range = [string rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - 判断字符串中是否含有某个字符串
+ (BOOL)isHaveString:(NSString *)string1 InString:(NSString *)string2 {
    NSRange _range = [string2 rangeOfString:string1];
    if (_range.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 判断字符串中是否含有中文
+ (BOOL)isHaveChineseInString:(NSString *)string{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 判断字符串是否全部为数字
+ (BOOL)isAllNum:(NSString *)string {
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - 是否电话号码
+ (BOOL)valiMobile:(NSString *)mobile {
    
    if (mobile.length != 11) {
        return NO;
    }
    
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[0, 1, 6, 7, 8], 18[0-9]
     * 移动号段: 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     * 联通号段: 130,131,132,145,155,156,170,171,175,176,185,186
     * 电信号段: 133,149,153,170,173,177,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0135678]|8[0-9])\\d{8}$";
    
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,147,150,151,152,157,158,159,170,178,182,183,184,187,188
     */
    
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    
    /**
     * 中国联通：China Unicom
     * 130,131,132,145,155,156,170,171,175,176,185,186
     */
    NSString *CU = @"^1(3[0-2]|4[5]|5[56]|7[0156]|8[56])\\d{8}$";
    
    /**
     * 中国电信：China Telecom
     * 133,149,153,170,173,177,180,181,189
     */
    NSString *CT = @"^1(3[3]|4[9]|53|7[037]|8[019])\\d{8}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES)) {
        return YES;
    } else {
        return NO;
    }
}

@end
