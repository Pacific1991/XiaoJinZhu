//
//  HCAccountModel.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/21.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCDataBaseModel.h"
@interface HCAccountModel : HCDataBaseModel
/** 用户ID */
@property (nonatomic, readwrite, strong) NSNumber *userID;
/** 微信ID */
@property (nonatomic, readwrite, copy) NSString *openID;
/** 银行卡ID */
@property (nonatomic, readwrite, strong) NSNumber *bankCardID;
/** token验证: sessionID, 查表键 */
@property (nonatomic, readwrite, copy) NSString *token;

/** 用户类型(0管理员1商家2普通用户3店员4专家登录) */
@property (nonatomic, readwrite, strong) NSNumber *userType;
/** 审核状态(0待审核1未通过2已通过) */
@property (nonatomic, readwrite, strong) NSNumber *auditing;
/** 身份类别（二代身份证，护照) */
@property (nonatomic, readwrite, strong) NSNumber *identityClass;

/** 性别 */
@property (nonatomic, readwrite, strong) NSNumber *sex;
/** 头像 */
@property (nonatomic, readwrite, copy) NSString *headportrait;
/** 昵称 */
@property (nonatomic, readwrite, copy) NSString *nickname;
/** 密码 */
@property (nonatomic, readwrite, copy) NSString *passWord;
/** 手机号 */
@property (nonatomic, readwrite, copy) NSString *user_mobile;

/** 余额 */
@property (nonatomic, readwrite, strong) NSNumber *wallet;
/** 收益 */
@property (nonatomic, readwrite, strong) NSNumber *profit;
/** 总金额 */
@property (nonatomic, readwrite, strong) NSNumber *totalAmount;

/** 生日 */
@property (nonatomic, readwrite, copy) NSString *birthday;
/** 创建时间 */
@property (nonatomic, readwrite, copy) NSString *createtime;
/** 图片 */
@property (nonatomic, readwrite, copy) NSString *idicture;
/** 工作经历 */
@property (nonatomic, readwrite, copy) NSString *workExperience;

/** 体质 */
@property (nonatomic, readwrite, copy) NSString *constitution;
/** 血管测试 */
@property (nonatomic, readwrite, copy) NSString *vessel;
/** 肠胃测试 */
@property (nonatomic, readwrite, copy) NSString *stomach;

/** 资讯收藏count */
@property (nonatomic, readwrite, strong) NSNumber *articleCollection;
/** 药膳收藏count */
@property (nonatomic, readwrite, strong) NSNumber *dishesCollection;
/** 商品收藏count */
@property (nonatomic, readwrite, strong) NSNumber *goodsCollection;
/** 食谱收藏count */
@property (nonatomic, readwrite, strong) NSNumber *recipesCollection;


+ (instancetype)accountWithInfo:(NSDictionary *)info;

#pragma mark - ignoreAttribute  忽略属性

@end
