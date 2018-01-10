//
//  HCBuyCarTableView.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/27.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCBuyCarTableView.h"

//#import "HCBuyCarFooterView.h"
#import "HCBuyCarGoodTableViewCell.h"
#import "HCShopCarRemoveGoodsApi.h"

#import "HCShoppingCartListApi.h"
#import "HCHomeGoodModel.h"
@interface HCBuyCarTableView()<UITableViewDelegate, UITableViewDataSource, HCBuyCarGoodTableViewCellDelegate> {
    BOOL _cellIsEditing;
}
@property (nonatomic, readwrite, strong) NSMutableArray *collectionDataArray;
//@property (nonatomic, readwrite, strong) HCBuyCarFooterView *footerView;
@end
@implementation HCBuyCarTableView

- (NSMutableArray *)collectionDataArray {
    if (!_collectionDataArray) {
        _collectionDataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _collectionDataArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithHexString:@"#F6F6F6"]];
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _cellIsEditing = NO;
        _typeDelete = NO;
//        self.tableFooterView = self.footerView;
        [self registerClass:[HCBuyCarGoodTableViewCell class] forCellReuseIdentifier:HCBuyCarGoodTableViewCellIdentifier];
        [self setDelegate:self];
        [self setDataSource:self];
        
        [self reloadFooterCollectionView];
        [HCRefreshTool addRefreshFooter:self refreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [HCRefreshTool endRefreshing:self];
                [self requestData];
               
            });
        }];
        [self requestData];

       
    }
    return self;
}

- (void)setTypeDelete:(BOOL)typeDelete {
    _typeDelete = typeDelete;
    if (_typeDelete == YES) {
//        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.dataArray copyItems:YES];
        [self.dataArray setValue:@(NO) forKey:@"_isSelected"];
        [self reloadData];
    } else {
        [self.dataArray setValue:@(YES) forKey:@"_isSelected"];
        [self reloadData];
    }
    [self notiToolBarUpdateListData];
}

#pragma mark - 加载TableView数据
- (void)loadTableData {

    [self notiToolBarUpdateListData];
    [self reloadData];
}

/// 模拟加载 footer数据
- (void)reloadFooterCollectionView {

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 105.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HCBuyCarGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HCBuyCarGoodTableViewCellIdentifier forIndexPath:indexPath];
    [cell setDelegate: self];
    cell.isDelete = _typeDelete;
    cell.model = self.dataArray[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_typeDelete) {          /// 删除
        
        HCBuyCarModel *model = self.dataArray[indexPath.section];
        model.isSelected = !model.isSelected;
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        [self notiToolBarUpdateListData];
    } else {                    /// 编辑
        
        if (_cellIsEditing) {
            
            [self endEditing:YES];
            [self notiToolBarUpdateListData];
        } else {
            NSLog(@"tap cell to do....")
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _cellIsEditing = NO;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 从数据源中删除
    HCBuyCarModel *model = self.dataArray[indexPath.section];
    [self removeShopCarGoodWith:model];

    [self.dataArray removeObjectAtIndex:indexPath.section];
    // 从列表中删除
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    [self notiToolBarUpdateListData];
}
- (void)removeShopCarGoodWith:(HCBuyCarModel*)model{
    HCShopCarRemoveGoodsApi *api = [[HCShopCarRemoveGoodsApi alloc] initWithGoodsID:model.cartID Type:@1];
    
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}
- (void)notiToolBarUpdateListData {
    if (self.updateDelegate && [self.updateDelegate respondsToSelector:@selector(notificationUpdateGoodList:list:)]) {
        [self.updateDelegate notificationUpdateGoodList:self list:self.dataArray];
    }
}

#pragma mark - HCBuyCarGoodTableViewCellDelegate
- (void)buyCarCellDidEndEditing:(HCBuyCarGoodTableViewCell *)cell buyCarModel:(HCBuyCarModel *)model {
    
    [self notiToolBarUpdateListData];
    if ([model.goodsNum integerValue] == 0) {
        [self.dataArray removeObject:model];
        [self deleteSections:[NSIndexSet indexSetWithIndex:[self indexPathForCell:cell].section] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)buyCarCellDidBeginEditing:(HCBuyCarGoodTableViewCell *)cell {
    _cellIsEditing = YES;
}
- (void)requestData{
    HCShoppingCartListApi *api = [[HCShoppingCartListApi alloc] init];
    
    @weakify(self)
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        @strongify(self)
        
        
        if ([request.responseObject[@"stateCode"] integerValue] == 200) {
            NSMutableArray * array = [[NSMutableArray alloc]init];
            if (!isNullOrNil(request.responseObject[@"info"])) {
                for (NSDictionary *dic in request.responseObject[@"info"]) {
                    HCHomeGoodModel *model = [[HCHomeGoodModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [array addObject:model];
                }
                self.collectionDataArray = array;
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
       
    }];
    
}
@end
