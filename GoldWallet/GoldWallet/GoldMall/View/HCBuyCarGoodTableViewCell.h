//
//  HCBuyCarGoodTableViewCell.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/27.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCBuyCarModel.h"
@class HCBuyCarGoodTableViewCell;
@protocol HCBuyCarGoodTableViewCellDelegate <NSObject>

- (void)buyCarCellDidEndEditing:(HCBuyCarGoodTableViewCell *)cell buyCarModel:(HCBuyCarModel *)model;

- (void)buyCarCellDidBeginEditing:(HCBuyCarGoodTableViewCell *)cell;

@end

static NSString * const HCBuyCarGoodTableViewCellIdentifier = @"HCBuyCarGoodTableViewCellIdentifier";
@interface HCBuyCarGoodTableViewCell : UITableViewCell
@property (nonatomic, readwrite, assign) BOOL isDelete;
@property (nonatomic, readonly, weak) UITextField *buyCountTextField;
@property (nonatomic, readwrite, assign) id<HCBuyCarGoodTableViewCellDelegate> delegate;
@property (nonatomic, readwrite, strong) HCBuyCarModel *model;
@end
