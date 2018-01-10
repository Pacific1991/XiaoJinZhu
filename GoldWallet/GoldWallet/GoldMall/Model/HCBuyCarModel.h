//
//  HCBuyCarModel.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/30.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCBuyCarModel : NSObject<NSCopying,NSMutableCopying>
@property (nonatomic, readwrite, strong) NSNumber *goodsID;           /// 商品ID
@property (nonatomic, readwrite, strong) NSNumber *giftID;           /// 礼物ID
@property (nonatomic, readwrite, copy) NSString *goodsPic;          /// 商品照片
@property (nonatomic, readwrite, copy) NSString *goodsName;         /// 商品名
@property (nonatomic, readwrite, copy) NSString *goodsPrice;      /// 商品价格
@property (nonatomic, readwrite, strong) NSNumber *goodsNum;       /// 购买数量
@property (nonatomic, readwrite, copy) NSString *specValue;       /// 规格
@property (nonatomic, readwrite, copy) NSString *specName;       /// 规格

@property (nonatomic, readwrite, strong) NSNumber *cartID;          ///
@property (nonatomic, readwrite, strong) NSNumber *userID;          ///
@property (nonatomic, readwrite, strong) NSNumber *businessID;      ///
@property (nonatomic, readwrite, assign) BOOL isSelected;           /// 是否被选中


@end
