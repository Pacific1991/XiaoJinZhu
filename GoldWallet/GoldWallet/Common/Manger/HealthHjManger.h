//
//  HealthHjManger.h
//  HealthClaims
//
//  Created by bill on 2017/9/13.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HealthUserModel.h"
#define kIsLogin @"isLogin"
#define kLoginInfo @"kLoginInfo"

#define kEmail @"email"
#define kPhone @"phone"
@interface HealthHjManger : NSObject
/** 获取用户模型*/
+ (HealthUserModel *)getUserInfo;
/** 存储用户模型*/
+ (void)saveUserInfo:(HealthUserModel *)userInfo;
/** 是否登录*/
+ (BOOL)isLogin;
/** 登录*/
+ (void)login;
/** 退出登录*/
+(void)signOut;

@end
