//
//  HCDataBaseManager.m
//  HealthClaims
//
//  Created by 李晋 on 2017/10/13.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCDataBaseManager.h"

@implementation HCDataBaseManager
/**
 DebugTable

 @param obj_class TableModel.class
 @return DBDescriptionString
 */
- (NSString *_Nullable)DBDescriptionByClass:(Class _Nonnull)obj_class {
    NSString *description = [NSString stringWithFormat:@"modelCount: %ld \n", (long)[DBManager recordCountOfTableByModel:obj_class]];
    NSArray<HCDataBaseModel *> *accountList = [DBManager recordListOfTableByModel:obj_class];
    if (accountList.count) {
        for (HCDataBaseModel *model in accountList) {
            
            description = [description stringByAppendingString:[NSString stringWithFormat:@"%@ \n", model.mj_keyValues]];
        }
    }
    return description;
}

#pragma mark - initialize
static HCDataBaseManager *instance;
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
        instance.lock = [[NSLock alloc] init];
    });
    return instance;
}

+ (instancetype _Nullable)sharedManager {
    
    return [[self alloc] init];
}

#pragma mark - 统计
/**
 @return 表记录数量
 */
- (NSInteger)recordCountOfTableByModel:(Class _Nonnull)obj_class {
    
    /// 表总记录数
    NSNumber *accountNumb = [WHCSqlite query:obj_class func:@"count(*)"];
    return [accountNumb integerValue];
}

/**
 @return 表数据列表
 */
- (NSArray *_Nullable)recordListOfTableByModel:(Class _Nonnull)obj_class {
    if ([self recordCountOfTableByModel:obj_class] != 0) {
        
        return [WHCSqlite query:obj_class];
    }
    return @[];
}

#pragma mark - 存储用户信息记录
- (BOOL)inserAccount:(HCAccountModel * _Nonnull)model {
    if ([self searchAccountModelWithUserID:model.userID]) {
        
        return [self updateAccountWithUserID:model.userID newAccountModel:model];
    } else {
        
        return [WHCSqlite insert:model];
    }
}

#pragma mark - 更新
/**
 更新 整条 用户信息记录
 
 @param userID 用户ID
 @param model 替换记录
 
 */
- (BOOL)updateAccountWithUserID:(NSNumber * _Nonnull)userID
                newAccountModel:(HCAccountModel * _Nonnull)model {
    NSString *queryString = [NSString stringWithFormat:@"userID = '%@'", userID];
    return [WHCSqlite update:model where:queryString];
}

/**
 更新 用户信息记录 单条字段
 
 @param userID 用户ID
 @param paragmas 更新的字段<key: value>
 @param completion 成功回调
 */
- (void)updateAccountWithUserID:(NSNumber * _Nonnull)userID
                       paragmas:(NSDictionary<NSString *, NSString *> * _Nonnull)paragmas
                     completion:(void (^_Nonnull)(BOOL handdle))completion {
    
    if (!paragmas.allKeys.count) {
        completion(true);
    }
    NSString *queryString = [NSString stringWithFormat:@"userID = '%@'", userID];
    NSMutableArray *valuesArray = [@[] mutableCopy];
    for (NSString *key in paragmas) {
        NSString *arg = [NSString stringWithFormat:@"%@ = '%@'", key, paragmas[key]];
        [valuesArray addObject:arg];
    }
    NSString *value = [valuesArray componentsJoinedByString:@", "]; //@"name = 'whc', age = 100"
    BOOL result = [WHCSqlite update:HCAccountModel.self value: value
                              where:queryString];
    completion(result);
}

#pragma mark - 用户查询
/**
 用户ID查询
 
 @param userID 用户ID
 
 */
- (HCAccountModel * _Nullable)searchAccountModelWithUserID:(NSNumber * _Nonnull)userID {
    
    NSString *queryString = [NSString stringWithFormat:@"userID = '%@'", userID];
    NSArray *accountArray = [WHCSqlite query:[HCAccountModel class]
                                       where:queryString];
    if (accountArray && accountArray.count == 0) {
        return [accountArray firstObject];
    } else if (accountArray.count > 1) {
        [WHCSqlite delete:[HCAccountModel class]
                    where:queryString];
        return nil;
    }
    return nil;
}

/**
 用户Key查询
 */
- (HCAccountModel * _Nullable)searchAccountModelWithPropertyKey:(NSString * _Nonnull)key
                                                          value:(id _Nonnull)value {
    NSString *queryString = [NSString stringWithFormat:@"%@ = '%@'",key, value];
    NSArray *accountArray = [WHCSqlite query:[HCAccountModel class]
                                       where:queryString];
    if (accountArray && accountArray.count == 1) {
        return [accountArray firstObject];
    } else if (accountArray.count > 1) {
        [WHCSqlite delete:[HCAccountModel class]
                    where:queryString];
        return nil;
    }
    return nil;
}

#pragma mark - 用户删除
/**
 删除单条用户信息
 
 @param userID 用户ID
 */
- (BOOL)deleteAccountWithUserID:(NSNumber * _Nonnull)userID {
    HCAccountModel *model = [self searchAccountModelWithUserID:userID];
    if (model) {
        NSString *queryString = [NSString stringWithFormat:@"userID = '%@'", userID];
        return [WHCSqlite delete:[HCAccountModel class] where:queryString];
    }
    return YES;
}

#pragma mark - ---------------------- 通用Model -----------------------
#pragma mark - 存储
- (BOOL)insertModel:(id<WHC_SqliteInfo> _Nonnull)model_object
      uniquenessKey:(NSString * _Nullable)uniquenessKey
              value:(id _Nullable)value {
    
    if (uniquenessKey && value) {
        
        if ([self searchModelClass:[model_object class] withUniquenessKey:uniquenessKey value:value]) {
            return [self updateModel:model_object uniquenessKey:uniquenessKey value:value];
        } else {
            return [WHCSqlite insert:model_object];
        }
    } else {
        
        return [WHCSqlite insert:model_object];
    }
}

/**
 添加多条数据
 
 @param list list description
 */
- (BOOL)insertModelList:(NSArray<id<WHC_SqliteInfo>> * _Nonnull)list {
    if (list.count) {
        
        return [WHCSqlite inserts:list];
    }
    return NO;
}

#pragma mark - 更新
/**
 整条记录更新
 
 @param model_object 更新Model
 @param uniquenessKey 锚点键名
 
 */
- (BOOL)updateModel:(id<WHC_SqliteInfo> _Nonnull)model_object
      uniquenessKey:(NSString * _Nonnull)uniquenessKey
              value:(id _Nonnull)value {
    if (!model_object) {
        return NO;
    }
    NSString *queryString = [NSString stringWithFormat:@"%@ = '%@'", uniquenessKey, value];
    return [WHCSqlite update:model_object where:queryString];
}

/**
 更新单条字段
 
 @param model_class exampleModel.self
 @param uniquenessKey 标识键
 @param paragmas 更新的字段<key: value>
 @param completion 成功回调
 */
- (BOOL)updateClass:(Class _Nonnull)model_class
  WithUniquenessKey:(NSString * _Nonnull)uniquenessKey
              value:(id _Nonnull)value
           paragmas:(NSDictionary<NSString *, NSString *> * _Nonnull)paragmas
         completion:(void (^_Nonnull)(BOOL handdle))completion {
    
    if (!paragmas.allKeys.count) {
        completion(true);
    }
    NSString *queryString = [NSString stringWithFormat:@"%@ = '%@'", uniquenessKey, value];
    NSMutableArray *valuesArray = [@[] mutableCopy];
    for (NSString *key in paragmas) {
        NSString *arg = [NSString stringWithFormat:@"%@ = '%@'", key, paragmas[key]];
        [valuesArray addObject:arg];
    }
    NSString *replaceValue = [valuesArray componentsJoinedByString:@", "]; //@"name = 'whc', age = 100"
    BOOL result = [WHCSqlite update:model_class value: replaceValue
                              where:queryString];
    completion(result);
    return result;
}


#pragma mark - 查询
/**
 查询是否已经存在模型
 
 @param uniquenessKey 唯一性
 
 */
- (id _Nullable)searchModelClass:(Class _Nonnull)cls
               withUniquenessKey:(NSString * _Nonnull)uniquenessKey
                           value:(id _Nonnull)value {
    
    NSString *queryString = [NSString stringWithFormat:@"%@ = '%@'", uniquenessKey, value];
    NSArray *accountArray = [WHCSqlite query:cls
                                       where:queryString];
    if (accountArray && accountArray.count == 1) {
        return [accountArray firstObject];
    } else if (accountArray.count > 1) {
        [WHCSqlite delete:cls
                    where:queryString];
        return nil;
    }
    return nil;
}

/**
 关键字查询数据
 
 @param cls 查询类
 @param searchKey 关键字
 @param value 值
 @return 查询结果<NSArray class>
 */
- (NSArray * _Nullable)searchModelList:(Class _Nonnull)cls
                         withSearchKey:(NSString * _Nonnull)searchKey
                                 value:(id _Nonnull)value {
    NSString *queryString = [NSString stringWithFormat:@"%@ = '%@'", searchKey, value];
    return [WHCSqlite query:cls where:queryString];
}

/**
 查询表所有结果

 @param cls 查询类
 @return 结果<Model *>
 */
- (NSArray * _Nullable)searchClassList:(Class _Nonnull)cls {
    NSArray * result = [WHCSqlite query:cls];
    return result;
}

#pragma mark - 删除
/**
 删除单条用户信息
 
 @param uniquenessKey 唯一性
 */
- (BOOL)deleteModel:(Class _Nonnull)model_class
  withUniquenessKey:(NSString * _Nonnull)uniquenessKey
              value:(id _Nonnull)value {
    HCDataBaseModel *model = [self searchModelClass:model_class withUniquenessKey:uniquenessKey value:value];
    if (model) {
        NSString *queryString = [NSString stringWithFormat:@"%@ = '%@'", uniquenessKey, value];
        return [WHCSqlite delete:model_class where:queryString];
    }
    return YES;
}

/**
 清空表数据, 主键重新计算
 */
- (void)clearTableWithModelClass:(Class _Nonnull)model_class {
    [WHCSqlite removeModel:model_class];
}

/**
 清空表记录, 主键继续自增
 */
- (BOOL)clearClassRecord:(Class _Nullable)cls {
    if (cls) {
        
        return [WHCSqlite clear:cls];
    }
    return false;
}

/**
 删除所有数据
 */
- (void)clearAllTables {
    [WHCSqlite removeAllModel];
}
@end
