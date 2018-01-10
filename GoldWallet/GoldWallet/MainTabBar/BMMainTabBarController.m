//
//  BMMainTabBarController.m
//  BosseManager
//
//  Created by AppleMini on 16/10/12.
//  Copyright © 2016年 BosseInformationTechnology. All rights reserved.
//

#import "BMMainTabBarController.h"

#import "HCHomeViewController.h"            //首页
#import "HCProductViewController.h"         //产品
#import "HCMallViewController.h"            //商城
#import "HCMineViewController.h"            //我的


static NSString * const KeyImageName = @"KeyImageName";
static NSString * const KeySelectedImageName = @"KeySelectedImageName";
static NSString * const KeyTitle = @"KeyTitle";

@interface BMMainTabBarController ()

/** item信息*/
@property (strong, nonatomic) NSArray <NSDictionary *> *itemInfoArr;

@end

@implementation BMMainTabBarController

- (NSArray <NSDictionary *> *)itemInfoArr
{
    if (!_itemInfoArr)
    {
        self.itemInfoArr = @[
                             @{
                                
                                KeyImageName:@"tab_home_normal",
                                KeySelectedImageName:@"tab_home_highlight",
                                KeyTitle:@"首页",
                               },
                             @{
                                 
                                 KeyImageName:@"tab_shop_normal",
                                 KeySelectedImageName:@"tab_shop_selected",
                                 KeyTitle:@"商城",
                              },
                             @{
                               
                                 KeyImageName:@"tab_service_normal",
                                 KeySelectedImageName:@"tab_service_selected",
                                 KeyTitle:@"服务",
                               },
                             @{
                                
                                 KeyImageName:@"tab_my_normal",
                                 KeySelectedImageName:@"tab_my_highlight",
                                 KeyTitle:@"我的",
                               }
                             ];
    }
    return _itemInfoArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContent];
}

- (void)setupContent {
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    [self.itemInfoArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull infoDic, NSUInteger index, BOOL * _Nonnull stop)
    {
        [self addTabWithIndex:index];
    }];
}
/** 添加Tab*/
- (void)addTabWithIndex:(NSUInteger)index {
    
    NSDictionary *infoDic = self.itemInfoArr[index];
    HCBaseNavigationController *nav = nil;
    if (index == 0) {           //首页
        
        nav = [[HCBaseNavigationController alloc] initWithRootViewController:[[HCHomeViewController alloc] init]];
    } else if (index == 1) {    //产品
        
        nav = [[HCBaseNavigationController alloc] initWithRootViewController:[[HCProductViewController alloc] init]];
    } else if (index == 2) {    //商城
        
        nav = [[HCBaseNavigationController alloc] initWithRootViewController:[[HCMallViewController alloc] init]];
    } else {                    //我的
        nav = [[HCBaseNavigationController alloc] initWithRootViewController:[[HCMineViewController alloc] init]];
    }
    
    if (!nav || ![nav isKindOfClass:[UINavigationController class]]) {
        
        NSLog(@"%@ 类型不正确",nav);
        return;
    }
    
    UIImage *image = [[UIImage imageNamed:[infoDic objectForKey:KeyImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIGraphicsBeginImageContext(CGSizeMake(20, 20));
//    [image drawInRect:CGRectMake(0.0f, 0.0f, 20, 20)];
//    image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    UIImage *selectedImage = [[UIImage imageNamed:[infoDic objectForKey:KeySelectedImageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    UIGraphicsBeginImageContext(CGSizeMake(22, 22));
//    [selectedImage drawInRect:CGRectMake(0.0f, 0.0f, 22, 22)];
//    selectedImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    //nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0,-5, 0);
  
    nav.topViewController.tabBarItem.image = image;
    nav.topViewController.tabBarItem.selectedImage = selectedImage;
    
    nav.topViewController.title = [infoDic objectForKey:KeyTitle];
    [nav.topViewController.tabBarItem setTitleTextAttributes:@{
                                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FE9E15"]
                                                 }
                                      forState:UIControlStateNormal];
    
    [nav.topViewController.tabBarItem setTitleTextAttributes:@{
                                                 NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FE9E15"]
                                                 }
                                      forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
}

#pragma mark - Public Method
/** 把所有的子控制器pop到根控制器下*/
- (void)popAllToRootVC {
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UINavigationController * _Nonnull nav, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [nav popToRootViewControllerAnimated:YES];
        if ([[nav.childViewControllers firstObject] isKindOfClass:[HCHomeViewController class]]) {
            
            HCHomeViewController *homeVC = [nav.childViewControllers firstObject];
            [homeVC.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull homeChildVC, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([homeChildVC isKindOfClass:NSClassFromString(@"BMUnlockViewController")]) {
                    
                    [homeChildVC.view removeFromSuperview];
                    [homeChildVC removeFromParentViewController];
                }
            }];
        }
    }];
}

@end
