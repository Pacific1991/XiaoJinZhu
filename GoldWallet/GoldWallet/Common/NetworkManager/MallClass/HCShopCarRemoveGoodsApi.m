//
//  HCShopCarRemoveGoodsApi.m
//  HealthClaims
//
//  Created by sdd on 2017/11/6.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCShopCarRemoveGoodsApi.h"

@implementation HCShopCarRemoveGoodsApi{
    NSNumber *_goodsID;
    NSNumber *_type;
}

- (instancetype)initWithGoodsID:(NSNumber *)goodsID Type:(NSNumber *)type{
    self = [super init];
    if (self) {
        _goodsID = goodsID;
        _type = type;
    }
    return self;
}
- (NSString *)requestUrl {
    
    return HCDelShoppingCartURL;
}

- (id)requestArgument {
    
    return @{@"cartID": _goodsID,@"type": _type};
}

- (BOOL)requiredParametersPassedBeforeRequesting {
    if (!HUDFManager.sessionID) {
        self.faildOperationType = YTKRequstFaildOperationTypeDoLogin;
        self.faildOperationArguments = @"请重新登录";
        return NO;
    }
    return YES;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
@end
