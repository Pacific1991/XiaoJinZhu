//
//  HCDataBaseModel.h
//  HealthClaims
//
//  Created by 李晋 on 2017/10/12.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDataBaseModel : NSObject<WHC_SqliteInfo>

@property (nonatomic, assign) NSInteger whcId;

#pragma mark - ignoreAttribute  忽略属性

/// 自定义数据表主键名称
/**
 *** 返回自定义主键名称默认主键:_id ***
 */
//+ (NSString *)whc_SqliteMainkey;

/**
 忽略属性集合
 
 @return 返回忽略属性集合
 */
+ (NSArray *)whc_IgnorePropertys;

/// 自定义数据库加密密码
/** 注意：
 ***该加密功能需要引用SQLCipher三方库才支持***
 /// 引入方式有:
 *** 手动引入 ***
 *** pod 'WHC_ModelSqliteKit/SQLCipher' ***
 */
+ (NSString *)whc_SqlitePasswordKey;

/// 自定义模型类数据库版本号
/** 注意：
 ***该返回值在改变数据模型属性类型/增加/删除属性时需要更改否则无法自动更新原来模型数据表字段以及类型***
 */
+ (NSString *)whc_SqliteVersion;

/**
 引入使用其他方式创建的数据库存储路径比如:FMDB
 来使用WHC_Sqlite进行操作其他方式创建的数据库
 
 @return 存储路径
 */
+ (NSString *)whc_OtherSqlitePath;

/**
 指定自定义表名
 
 在指定引入其他方式创建的数据库时，这个时候如果表名不是模型类名需要实现该方法指定表名称
 
 @return 表名
 */
//+ (NSString *)whc_TableName;
- (NSString *)description;
@end
