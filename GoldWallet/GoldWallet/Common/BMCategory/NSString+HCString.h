//
//  NSString+HCString.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/20.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HCString)

+(CGSize)getwidthForStr:(NSString*)str testFont:(CGFloat)font height:(CGFloat)height;
//获取文字高度
+ (CGSize)getHeightForStr:(NSString*)str testFont:(CGFloat)font with:(CGFloat)with;

/**URL编码*/
- (NSString *)URLEncodedString;
/**URL解码*/
- (NSString *)URLDecodedString;

/**货币格式化*/
+ (NSString *)hc_moneyStringWithMoney:(CGFloat)money;
/**超过一万的数，加上单位 万*/
+ (NSString *)hc_unitStringWithCount:(NSInteger)count;
+ (NSString *)hc_unitStringWithNum:(CGFloat)num;
/**电话号码加空格*/
+ (NSString *)hc_addBlankWithPhoneNumber:(NSString *)number;
/**时间戳转换*/
+ (NSString *)hc_stringWithTimeStamp:(NSNumber *)timeStamp;

#pragma mark - 格式化时间戳
- (NSString *)timeIntervalString;
/**MD5加密，输出32位小写*/
- (NSString *)hc_MD5String;

/**
 *  获取字符串（或汉字）首字母
 *
 *  @param string 字符串
 *
 *  @return 返回首字母
 */
+ (NSString *)firstCharacterWithString:(NSString *)string;

/**
 *  计算上次日期距离现在多久
 *
 *  @param lastTime    上次的时间
 *  @param currentTime 现在的时间
 *
 *  @return 返回xx分钟前、xx小时前、xx天前
 */
+ (NSString *)timeIntervalFromLastTime:(NSDate *)lastTime ToCurrentTime:(NSDate *)currentTime;

/**
 *  获取设备IP地址
 *
 *  @return IP地址，NSString类型
 */
+ (NSString *)getIPAddress;

/**
 *  判断字符串中是否含有空格
 *
 *  @param string 字符串
 *
 *  @return Yes/No
 */
+ (BOOL)isHaveSpaceInString:(NSString *)string;

/**
 *  判断字符串中是否含有某个字符串
 *
 *  @param string1 含有字符串
 *  @param string2 原字符串
 *
 *  @return Yes/No
 */
+ (BOOL)isHaveString:(NSString *)string1 InString:(NSString *)string2;

/**
 *  判断字符串中是否含有中文
 *
 *  @param string 字符串
 *
 *  @return Yes/No
 */
+ (BOOL)isHaveChineseInString:(NSString *)string;

/**
 *  判断字符串是否全部为数字
 *
 *  @param string 字符串
 *
 *  @return Yes/No
 */
+ (BOOL)isAllNum:(NSString *)string;

#pragma mark - 是否电话号码
+ (BOOL)valiMobile:(NSString *)mobile;
@end
