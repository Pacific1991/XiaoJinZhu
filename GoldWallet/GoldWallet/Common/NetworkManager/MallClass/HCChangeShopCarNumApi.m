//
//  HCChangeShopCarNumApi.m
//  HealthClaims
//
//  Created by sdd on 2017/11/6.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCChangeShopCarNumApi.h"
@implementation HCChangeShopCarNumApi{
    NSNumber *_cartID;
    NSNumber *_goodsNum;
}

- (instancetype)initWithGoodsID:(NSNumber *)goodsID GoodsNum:(NSNumber *)goodsNum{
    self = [super init];
    if (self) {
        _cartID = goodsID;
        _goodsNum = goodsNum;
    }
    return self;
}
- (NSString *)requestUrl {
    
    return HCarNumSaveOrderURL;
}

- (id)requestArgument {
    
    return @{@"cartID": _cartID,@"goodsNum": _goodsNum};
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
