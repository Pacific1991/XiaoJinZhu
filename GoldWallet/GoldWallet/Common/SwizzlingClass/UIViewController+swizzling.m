//
//  UIViewController+swizzling.m
//  ZhongBao
//
//  Created by GKJX on 16/7/21.
//  Copyright © 2016年 YeYunchun. All rights reserved.
//

#import "UIViewController+swizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (swizzling)

+ (void)load {
    [super load];
    // didAppear
    Method didFromMethod = class_getInstanceMethod(self.class, @selector(viewDidAppear:));
    Method didToMethod = class_getInstanceMethod(self.class, @selector(swizzlingViewDidAppear:));
    if (!class_addMethod(self.class, @selector(viewDidAppear:), method_getImplementation(didToMethod), method_getTypeEncoding(didToMethod))) {
        method_exchangeImplementations(didFromMethod, didToMethod);
    }
    // willAppear
    Method fromMethod = class_getInstanceMethod(self.class, @selector(viewWillAppear:));
    Method toMethod = class_getInstanceMethod(self.class, @selector(swizzlingViewWillAppear:));
    if (!class_addMethod(self.class, @selector(viewWillAppear:), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
    //willDisappear
    Method disFromMethod = class_getInstanceMethod(self.class, @selector(viewWillDisappear:));
    Method disToMethod = class_getInstanceMethod(self.class, @selector(swizzlingViewWillDisappear:));
    if (!class_addMethod(self.class, @selector(viewWillDisappear:), method_getImplementation(disToMethod), method_getTypeEncoding(disToMethod))) {
        method_exchangeImplementations(disFromMethod, disToMethod);
    }
}

- (void)backToLast {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)swizzlingViewWillAppear:(BOOL)animated {
//    if ([self isMemberOfClass:NSClassFromString(@"RCAlumListTableViewController")] || [self isMemberOfClass:[UIImagePickerController class]]) {
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    }
//    if ([self isMemberOfClass:NSClassFromString(@"RCPhotosPickerController")]) {
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"相册列表" style:UIBarButtonItemStylePlain target:self action:@selector(backToLast)];
//        self.navigationItem.leftBarButtonItem = backItem;
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    }
    [self swizzlingViewWillAppear:animated];
}

- (void)swizzlingViewWillDisappear:(BOOL)animated {
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self swizzlingViewWillDisappear:animated];
}

- (void)swizzlingViewDidAppear:(BOOL)animated {
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    if(![str containsString:@"UI"]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSLog(@"统计打点Com : %@--%@", self.class, [formatter stringFromDate:[NSDate date]]);
    }
    [self swizzlingViewDidAppear:animated];
}

@end
