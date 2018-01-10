//
//  HCHealthKitManage.h
//  HealthClaims
//
//  Created by sdd on 2017/11/6.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCHealthKitManage : NSObject
@property (nonatomic, strong) HKHealthStore *healthStore;
+(id)shareInstance;
- (void)authorizeHealthKit:(void(^)(BOOL success, NSError *error))compltion;
- (void)getStepCount:(void(^)(double value, NSError *error))completion;

@end
