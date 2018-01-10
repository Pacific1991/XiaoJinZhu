//
//  HCAccountModel.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/21.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCAccountModel.h"

@implementation HCAccountModel

#pragma mark - initialize
+ (instancetype)accountWithInfo:(NSDictionary *)info {
    HCAccountModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:info];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

#pragma maek - SQLite相关

/**
 忽略属性集合
 
 @return 返回忽略属性集合
 */
+ (NSArray *)whc_IgnorePropertys {
    
    return @[];
}

/**
 指定自定义表名
 
 在指定引入其他方式创建的数据库时，这个时候如果表名不是模型类名需要实现该方法指定表名称
 
 @return 表名
 */
+ (NSString *)whc_TableName {
    return @"UserAccountTable";
}
@end
