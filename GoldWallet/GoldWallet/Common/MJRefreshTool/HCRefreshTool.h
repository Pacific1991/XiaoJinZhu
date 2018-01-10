//
//  HCRefreshTool.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/21.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCRefreshTool : NSObject
+ (void)addRefreshHeader:(UIScrollView *)scrollView refreshingBlock:(dispatch_block_t)block;

+ (void)addRefreshFooter:(UIScrollView *)scrollView refreshingBlock:(dispatch_block_t)block;

+ (void)beginRefreshing:(UIScrollView *)view;

+ (void)endRefreshing:(UIScrollView *)view;

+ (void)noticeNoMore:(UIScrollView *)view;

+ (void)resetNoMore:(UIScrollView *)view;

+ (void)removeRefreshFooter:(UIScrollView *)scrollView;

+ (void)removeRefreshHeader:(UIScrollView *)scrollView;

@end
