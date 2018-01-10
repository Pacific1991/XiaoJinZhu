//
//  HCBaseNavigationController.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/22.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCBaseNavigationController.h"
#import "HCBaseViewController.h"
@interface HCBaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation HCBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    navigationBar.translucent = YES;
//    [navigationBar setShadowImage:[[UIImage alloc] init]];
    [navigationBar setShadowImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#DEDEDE"]]];
//    [navigationBar setBarTintColor:[UIColor whiteColor]];
    [navigationBar setTintColor:HCColor(74.0, 74.0, 74.0)];   // 返回按钮颜色
    [navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#4a4a4a"], NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
//    UIImage *image = [UIImage imageNamed:@"leftarrow"];
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    navigationBar.backIndicatorImage = image;
//    navigationBar.titleTextAttributes
//    navigationBar.backIndicatorTransitionMaskImage = image;
}

- (void)pushViewController:(HCBaseViewController *)viewController animated:(BOOL)animated {
    HCBaseViewController *currentVC = self.viewControllers.lastObject;
    if (![viewController useTransparentNavigationBar] && ![currentVC useTransparentNavigationBar]) {
        self.shouldAddFakeNavigationBar = NO;
    } else {
        self.shouldAddFakeNavigationBar = YES;
    }
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    HCBaseViewController *previousVC = self.viewControllers[self.viewControllers.count - 2];
    HCBaseViewController *currentVC = self.viewControllers.lastObject;
    if (![currentVC useTransparentNavigationBar] && ![previousVC useTransparentNavigationBar]) {
        self.shouldAddFakeNavigationBar = NO;
    } else {
        self.shouldAddFakeNavigationBar = YES;
    }
    return [super popViewControllerAnimated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
