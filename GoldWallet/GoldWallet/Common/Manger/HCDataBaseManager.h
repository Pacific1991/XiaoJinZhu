//
//  HCDataBaseManager.h
//  HealthClaims
//
//  Created by 李晋 on 2017/10/13.
//  Copyright © 2017年 fmf. All rights reserved.
//
/**
 
 HCLoginAccountModel *model = [HCLoginAccountModel loginModelWithTelNumb:@"111111" password:@"pwd1" openId:nil];
 HCLoginAccountModel *model1 = [HCLoginAccountModel loginModelWithTelNumb:@"222222" password:@"pwd2" openId:nil];
 HCLoginAccountModel *model2 = [HCLoginAccountModel loginModelWithTelNumb:@"333333" password:@"pwd3" openId:nil];
 HCLoginAccountModel *model3 = [HCLoginAccountModel loginModelWithTelNumb:@"444444" password:@"pwd4" openId:nil];
 HCLoginAccountModel *model4 = [HCLoginAccountModel loginModelWithTelNumb:@"555555" password:@"pwd5" openId:nil];
 HCLoginAccountModel *model5 = [HCLoginAccountModel loginModelWithTelNumb:@"666666" password:@"pwd6" openId:nil];
 [[HCAccountManager sharedManager] insertModelList:@[model, model1, model2, model3, model4, model5]];
 [WHCSqlite removeModel:[HCLoginAccountModel class]];
 HCLoginAccountModel *model = [[HCAccountManager sharedManager] searchModelClass:[HCLoginAccountModel class] withUniquenessKey:@"telNumber" value:@"444444"];
 model.openId = @"test666";
 NSInteger count = [[HCAccountManager sharedManager] recordCountOfTableByModel:[HCLoginAccountModel class]];
 [[HCAccountManager sharedManager] updateClass:[HCLoginAccountModel class] WithUniquenessKey:@"telNumber" value:@"444444" paragmas:@{@"whcId": @(count + 1)} completion:^(BOOL handdle) {
 NSLog(@"%d", handdle);
 }];
 NSString * discription = [[HCAccountManager sharedManager] DBDescriptionByClass:[HCLoginAccountModel class]];
 NSLog(@"%@", discription);
 NSLog(@"")
 
 */

#define DBManager [HCDataBaseManager sharedManager]

#import <Foundation/Foundation.h>
#import "HCAccountModel.h"

@interface HCDataBaseManager : NSObject
@property (nonatomic, readwrite, strong) NSLock *lock;
+ (instancetype _Nullable)sharedManager;

#pragma mark - 统计
/**
 DebugTable
 
 @param obj_class TableModel.class
 @return DBDescriptionString
 */
- (NSString *_Nullable)DBDescriptionByClass:(Class _Nonnull)obj_class;
/**
 @return 表记录数量
 */
- (NSInteger)recordCountOfTableByModel:(id _Nonnull)model;

/**
 @return 表数据列表
 */
- (NSArray *_Nullable)recordListOfTableByModel:(id _Nonnull)model;


#pragma mark - 存储用户信息

- (BOOL)inserAccount:(HCAccountModel * _Nonnull)model __attribute__((deprecated("Use insertModel:uniquenessKey:value: instead.")));
#pragma mark - 更新用户信息
/**
 更新 整条 用户信息记录
 
 @param userID 用户ID
 @param model 替换记录
 
 */
- (BOOL)updateAccountWithUserID:(NSNumber * _Nonnull)userID
                newAccountModel:(HCAccountModel * _Nonnull)model __attribute__((deprecated("Use updateModel:uniquenessKey:value: instead.")));

/**
 更新 用户信息记录 单条字段
 
 @param userID 用户ID
 @param paragmas 更新的字段<key: value>
 @param completion 成功回调
 */
- (void)updateAccountWithUserID:(NSNumber * _Nonnull)userID
                       paragmas:(NSDictionary<NSString *, NSString *> * _Nonnull)paragmas
                     completion:(void (^_Nonnull)(BOOL handdle))completion __attribute__((deprecated("Use updateClass:WithUniquenessKey:value:paragmas:completion: instead.")));

#pragma mark - 用户查询
/**
 用户ID查询
 
 @param userID 用户ID
 
 */
- (HCAccountModel * _Nullable)searchAccountModelWithUserID:(NSNumber * _Nonnull)userID __attribute__((deprecated("Use searchModelClass:withUniquenessKey:value: instead.")));

/**
 用户Key查询
 */
- (HCAccountModel * _Nullable)searchAccountModelWithPropertyKey:(NSString * _Nonnull)key
                                                          value:(id _Nonnull)value __attribute__((deprecated("Use searchModelList:withSearchKey:value: instead.")));
#pragma mark - 删除
/**
 删除单条用户信息
 
 @param userID 用户ID
 */
- (BOOL)deleteAccountWithUserID:(NSNumber * _Nonnull)userID __attribute__((deprecated("Use deleteModel:withUniquenessKey:value: instead.")));


#pragma mark - ---------------------- 通用Model -----------------------
#pragma mark - 存储
- (BOOL)insertModel:(id<WHC_SqliteInfo>  _Nonnull)model_object
      uniquenessKey:(NSString * _Nullable)uniquenessKey
              value:(id _Nullable)value;

- (BOOL)insertModelList:(NSArray<id<WHC_SqliteInfo>> * _Nonnull)list;
#pragma mark - 更新
/**
 整条记录更新
 
 @param model_object 更新Model
 @param uniquenessKey 锚点键名
 
 */
- (BOOL)updateModel:(id<WHC_SqliteInfo> _Nonnull)model_object
      uniquenessKey:(NSString * _Nonnull)uniquenessKey
              value:(id _Nonnull)value;
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
         completion:(void (^_Nonnull)(BOOL handdle))completion;

#pragma mark - 查询
/**
 查询是否已经存在模型
 
 @param uniquenessKey 唯一性
 
 */
- (id _Nullable)searchModelClass:(Class _Nonnull)cls
               withUniquenessKey:(NSString * _Nonnull)uniquenessKey
                           value:(id _Nonnull)value;

/**
 关键字查询数据
 
 @param cls 查询类
 @param searchKey 关键字
 @param value 值
 @return 查询结果<NSArray class>
 */
- (NSArray * _Nullable)searchModelList:(Class _Nonnull)cls
                         withSearchKey:(NSString * _Nonnull)searchKey
                                 value:(id _Nonnull)value;

/**
 查询表所有结果
 
 @param cls 查询类
 @return 结果<Model *>
 */
- (NSArray * _Nullable)searchClassList:(Class _Nonnull)cls;

#pragma mark - 删除
/**
 删除单条用户信息
 
 @param uniquenessKey 唯一性
 */
- (BOOL)deleteModel:(Class _Nonnull)model_class
  withUniquenessKey:(NSString * _Nonnull)uniquenessKey
              value:(id _Nonnull)value;
/**
 清空表数据, 主键重新计算
 */
- (void)clearTableWithModelClass:(Class _Nonnull)model_class;

/**
 清空表记录, 主键继续自增
 */
- (BOOL)clearClassRecord:(Class _Nullable)cls;

/**
 删除所有数据
 */
- (void)clearAllTables;
@end
