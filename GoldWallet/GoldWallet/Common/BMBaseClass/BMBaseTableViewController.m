//
//  BMBaseTableViewController.m
//  BosseManager
//
//  Created by AppleMini on 2016/11/3.
//  Copyright © 2016年 BosseInformationTechnology. All rights reserved.
//

#import "BMBaseTableViewController.h"

@interface BMBaseTableViewController ()

@end

@implementation BMBaseTableViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initTitleView];
    [self initContent];
}

- (void)initTitleView
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_commen_back"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackDidClicked:)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)initContent
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = HCColor(232, 242, 244);
}

- (void)btnBackDidClicked:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Public Method
/** 隐藏导航返回按钮*/
- (void)hideNavigationBackItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

/** 初始化data 子类实现*/
- (void)setupData{}

/** 初始化title 子类实现*/
- (void)setupTitleView{}

/** 初始化content 子类实现*/
- (void)setupContent{}

/** 初始化notification 子类实现*/
- (void)setupNotification{}

@end
