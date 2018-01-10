//
//  HCHomeGoodModel.m
//  HealthClaims
//
//  Created by sdd on 17/10/13.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCHomeGoodModel.h"

@implementation HCHomeGoodModel

+ (instancetype)goodWithInfo:(NSDictionary *)info {
    HCHomeGoodModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:info];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
