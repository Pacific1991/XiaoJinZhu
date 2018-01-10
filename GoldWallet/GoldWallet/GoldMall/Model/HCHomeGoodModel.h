//
//  HCHomeGoodModel.h
//  HealthClaims
//
//  Created by sdd on 17/10/13.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCHomeGoodModel : NSObject
//@property (nonatomic, readwrite, strong) NSString *specName;       // 规格
@property (nonatomic, readwrite, strong) NSString *spec_name;       // 规格

/** 属性 */
@property (nonatomic, readwrite, strong) NSNumber *collectionStatus;
/** 属性 */
@property (nonatomic, readwrite, strong) NSArray *authentication;
/** 商品标签 */
@property (nonatomic, readwrite, strong) NSArray<NSString *> *label;
/** 品牌故事 */
@property (nonatomic, readwrite, copy) NSString *brandstory;
/** 品牌故事图片 */
@property (nonatomic, readwrite, copy) NSString *brandstoryUrl;
/** 商家ID */
@property (nonatomic, readwrite, strong) NSNumber *businessID;
/** 始发地 */
@property (nonatomic, readwrite, copy) NSString *countryOrigin;
/** 商品描述 */
@property (nonatomic, readwrite, copy) NSString *describe;
/** 商品ID */
@property (nonatomic, readwrite, strong) NSNumber *goodsID;
/** 商品名称 */
@property (nonatomic, readwrite, copy) NSString *goodsName;
/** 商品图片 */
@property (nonatomic, readwrite, strong) NSArray *goodsPic;
/** 商品现价 */
@property (nonatomic, readwrite, copy) NSString *goodsPrice;
/** 商品分类*/
@property (nonatomic, readwrite, strong) NSNumber *goodsType;
/** 商品原价 */
//@property (nonatomic, readwrite, copy) NSString *originalPrice;
/** 商品原价 */
@property (nonatomic, readwrite, copy) NSString *market_price;
/** 商品限购数量 */
@property (nonatomic, readwrite, copy) NSString *purchaseAmount;
/** 商品限购时间 */
@property (nonatomic, readwrite, strong) NSNumber *purchaseTime;
@property (nonatomic, readwrite, strong) NSNumber *purchaseEndtime;
/** 商品? */
@property (nonatomic, readwrite, strong) NSNumber *specificationsID;
/** 商品团购 */
@property (nonatomic, readwrite, strong) NSNumber *teamFlag;
/** 商品年购*/
@property (nonatomic, readwrite, strong) NSNumber *yearFlag;

+ (instancetype)goodWithInfo:(NSDictionary *)info ;


@end
