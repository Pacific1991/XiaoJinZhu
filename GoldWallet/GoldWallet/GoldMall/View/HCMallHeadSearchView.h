//
//  HCMallHeadSearchView.h
//  GoldWallet
//
//  Created by sdd on 2018/1/10.
//  Copyright © 2018年 SYB. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^searchmall)(void);
typedef void (^searchResult)(NSString *result);

@protocol HCMallHeadSearchViewDelegate <NSObject>

- (void)EnterSearchResult;

@end
@interface HCMallHeadSearchView : UIView
+ (instancetype)searchViewWithSearchResult:(searchResult)block;
@property (nonatomic, readwrite, copy) searchmall searchmallTip;
@property (nonatomic, weak) id<HCMallHeadSearchViewDelegate> delegate;
@end
