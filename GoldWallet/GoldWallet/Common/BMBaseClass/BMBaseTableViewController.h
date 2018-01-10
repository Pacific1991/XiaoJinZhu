//
//  BMBaseTableViewController.h
//  BosseManager
//
//  Created by AppleMini on 2016/11/3.
//  Copyright © 2016年 BosseInformationTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMBaseTableViewController : UITableViewController

/** 隐藏导航返回按钮*/
- (void)hideNavigationBackItem;

/** 初始化data 子类实现*/
- (void)setupData;

/** 初始化title 子类实现*/
- (void)setupTitleView;

/** 初始化content 子类实现*/
- (void)setupContent;

/** 初始化notification 子类实现*/
- (void)setupNotification;

@end
