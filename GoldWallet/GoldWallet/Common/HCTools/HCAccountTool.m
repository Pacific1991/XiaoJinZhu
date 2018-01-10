//
//  HCAccountTool.m
//  HealthClaims
//
//  Created by 李晋 on 2017/10/13.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCAccountTool.h"

@implementation HCAccountTool
static HCAccountTool *instance;
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype _Nullable)tool {
    
    return [[self alloc] init];
}

/**
 当前用户
 */
- (HCAccountModel * _Nullable)currentAccount {
    if (!HUDFManager.sessionID.length) {
        return nil;
    }
    HCAccountModel *searchResult = [DBManager searchModelClass:[HCAccountModel class] withUniquenessKey:@"token" value:HUDFManager.sessionID];
    return searchResult;
}

/**
 用户数据替换
 */
- (BOOL)replaceAccountModel:(HCAccountModel *)model {
    if (!HUDFManager.sessionID.length) {
        return NO;
    }
    HCAccountModel *searchResult = [self currentAccount];
    if (searchResult) {
        return [DBManager updateModel:model uniquenessKey:@"token" value:HUDFManager.sessionID];
    } else {
        return [DBManager insertModel:model uniquenessKey:@"token" value:HUDFManager.sessionID];
    }
}

/**
 更新用户局部字段
 */
- (BOOL)updateAccountWithKeyValues:(NSDictionary<NSString *, id> *)keyValues {
    if (!HUDFManager.sessionID.length) {
        return NO;
    }
    HCAccountModel *searchResult = [self currentAccount];
    if (searchResult) {         /// 查询到记录
        
        return [DBManager updateClass:[HCAccountModel class] WithUniquenessKey:@"token" value:HUDFManager.sessionID paragmas:keyValues completion:^(BOOL handdle) {
            
        }];
    } else {                    /// 未查询到记录
        
        HCAccountModel *model = [[HCAccountModel alloc] init];
        [model setValuesForKeysWithDictionary:keyValues];
        model.token = HUDFManager.sessionID;
        BOOL result = [DBManager insertModel:model uniquenessKey:nil value:nil];
        
        return result;
    }
}

/**
 退出登录
 */
- (void)loginOut {
    if (HUDFManager.sessionID) {
        
        HUDFManager.sessionID = nil;
    }
}

@end
