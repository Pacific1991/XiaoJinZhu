//
//  HCUrlArgumentsFilter.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/21.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCUrlArgumentsFilter : NSObject <YTKUrlFilterProtocol>
/// 给url追加arguments，用于全局参数，比如AppVersion, ApiVersion等
+ (HCUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;
@end
