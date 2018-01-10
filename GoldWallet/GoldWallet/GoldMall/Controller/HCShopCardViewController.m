//
//  HCShopCardViewController.m
//  GoldWallet
//
//  Created by sdd on 2018/1/10.
//  Copyright © 2018年 SYB. All rights reserved.
//

#import "HCShopCardViewController.h"

#import "HCBuyCarTableView.h"
#import "HCBuyCarToolView.h"

#import "HCShoppingCartListApi.h"
#import "HCShopCarRemoveGoodsApi.h"
#import "HCChangeShopCarNumApi.h"
#import "HCBuyCarModel.h"

@interface HCShopCardViewController ()<HCBuyCarTableViewDeledate>
@property (nonatomic, readwrite, strong) HCBuyCarTableView *tableView;
@property (nonatomic, readwrite, strong) HCBuyCarToolView *toolView;
@end

@implementation HCShopCardViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"#F6F6F6"]];
    [self.tableView loadTableData];
}

- (void)setupContent {
    
    self.tableView = [[HCBuyCarTableView alloc] initWithFrame:CGRectMake(0, kNavigationTitleHeight, kScreenWidth(), kScreenHeight() - kNavigationTitleHeight - 45.0f) style:UITableViewStylePlain];
    [self.tableView setUpdateDelegate:self];
    [self.view addSubview:self.tableView];
    self.toolView = [[HCBuyCarToolView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kScreenWidth(), 45.0f)];
    
    
    @weakify(self)
    self.toolView.freshTableView = ^{
        @strongify(self)
        [self.tableView reloadData];
    };
    [self.view addSubview:self.toolView];
}

#pragma mark - HCBuyCarTableViewDeledate
- (void)notificationUpdateGoodList:(HCBuyCarTableView *)tableView list:(NSMutableArray<HCBuyCarModel *> *)list {
    
    self.toolView.datalist = list;
    
    for (HCBuyCarModel * model in list) {
        
        HCChangeShopCarNumApi *api = [[HCChangeShopCarNumApi alloc] initWithGoodsID:model.cartID GoodsNum:model.goodsNum];
        
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
        }];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)requestData{
    HCShoppingCartListApi *api = [[HCShoppingCartListApi alloc] init];
    
    @weakify(self)
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        
        
        if ([request.responseObject[@"stateCode"] integerValue] == 200) {
            NSMutableArray * array = [[NSMutableArray alloc]init];
            
            for (NSDictionary *dic in request.responseObject[@"cartList"]) {
                HCBuyCarModel *model = [[HCBuyCarModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [array addObject:model];
            }
            self.tableView.dataArray = array;
            self.toolView.datalist = array;
            
            [self.tableView reloadData];
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        switch (request.faildOperationType) {
            case YTKRequstFaildOperationTypeModal: {
                HCBaseViewController *vc = [[request.oprationTargetCls alloc] init];
                vc.title = request.faildOperationArguments;
                [self presentViewController:vc animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
        NSLog(@"%ld", (long)request.responseStatusCode)
    }];
    
    
}
@end
