//
//  HCShopCarRemoveGoodsApi.h
//  HealthClaims
//
//  Created by sdd on 2017/11/6.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCBaseRequest.h"

@interface HCShopCarRemoveGoodsApi : HCBaseRequest
- (instancetype)initWithGoodsID:(NSNumber *)goodsID Type:(NSNumber *)type;

@end
