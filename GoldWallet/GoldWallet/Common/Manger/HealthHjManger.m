//
//  HealthHjManger.m
//  HealthClaims
//
//  Created by bill on 2017/9/13.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HealthHjManger.h"
#import "MJExtension.h"
static NSString * const KeyUserInfo = @"UserInfo";
static NSString * const KeyIsLogin = @"IsLogin";
@implementation HealthHjManger
/** 获取用户模型*/
+ (HealthUserModel *)getUserInfo
{
    NSDictionary *infoDic = [[NSUserDefaults standardUserDefaults] objectForKey:KeyUserInfo];
    HealthUserModel *userInfoModel = [HealthUserModel mj_objectWithKeyValues:infoDic];
    return userInfoModel;
}

/** 存储用户模型*/
+ (void)saveUserInfo:(HealthUserModel *)userInfo
{
    if (userInfo)
    {
        [[NSUserDefaults standardUserDefaults] setObject:userInfo.mj_keyValues forKey:KeyUserInfo];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/** 删除用户模型*/
+ (void)deleteUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KeyUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/** 是否登录*/
+ (BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KeyIsLogin];
}

/** 登录*/
+ (void)login
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KeyIsLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/** 退出登录*/
+(void)signOut
{
    // 保存退出状态
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:KeyIsLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
