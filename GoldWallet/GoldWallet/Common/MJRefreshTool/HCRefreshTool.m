//
//  HCRefreshTool.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/21.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCRefreshTool.h"
#import <MJRefresh.h>
@implementation HCRefreshTool
+ (void)endRefreshing:(UIScrollView *)view {
    if (view.mj_header.isRefreshing) {
        [view.mj_header endRefreshing];
    }
    if (view.mj_footer.isRefreshing) {
        [view.mj_footer endRefreshing];
    }
}

+ (void)noticeNoMore:(UIScrollView *)view {
    [view.mj_footer endRefreshingWithNoMoreData];
}

+ (void)beginRefreshing:(UIScrollView *)view {
    if (!view.mj_header.isRefreshing) {
        [view.mj_header beginRefreshing];
    }
}

+ (void)resetNoMore:(UIScrollView *)view {
    [view.mj_footer resetNoMoreData];
}

+ (void)addRefreshHeader:(UIScrollView *)scrollView refreshingBlock:(dispatch_block_t)block {
    
    
    
    MJRefreshGifHeader *headr = [MJRefreshGifHeader headerWithRefreshingBlock:block];
//    headr.stateLabel.hidden = YES;
    headr.lastUpdatedTimeLabel.hidden = YES;
    
    [headr setImages:@[[UIImage imageNamed:@"MJRefresh_image_Header"]] forState:MJRefreshStateIdle];
    [headr setImages:@[[UIImage imageNamed:@"MJRefresh_image_Header"]] forState:MJRefreshStateRefreshing];

    headr.automaticallyChangeAlpha = YES;
    
    scrollView.mj_header = headr;
    
}

+ (void)addRefreshFooter:(UIScrollView *)scrollView refreshingBlock:(dispatch_block_t)block {
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
    

    footer.automaticallyChangeAlpha = YES;
    
    scrollView.mj_footer = footer;
}

+ (void)removeRefreshFooter:(UIScrollView *)scrollView {
    scrollView.mj_footer = nil;
}

+ (void)removeRefreshHeader:(UIScrollView *)scrollView {
    scrollView.mj_header = nil;
}

@end
