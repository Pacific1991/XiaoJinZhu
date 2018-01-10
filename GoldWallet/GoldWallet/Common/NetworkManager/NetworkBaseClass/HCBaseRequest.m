//
//  HCBaseRequest.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/22.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCBaseRequest.h"

@implementation HCBaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
    return @{
             @"os_version": [[UIDevice currentDevice] systemVersion],
             @"app_version": [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
             };
}

//
//- (YTKRequestSerializerType)requestSerializerType {
//    return YTKRequestSerializerTypeJSON;
//}
//
//- (YTKResponseSerializerType)responseSerializerType {
//    return YTKResponseSerializerTypeHTTP;
//}


@end
