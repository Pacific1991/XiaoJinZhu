//
//  HCSearchResultMallViewController.m
//  GoldWallet
//
//  Created by sdd on 2018/1/10.
//  Copyright © 2018年 SYB. All rights reserved.
//

#import "HCSearchResultMallViewController.h"
#import "HCMallListCollectionViewCell.h"
#import "HCHomeSearchNavView.h"
@interface HCSearchResultMallViewController()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger _page;
}
@property (nonatomic, strong)UICollectionView * collectionView;

@property (nonatomic, strong)UICollectionViewFlowLayout * flowLayout;

@property (nonatomic, strong)HCHomeSearchNavView * navView;

@end

@implementation HCSearchResultMallViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createAvatarView];
    
    self.navView = [HCHomeSearchNavView searchViewWithSearchResult:^(NSString *result) {
    }];
    
    _navView.messageTip = ^{
       
    };
    [self.view addSubview: self.navView];
    
    
    // Do any additional setup after loading the view.
}
- (BOOL)useTransparentNavigationBar{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)createAvatarView{
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F3F4"];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout.minimumLineSpacing = 8;
    _flowLayout.minimumInteritemSpacing = 8;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,64, kScreenWidth(), kScreenHeight() - 64) collectionViewLayout:_flowLayout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    _collectionView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    // 注册cell
    [_collectionView registerClass:[HCMallListCollectionViewCell class] forCellWithReuseIdentifier:HCMallListCollectionViewCellIdentifier];
    
    self.view.userInteractionEnabled = YES;
    
    [self.view addSubview:_collectionView];
    
}

- (void)registClasses {
    //    [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HCOptimizationListViewHeader"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HCMallListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HCMallListCollectionViewCellIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    //
    //    HCGoodDetailViewController * vc = [[HCGoodDetailViewController alloc] init];
    //    vc.goodmodel = self.dataArray[indexPath.item];
    //    [self.viewController.navigationController pushViewController:vc animated:YES];
}

//// 设置headerView和footerView的
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *reusableView = nil;
//    if (kind == UICollectionElementKindSectionHeader) {
//
//        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HCOptimizationListViewHeader" forIndexPath:indexPath];
//        reusableView = header;
//    }
//    return reusableView;
//}

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
    
    return CGSizeMake(kScreenWidth(), Margin);
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView
                         layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(4.0f, 12.0f, 4.0f, 12.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return Margin;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
