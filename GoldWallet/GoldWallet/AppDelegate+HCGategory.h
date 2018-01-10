//
//  AppDelegate+HCGategory.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/21.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (HCGategory)<JPUSHRegisterDelegate,WXApiDelegate>
- (void)setupRequestFiltersWithHttps:(BOOL)https;
- (void)configurationUmen;
/**
 配置极光推送
 */
- (void)configmentJPushPushWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions;


@end
