//
//  HCCleanCache.h
//  HealthClaims
//
//  Created by sdd on 2017/11/18.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^cleanCacheBlock)();

@interface HCCleanCache : NSObject
/**
 *  清理缓存
 */
+(void)cleanCache:(cleanCacheBlock)block;
/**
 *  整个缓存目录的大小
 */
+(float)folderSizeAtPath;
@end
