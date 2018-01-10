//
//  HCBaseViewController.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/22.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCBaseViewController.h"
#import "HCBaseNavigationController.h"
#import "UIViewController+HideBottomLine.h"
@interface HCBaseViewController ()
@end

@implementation HCBaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    [self removeFakeNavBar];
    if (((HCBaseNavigationController *)self.navigationController).shouldAddFakeNavigationBar) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self hideBottomLineInView:self.navigationController.navigationBar];
        //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
        [self addFakeNavBar];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    if (![self useTransparentNavigationBar]) {
        self.navigationController.navigationBar.barStyle = UINavigationBar.appearance.barStyle;
        self.navigationController.navigationBar.translucent = YES;
        [self.navigationController.navigationBar setBackgroundImage:[UINavigationBar.appearance backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
        [self showBottomLineInView:self.navigationController.navigationBar];
        //[self.navigationController.navigationBar setShadowImage:[UINavigationBar.appearance shadowImage]];
    }
    [self removeFakeNavBar];
    if (self.navigationController.viewControllers.count > 1) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeFakeNavBar];
    if (((HCBaseNavigationController *)self.navigationController).shouldAddFakeNavigationBar) {
        [self addFakeNavBar];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self removeFakeNavBar];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _bar = [[UINavigationBar alloc] init];
        _bar.barStyle = UINavigationBar.appearance.barStyle;
        _bar.translucent = YES;
        [_bar setFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 64)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self settingNavigationClas];   // 设置Navi
    [self setUpBaseNotifications];  // 设置类通知
    [self setupNotification];       // 子类自定义通知调用
    [self setupContent];            // 子类自定义UI配置
    [self definitionNavigation];    // 子类定义Navigation
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0f], NSFontAttributeName,[UIColor colorWithHexString:@"#4a4a4a"], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self requestData];             // 子类自定义数据请求
}

- (void)customNavigationBackItemWithBackImageName:(NSString *)imageName Title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)titleColor{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (imageName.length) {
        
        [button setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    }else{
        
        [button setImage:[UIImage imageNamed:@"nav_back_black"] forState:(UIControlStateNormal)];
    }
    [button setTitle:title forState:(UIControlStateNormal)];
    [button.titleLabel setFont:font];
    [button setTitleColor:titleColor forState:(UIControlStateNormal)];
    [button sizeToFit];
    button.width = button.frame.size.width + Margin;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, Margin, 0, 0);
    [button setHitTestEdgeInsets:UIEdgeInsetsMake(-50, -50, -50, -50)];

    [button addTarget:self action:@selector(backMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)customNavigationBackItemWithBackImageName:(NSString *)imageName Title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)titleColor selector:(SEL)selector{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    if (imageName.length) {
        
        [button setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    }else{
        
        [button setImage:[UIImage imageNamed:@"nav_back_black"] forState:(UIControlStateNormal)];
    }
    [button setTitle:title forState:(UIControlStateNormal)];
    [button.titleLabel setFont:font];
    [button setTitleColor:titleColor forState:(UIControlStateNormal)];
    [button sizeToFit];
    button.width = button.frame.size.width + Margin;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, Margin, 0, 0);
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)customRightBarItemWithImage:(UIImage *)image selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setImage:image forState:(UIControlStateNormal)];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = right;
}

#pragma mark - NavigationClass
- (void)settingNavigationClas {
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    //添加返回按钮
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"leftarrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backMethod:)];
    }
}

#pragma mark - 通知
- (void)setUpBaseNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 返回
- (void)backMethod:(UIBarButtonItem *)item {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addFakeNavBar {
    
    [self.view addSubview:_bar];
    if ([self useTransparentNavigationBar]) {
        [_bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [self hideBottomLineInView:_bar];
        //[_bar setShadowImage:[UIImage new]];
    } else {
        [_bar setBackgroundImage:[UINavigationBar.appearance backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
        [self showBottomLineInView:_bar];
        //[_bar setShadowImage:[UINavigationBar.appearance shadowImage]];
    }
}

- (void)removeFakeNavBar {
    if (_bar.superview) {
        [_bar removeFromSuperview];
    }
}

#pragma NavigationBar透明
- (BOOL)useTransparentNavigationBar {
    return NO;
}

#pragma mark - NSNotification Method
- (void)appDidEnterBackground:(NSNotification *)noti {
    [self.view endEditing:YES];
    [self didEnterBackground];
}

/**键盘将要弹出*/
- (void)keyBoardChange:(NSNotification *)noti {
    //设置窗口的颜色
    self.view.window.backgroundColor = self.view.backgroundColor;
    //取出键盘动画的时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //取得键盘最后的frame
    CGRect keyboardFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self keyboardWillChangeFrame:keyboardFrame duration:duration];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/** 初始化data 子类实现*/
- (void)requestData{}

/** 初始化title 子类实现*/
- (void)setupTitleView{}

/** 初始化content 子类实现*/
- (void)setupContent{}

- (void)definitionNavigation{}

/** 初始化notification 子类实现*/
- (void)setupNotification{}

/**
 进入后台, 子类自处理操作
 */
- (void)didEnterBackground {}

/**
 键盘弹起回调

 @param frame 键盘Frame
 @param duration 动画时间
 */
- (void)keyboardWillChangeFrame:(CGRect)frame duration:(NSTimeInterval)duration {
    //计算控制器的view需要平移的距离
    //CGFloat transformY = frame.origin.y - self.view.frame.size.height;
}

/**
 子类dealloc调用
 */
- (void)subClassDealloc {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self subClassDealloc];
}

@end
