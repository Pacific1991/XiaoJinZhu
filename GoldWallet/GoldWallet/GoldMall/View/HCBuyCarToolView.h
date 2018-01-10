//
//  HCBuyCarToolView.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/27.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCBuyCarModel.h"
typedef NS_ENUM(NSInteger, HCBuyCarToolViewType) {
    HCBuyCarToolViewBuy,
    HCBuyCarToolViewDelete
};
typedef void(^refreshTableView)(void);
@interface HCBuyCarToolView : UIView

@property (nonatomic, readwrite, assign) HCBuyCarToolViewType toolBarType;
@property (nonatomic, readwrite, strong) NSMutableArray<HCBuyCarModel *> *datalist;
@property (nonatomic, readwrite, copy) refreshTableView freshTableView;
@end
