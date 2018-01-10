//
//  HCSwipeCollectionViewCell.h
//  HealthClaims
//
//  Created by 李晋 on 2017/9/27.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import <UIKit/UIKit.h>
extern NSString * const SwipeCollectionViewCurrentSwipeCell;

@interface HCSwipeCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIView *revealView;
/// default: YES, if you want to disable panGestureRecoginzer, you can use this property.
@property (nonatomic,assign) BOOL canSwiped;
/// optional: when only use default revealView, you maybe set this property, eg: xxx.deleteButtonTitle = @"delete"
@property (nonatomic,copy) NSString *deleteButtonTitle;
/// optional: when only use default revealView, you can use this function
@property (nonatomic,copy) void(^hc_delete)(void);

- (void)hideRevealViewAnimated:(BOOL)isAnimated;
@end
