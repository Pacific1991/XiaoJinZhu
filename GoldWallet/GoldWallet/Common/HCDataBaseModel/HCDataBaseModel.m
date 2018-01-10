//
//  HCDataBaseModel.m
//  HealthClaims
//
//  Created by 李晋 on 2017/10/12.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCDataBaseModel.h"

@implementation HCDataBaseModel
/// 使用WHC_Model库自动实现NSCoding协议
WHC_CodingImplementation
#pragma maek - SQLite相关
//+ (NSString *)whc_SqliteMainkey {
//    
//    return [NSString stringWithFormat:@"%@_primaryKey", NSStringFromClass([self class])];
//}

/**
 忽略属性集合
 
 @return 返回忽略属性集合
 */
+ (NSArray *)whc_IgnorePropertys {
    
    return @[];
}

/// 自定义数据库加密密码
/** 注意：
 ***该加密功能需要引用SQLCipher三方库才支持***
 /// 引入方式有:
 *** 手动引入 ***
 *** pod 'WHC_ModelSqliteKit/SQLCipher' ***
 */
+ (NSString *)whc_SqlitePasswordKey {
    
    return SqlitePasswordKey;
}

/// 自定义模型类数据库版本号
/** 注意：
 ***该返回值在改变数据模型属性类型/增加/删除属性时需要更改否则无法自动更新原来模型数据表字段以及类型***
 */
+ (NSString *)whc_SqliteVersion {
    
    return SQLiteVersion;
}


/**
 引入使用其他方式创建的数据库存储路径比如:FMDB
 来使用WHC_Sqlite进行操作其他方式创建的数据库
 
 @return 存储路径
 */
+ (NSString *)whc_OtherSqlitePath {
    if ([HCUserDefaultManager sharedManager].sessionID) {
        
        return [NSString stringWithFormat:@"%@/Library/user/%@.db",NSHomeDirectory(), [HCUserDefaultManager sharedManager].sessionID];
    } else {
        return [NSString stringWithFormat:@"%@/Library/publicDB.db",NSHomeDirectory()];
    }
}

/**
 指定自定义表名
 
 在指定引入其他方式创建的数据库时，这个时候如果表名不是模型类名需要实现该方法指定表名称
 
 @return 表名
 */
//+ (NSString *)whc_TableName {
//    return @"table";
//}

//- (NSString *)description {
//    return [NSString stringWithFormat:@"%@", self.mj_keyValues];
//}

@end
