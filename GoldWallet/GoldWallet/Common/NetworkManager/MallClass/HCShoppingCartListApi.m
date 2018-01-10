//
//  HCShoppingCartListApi.m
//  HealthClaims
//
//  Created by sdd on 17/10/25.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCShoppingCartListApi.h"

@implementation HCShoppingCartListApi

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl {
    
    return HCShoppingCartListURL;
}

- (id)requestArgument {
    
    return nil;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
- (BOOL)requiredParametersPassedBeforeRequesting {
    if (!HUDFManager.sessionID) {
        self.faildOperationType = YTKRequstFaildOperationTypeDoLogin;
        self.faildOperationArguments = @"请重新登录";
        return NO;
    }
    return YES;
}
@end
