//
//  HealthUserModel.m
//  HealthClaims
//
//  Created by bill on 2017/9/13.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HealthUserModel.h"

@implementation HealthUserModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"UserId" : @"id",
             @"lastlogin_ip" : @"lastlogin_ip",
             @"lastlogin_time" : @"lastlogin_time",
             @"mobile" : @"mobile",
             @"regtime" : @"regtime",
             @"username" : @"username"
             };
}
@end
