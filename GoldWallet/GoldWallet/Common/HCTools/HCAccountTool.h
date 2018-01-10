//
//  HCAccountTool.h
//  HealthClaims
//
//  Created by 李晋 on 2017/10/13.
//  Copyright © 2017年 fmf. All rights reserved.
//
#define AccountTool [HCAccountTool tool]
#import <Foundation/Foundation.h>
@class HCAccountModel;
@interface HCAccountTool : NSObject
+ (instancetype _Nullable)tool;

- (void)loginOut;

/**
 当前用户
 */
- (HCAccountModel * _Nullable)currentAccount;

/**
 用户数据替换
 */
- (BOOL)replaceAccountModel:(HCAccountModel * _Nonnull)model;

/**
 更新用户局部字段
 */
- (BOOL)updateAccountWithKeyValues:(NSDictionary<NSString *, id> * _Nonnull)keyValues;
@end
