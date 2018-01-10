//
//  HCBuyCarModel.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/30.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCBuyCarModel.h"

@implementation HCBuyCarModel

- (id)copyWithZone:(NSZone *)zone{
    
    HCBuyCarModel * model = [[HCBuyCarModel allocWithZone:zone] init];
    model.goodsID = [self.goodsID copy];
    model.goodsPic = [self.goodsPic copy];
    model.goodsName = [self.goodsName copy];
    model.goodsPrice = self.goodsPrice;
    model.goodsNum = self.goodsNum;
    return model;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone{
    HCBuyCarModel * model = [[self class] allocWithZone:zone];
    model.goodsID = [_goodsID copy];
    model.goodsPic = [_goodsPic copy];
    model.goodsName = [_goodsName copy];
    model.goodsPrice = _goodsPrice;
    model.goodsNum = _goodsNum;
    return model;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isSelected = YES;
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
