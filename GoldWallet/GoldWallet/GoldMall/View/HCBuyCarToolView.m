//
//  HCBuyCarToolView.m
//  HealthClaims
//
//  Created by 李晋 on 2017/9/27.
//  Copyright © 2017年 fmf. All rights reserved.
//

#import "HCBuyCarToolView.h"
#import "HCShopCarRemoveGoodsApi.h"
@interface HCBuyCarToolView()
@property (nonatomic, readwrite, weak) UIButton *selectAllButton;
@property (nonatomic, readwrite, weak) UILabel *priceLabel;
@property (nonatomic, readwrite, weak) UIButton *submitButton;
@end
@implementation HCBuyCarToolView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.toolBarType = HCBuyCarToolViewBuy;
        [self setupUI];
    }
    return self;
}

- (void)setToolBarType:(HCBuyCarToolViewType)toolBarType {
    _toolBarType = toolBarType;
    _priceLabel.hidden = _toolBarType;
    _selectAllButton.selected = !_toolBarType;
    _submitButton.selected = _toolBarType;
}

- (void)setDatalist:(NSMutableArray<HCBuyCarModel *> *)datalist {
    _datalist = datalist;
    [self updateData];
}

- (void)updateData {
    BOOL selectAll = YES;
    BOOL haveSelected = NO;
    CGFloat allPrice = 0.00f;
    NSInteger buyCount = 0;
    if (!self.datalist.count) {
        selectAll = NO;
    }
    for (HCBuyCarModel *model in self.datalist) {
        if (model.isSelected == NO) {
            
            selectAll = NO;
        } else {
            haveSelected = YES;
            buyCount += [model.goodsNum integerValue];
            allPrice += ([model.goodsPrice floatValue] * [model.goodsNum integerValue]);
        }
    }
    
    _selectAllButton.selected = selectAll;
    [self setPriceLabelTextWithPriceString:[NSString stringWithFormat:@"%.2f", allPrice]];
    if (_toolBarType == HCBuyCarToolViewDelete) {
        if (haveSelected) {
            [_submitButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#F64619"]] forState:(UIControlStateSelected)];
        } else {
            [_submitButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#CCCCCC"]] forState:(UIControlStateSelected)];
        }
    } else {
        
        [_submitButton setTitle:[NSString stringWithFormat:@"去结算 (%ld)", buyCount] forState:UIControlStateNormal];
    }
}

#pragma mark - 布局View
- (void)setupUI {
    UIButton *selectAllButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [selectAllButton addTarget:self action:@selector(selectAllButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    selectAllButton.frame = CGRectMake(0, 0, self.bounds.size.width * 0.2f, self.bounds.size.height);
    [selectAllButton setTitle:@" 全选" forState:UIControlStateNormal];
    [selectAllButton setImage:[UIImage imageNamed:@"btn_select_normal"] forState:UIControlStateNormal];
    [selectAllButton setImage:[UIImage imageNamed:@"btn_pay_radio_selected"] forState:(UIControlStateSelected)];
    [selectAllButton setTitleColor:[UIColor colorWithHexString:@"#959595"] forState:UIControlStateNormal];
    selectAllButton.titleLabel.font = [UIFont systemFontOfSize:14*kWidthScale()];
//    selectAllButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
//    [selectAllButton verticalImageAndTitle:2.0f];
    _selectAllButton = selectAllButton;
    [self addSubview:_selectAllButton];
    
    UIButton *submitButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [submitButton addTarget:self action:@selector(submitButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    submitButton.frame = CGRectMake(self.bounds.size.width * 0.6, 0, self.bounds.size.width * 0.4, self.bounds.size.height);
    [submitButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#FF9F17"]] forState:(UIControlStateNormal)];
    [submitButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#FF9F17"]] forState:(UIControlStateSelected)];
    [submitButton setTitle:@"去结算 (0)" forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:17];
    _submitButton = submitButton;
    [self addSubview:_submitButton];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.2f, 0, self.bounds.size.width * 0.4f - 20*kWidthScale(), self.bounds.size.height)];
    priceLabel.textAlignment = NSTextAlignmentRight;
    [priceLabel setTextColor:[UIColor colorWithHexString:@"#FF9F17"]];
    [priceLabel setFont:[UIFont systemFontOfSize:23]];
    _priceLabel = priceLabel;
    [self setPriceLabelTextWithPriceString:@"0.00  "];
    [self addSubview:_priceLabel];
}

- (void)setPriceLabelTextWithPriceString:(NSString *)money {
    NSString *price = [NSString stringWithFormat:@"¥ %@  ", money];
    NSMutableAttributedString * mustr = [[NSMutableAttributedString alloc]initWithString:price];
    NSRange frontRange = [price rangeOfString:@""];
    NSRange iconRange = [price rangeOfString:@"¥ "];
    [mustr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FF9F17"] range:frontRange];
    [mustr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:23] range:iconRange];

    _priceLabel.attributedText = mustr;
}

#pragma mark - button click action
- (void)selectAllButtonClickAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.datalist setValue:@(sender.selected) forKey:@"_isSelected"];
    [self updateData];
    if (self.freshTableView) {
        self.freshTableView();
    }
}
- (void)submitButtonClickAction:(UIButton *)sender {
    if (self.datalist.count == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请添加商品到购物车" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }])];
        [self.viewController presentViewController:alertController animated:YES completion:nil];
        
    }
    if (self.toolBarType == HCBuyCarToolViewBuy) {
        NSMutableArray *orderArray = [@[] mutableCopy];
        for (HCBuyCarModel *model in self.datalist) {
            if (model.isSelected) {
                [orderArray addObject:model];
            }
        }
        
    } else {
        for (NSInteger i = self.datalist.count - 1; i >= 0; i--) {
            HCBuyCarModel *model = self.datalist[i];
            if (model.isSelected) {
                HCShopCarRemoveGoodsApi *api = [[HCShopCarRemoveGoodsApi alloc] initWithGoodsID:model.cartID Type:@1];
                
                [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    
                }];
                [self.datalist removeObject:model];
            }
        }

        [self updateData];
        if (self.freshTableView) {
            self.freshTableView();
        }
    }
}

@end
