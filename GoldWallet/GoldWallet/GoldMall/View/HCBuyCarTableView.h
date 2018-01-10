//
//  HCBuyCarTableView.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/27.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCBuyCarModel.h"

@class HCBuyCarTableView;
@protocol HCBuyCarTableViewDeledate<NSObject>
- (void)notificationUpdateGoodList:(HCBuyCarTableView *)tableView list:(NSMutableArray<HCBuyCarModel *> *)list;
@end
@interface HCBuyCarTableView : UITableView
@property (nonatomic, readwrite, assign) id<HCBuyCarTableViewDeledate> updateDelegate;
@property (nonatomic, readwrite, assign) BOOL typeDelete;

@property (nonatomic, readwrite, strong) NSMutableArray<HCBuyCarModel *> *dataArray;

#pragma mark - 加载TableView数据
- (void)loadTableData;
@end
