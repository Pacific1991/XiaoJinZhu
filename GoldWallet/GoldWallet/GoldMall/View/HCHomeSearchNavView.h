//
//  HCHomeSearchNavView.h
//  GoldWallet
//
//  Created by sdd on 2018/1/10.
//  Copyright © 2018年 SYB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^messageTips)();
typedef void (^searchhHomeResult)(NSString *result);
@interface HCHomeSearchNavView : UIView
+ (instancetype)searchViewWithSearchResult:(searchhHomeResult)block;
@property (nonatomic, readwrite, copy) messageTips messageTip;
@end
