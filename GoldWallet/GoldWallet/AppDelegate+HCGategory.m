//
//  AppDelegate+HCGategory.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/21.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "AppDelegate+HCGategory.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@implementation AppDelegate (HCGategory)
- (void)setupRequestFiltersWithHttps:(BOOL)https {
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    if (https) {
        
        [self HttpsConfigSettingWith:config];
    }
    config.baseUrl = HCHostURL;
    // config.cdnUrl = @"http://fen.bi";
    [YTKNetworkConfig refreshFilterWithRaguments:nil];
    
}

/**
 配置HTTPS

 @param config Config实例
 */
- (void)HttpsConfigSettingWith:(YTKNetworkConfig *)config {
    // 获取证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"baidu" ofType:@"cer"];
    //证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // 验证公钥和证书的其他信息
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 允许自建证书
    securityPolicy.allowInvalidCertificates = YES;
    // 校验域名信息
    securityPolicy.validatesDomainName = YES;
    // 添加服务器证书,单向验证; 可采用双证书 双向验证;
    securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
    [config setSecurityPolicy:securityPolicy];
}

/**
 配置友盟
 */
- (void)configurationUmen {
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UmenAppkey];
    
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleString = @"分享给好友";
    [self configUSharePlatforms];
    
    [self confitUShareSettings];
}

- (void)confitUShareSettings {
    
}

- (void)configUSharePlatforms {
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeiXAppkey appSecret:WeiXAppScrect redirectURL:@"http://www.baidu.com"];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppkey  appSecret:QQAppScrect redirectURL:@"http://www.baidu.com"];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WeiboAppKey  appSecret:WeiboAppScrect redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
}

/**
 配置极光推送
 */
- (void)configmentJPushPushWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions {
    

    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    
    NSString *advertisingId;
    if (HUDFManager.sessionID) {
       advertisingId = [NSString stringWithFormat:@"%@",HUDFManager.sessionID];
    }else{
       advertisingId = nil;
    }
    
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    // 初始化 JPush
    [JPUSHService setupWithOption:launchOptions
                           appKey:JPushAppkey
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    [JPUSHService setTags:nil alias:advertisingId callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSLog(@"resCode : %d,registrationID: %@",resCode,registrationID);
    }];
    
}

//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
//实现注册APNs失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}




@end
