//
//  HCMallViewController.m
//  GoldWallet
//
//  Created by sdd on 2018/1/10.
//  Copyright © 2018年 SYB. All rights reserved.
//

#import "HCMallViewController.h"
#import "HCMallListVIew.h"
#import "HCMallHeadSearchView.h"
#import "HCShopCardViewController.h"
#import "HCSearchResultMallViewController.h"
@interface HCMallViewController ()<HCMallHeadSearchViewDelegate>

@property (nonatomic ,strong)HCMallListVIew * detailView;
@end

@implementation HCMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商城";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F3F4"];

    [self setUpNavigationInstance];
    
    _detailView = [[HCMallListVIew alloc] initWithFrame:CGRectMake(0, 64 +45*kHeightScale(), kScreenWidth(), kScreenHeight() - 64 - (44 + 45)*kHeightScale())];
    
    [self.view addSubview:_detailView];
    
    HCMallHeadSearchView *itemView = [HCMallHeadSearchView searchViewWithSearchResult:^(NSString *result) {
        NSLog(@"%@", result);
    }];
    itemView.delegate = self;
    itemView.searchmallTip = ^{
        
    };
    [self.view addSubview:itemView];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpNavigationInstance {
    
    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightBtn addTarget:self action:@selector(ShopingCard) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"nav_btn_shopcar"] forState:(UIControlStateNormal)];
    [rightBtn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)EnterSearchResult{
    HCSearchResultMallViewController * vc = [[HCSearchResultMallViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//购物车
- (void)ShopingCard{
    HCShopCardViewController *vc = [[HCShopCardViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)requestData{
    
}

@end
