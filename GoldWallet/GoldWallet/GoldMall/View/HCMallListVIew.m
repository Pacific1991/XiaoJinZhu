//
//  HCMallListVIew.m
//  GoldWallet
//
//  Created by sdd on 2018/1/10.
//  Copyright © 2018年 SYB. All rights reserved.
//

#import "HCMallListVIew.h"
#import "HCMallListCollectionViewCell.h"
#import "HCMallSectionCollectionReusableView.h"
#import "HCGoodDetailViewController.h"
@interface HCMallListVIew()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger _page;
    
}
@property (nonatomic, strong)UICollectionView * collectionView;

@property (nonatomic, strong)UICollectionViewFlowLayout * flowLayout;

@end
@implementation HCMallListVIew

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createAvatarView];
    }
    return self;
}
- (void)createAvatarView{
    self.backgroundColor = [UIColor colorWithHexString:@"#F2F3F4"];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout.minimumLineSpacing = 8;
    _flowLayout.minimumInteritemSpacing = 8;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth(), kScreenHeight() - 64 - (44 + 45)*kHeightScale()) collectionViewLayout:_flowLayout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    // 注册cell
    [_collectionView registerClass:[HCMallListCollectionViewCell class] forCellWithReuseIdentifier:HCMallListCollectionViewCellIdentifier];
    [_collectionView registerClass:[HCMallSectionCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HCMallSectionCollectionReusableViewIdentifier];

    self.userInteractionEnabled = YES;
    
    [self addSubview:_collectionView];
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HCMallListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HCMallListCollectionViewCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
        HCGoodDetailViewController * vc = [[HCGoodDetailViewController alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];
}

// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        HCMallSectionCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HCMallSectionCollectionReusableViewIdentifier forIndexPath:indexPath];
        reusableView = header;
    }
    return reusableView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/**
 itemSize
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(172*kWidthScale(), 181*kHeightScale());
}

// collection header 高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(kScreenWidth(), 50*kHeightScale());
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(4.0f, 12.0f, 4.0f, 12.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return Margin;
}

///**
// 第一次加载数据
// */
//- (void)loadDataListFirst {
//    if (!_dataArray) {
//        _dataArray = [@[] mutableCopy];
//        [HCRefreshTool beginRefreshing:self];
//    }
//}
//
///**
// 加载数据Func
// */
//- (void)loadDataWithRefresh:(BOOL)refresh {
//    HCPreferenceListApi *api = [[HCPreferenceListApi alloc] initWithGoodsType:self.loadTypeID page:refresh?1:_page];
//    //    api.animatingText = @"正在加载...";
//    //    api.animatingView = self.viewController.view;
//    @weakify(self)
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        if (!isNullOrNil(request.responseObject)) {
//            @strongify(self)
//            if ([request.responseObject[@"stateCode"] integerValue] != 200) {
//                //                [HUD hc_showTitleWith:request.responseObject[@"stateMsg"] timeout:2.0f];
//                [HCRefreshTool removeRefreshFooter:self];
//            } else {
//                if (refresh) {
//                    [self.dataArray removeAllObjects];
//                    _page = 2;
//                } else {
//
//                    _page += 1;
//                }
//                NSMutableArray<HCHomeGoodModel *> *array = [HCHomeGoodModel mj_objectArrayWithKeyValuesArray:request.responseObject[@"list"]];
//                [self.dataArray addObjectsFromArray:array];
//                [self reloadData];
//                if (![request.responseObject[@"list"] count]) {
//                    [HCRefreshTool removeRefreshFooter:self];
//                } else {
//                    [HCRefreshTool addRefreshFooter:self refreshingBlock:^{
//                        [HCRefreshTool addRefreshFooter:self refreshingBlock:^{
//                            [self loadDataWithRefresh:NO];
//                        }];
//                    }];
//                }
//            }
//        } else {
//            //            [HUD hc_showTitleWith:@"请检查网络" timeout:2.0f];
//            [HCRefreshTool removeRefreshFooter:self];
//        }
//        [HCRefreshTool endRefreshing:self];
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        @strongify(self)
//        [HUD hc_showTitleWith:@"请检查网络" timeout:2.0f];
//        [HCRefreshTool endRefreshing:self];
//        [HCRefreshTool removeRefreshFooter:self];
//    }];
//
//}
@end
