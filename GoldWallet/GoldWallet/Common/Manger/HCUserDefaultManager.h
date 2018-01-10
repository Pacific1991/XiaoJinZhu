//
//  HCUserDefaultManager.h
//  HealthClaims
//
//  Created by 李晋 on 2017/10/12.
//  Copyright © 2017年 fmf. All rights reserved.
//

#define HUDFManager [HCUserDefaultManager sharedManager]
#import <Foundation/Foundation.h>
@interface HCUserDefaultManager : NSObject
+ (instancetype _Nullable)sharedManager;
/**
 用户唯一标识, 所有请求添加
 */
@property (nonatomic, readwrite, copy) NSString * _Nullable sessionID;
@property (nonatomic, readwrite, copy) NSString * _Nullable password;
@property (nonatomic, readwrite, copy) NSString * _Nullable username;

/**
 最近一次登陆的手机号
 */
@property (nonatomic, readwrite, strong) NSString * _Nullable lastLoginPhoneNumber;
@end
