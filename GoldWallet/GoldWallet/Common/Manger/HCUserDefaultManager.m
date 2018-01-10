//
//  HCUserDefaultManager.m
//  HealthClaims
//
//  Created by 李晋 on 2017/10/12.
//  Copyright © 2017年 fmf. All rights reserved.
//
#define SessionIDUDFKey @"CURRENTSESSIONIDKEY"
#define LastLoginPhoneNumberKey @"LASTLOGINPHONENUMBERKey"
#import "HCUserDefaultManager.h"
@interface HCUserDefaultManager() {
    NSString *_sessionID;
    NSString *_lastLoginPhoneNumber;
}
@property (nonatomic, readwrite, strong) NSUserDefaults *userDefaults;
@end
@implementation HCUserDefaultManager
@dynamic sessionID;
static HCUserDefaultManager *instance;
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        instance.userDefaults = [NSUserDefaults standardUserDefaults];
    });
    return instance;
}

+ (instancetype _Nullable)sharedManager {
    
    return [[self alloc] init];
}

#pragma mark - 用户唯一标识ID
- (NSString * _Nullable)sessionID {
    
    return [self.userDefaults valueForKey:SessionIDUDFKey];
}
- (void)setSessionID:(NSString *)sessionID {
    _sessionID = sessionID;
    if (sessionID == nil) {
        [NSURL imageURLWithString:@""];
        [self.userDefaults removeObjectForKey:SessionIDUDFKey];
        
    } else {
        
        [self.userDefaults setValue:_sessionID forKey:SessionIDUDFKey];
        [self.userDefaults synchronize];
    }
    [YTKNetworkConfig refreshFilterWithRaguments:nil];
}
-(void)setPassword:(NSString *)password{
    _password = password;
    [self.userDefaults setValue:_password forKey:@"password"];

}
-(void)setUsername:(NSString *)username{
    _username = username;
    [self.userDefaults setValue:_username forKey:@"username"];
}
#pragma mark - 最近一次登录的手机号
- (NSString * _Nullable)lastLoginPhoneNumber {
    return [self.userDefaults valueForKey:LastLoginPhoneNumberKey];
}

- (void)setLastLoginPhoneNumber:(NSString *)lastLoginPhoneNumber {
    _lastLoginPhoneNumber = lastLoginPhoneNumber;
    [self.userDefaults setValue:_lastLoginPhoneNumber forKey:LastLoginPhoneNumberKey];
    [self.userDefaults synchronize];
}

@end
